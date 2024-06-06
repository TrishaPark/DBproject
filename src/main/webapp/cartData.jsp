<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*, java.util.*" %>
<%
  String dbDriver = "oracle.jdbc.driver.OracleDriver";
  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
  String dbUser = "dbProject";
  String dbPasswd = "000828";
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  List<Map<String, Object>> cartItems = new ArrayList<>();

  // 세션에서 로그인된 사용자 ID 가져오기
  String user = (String) session.getAttribute("user");
  if (user == null) {
    // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    response.sendRedirect("login_page.jsp");
    return;
  }

  try {
    Class.forName(dbDriver);
    conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

    String sql = "SELECT cafeteria_code, menu_num, menu_name, menu_price, count FROM cart WHERE user_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(user));
    rs = pstmt.executeQuery();

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
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
  }

  request.setAttribute("cartItems", cartItems);
%>