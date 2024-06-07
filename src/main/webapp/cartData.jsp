<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*, java.util.*, oracle.jdbc.OracleTypes, oracle.jdbc.*" %>
<%
  String dbDriver = "oracle.jdbc.driver.OracleDriver";
  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
  String dbUser = "dbProject";
  String dbPasswd = "000828";
  Connection conn = null;
  CallableStatement cstmt = null;
  ResultSet rs = null;
  List<Map<String, Object>> cartItems = new ArrayList<>();

  // 세션에서 로그인된 사용자 ID 가져오기
  String user = (String) session.getAttribute("user");
  if (user == null) {
    // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    response.sendRedirect("login_page.jsp");
    return;
  }

  // 수량 업데이트 처리
  if ("POST".equalsIgnoreCase(request.getMethod()) && "updateQuantity".equals(request.getParameter("action"))) {
    int menuNum = Integer.parseInt(request.getParameter("menuNum"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    try {
      Class.forName(dbDriver);
      conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
      String sql = "UPDATE cart SET count = ? WHERE user_id = ? AND menu_num = ?";
      cstmt = conn.prepareCall(sql);
      cstmt.setInt(1, quantity);
      cstmt.setInt(2, Integer.parseInt(user));
      cstmt.setInt(3, menuNum);
      cstmt.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (cstmt != null) try { cstmt.close(); } catch (SQLException ignore) {}
      if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
    response.getWriter().write("success");
    return;
  }

  // 항목 삭제 처리
  if ("POST".equalsIgnoreCase(request.getMethod()) && "deleteItems".equals(request.getParameter("action"))) {
    String[] menuNums = request.getParameter("menuNums").split(",");

    try {
      Class.forName(dbDriver);
      conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
      String sql = "DELETE FROM cart WHERE user_id = ? AND menu_num = ?";
      cstmt = conn.prepareCall(sql);
      for (String menuNum : menuNums) {
        cstmt.setInt(1, Integer.parseInt(user));
        cstmt.setInt(2, Integer.parseInt(menuNum.trim())); // 쉼표 제거 후 변환
        cstmt.addBatch();
      }
      cstmt.executeBatch();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (cstmt != null) try { cstmt.close(); } catch (SQLException ignore) {}
      if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
    response.getWriter().write("success");
    return;
  }

  // 카트 아이템 다시 로드
  try {
    Class.forName(dbDriver);
    conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

    cstmt = conn.prepareCall("{call get_cart_items(?, ?)}");
    cstmt.setInt(1, Integer.parseInt(user));
    cstmt.registerOutParameter(2, OracleTypes.CURSOR);
    cstmt.execute();

    rs = (ResultSet) cstmt.getObject(2);

    while (rs.next()) {
      Map<String, Object> item = new HashMap<>();
      item.put("cafeteriaCode", rs.getString("cafeteria_code"));
      item.put("menuNum", rs.getInt("menu_num"));
      item.put("menuName", rs.getString("menu_name"));
      item.put("price", rs.getInt("menu_price"));
      item.put("count", rs.getInt("count"));
      cartItems.add(item);
    }
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (cstmt != null) try { cstmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
  }

  request.setAttribute("cartItems", cartItems);
%>