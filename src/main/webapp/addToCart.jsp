<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
  // 세션에서 로그인된 사용자 ID 가져오기
  String user = (String) session.getAttribute("user");
  if (user == null) {
    // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    response.sendRedirect("login_page.jsp");
    return;
  }

  // 파라미터 값 가져오기
  String cafeteria_code = request.getParameter("cafeteria_code");
  String menu_num_str = request.getParameter("menu_num");
  String count_str = request.getParameter("count");

  int menu_num = Integer.parseInt(menu_num_str);
  int count = Integer.parseInt(count_str);


  String dbDriver = "oracle.jdbc.driver.OracleDriver";
  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
  String dbUser = "dbProject"; // Update with your DB username
  String dbPasswd = "000828"; // Update with your DB password
  Connection myConn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String menu_name = "";
  int menu_price = 0;

  try {
    Class.forName(dbDriver);
    myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

    // menu_num에 맞는 menu_name과 menu_price 가져오기
    String menuSql = "SELECT menu_name, menu_price FROM menu WHERE menu_num = ?";
    pstmt = myConn.prepareStatement(menuSql);
    pstmt.setInt(1, menu_num);
    rs = pstmt.executeQuery();

    if (rs.next()) {
      menu_name = rs.getString("menu_name");
      menu_price = rs.getInt("menu_price");
    } else {
      throw new Exception("Menu name not found for given menu number.");
    }
    rs.close();
    pstmt.close();

    // 장바구니에 존재하는지 확인
    String checkSql = "SELECT count FROM cart WHERE user_id = ? AND menu_num = ?";
    pstmt = myConn.prepareStatement(checkSql);
    pstmt.setInt(1, Integer.parseInt(user));
    pstmt.setInt(2, menu_num);
    rs = pstmt.executeQuery();

    if (rs.next()) {
      // 장바구니에 있다면 update
      int existingCount = rs.getInt("count");
      int newCount = existingCount + count;
      rs.close();
      pstmt.close();

      String updateSql = "UPDATE cart SET count = ? WHERE user_id = ? AND menu_num = ?";
      pstmt = myConn.prepareStatement(updateSql);
      pstmt.setInt(1, newCount);
      pstmt.setInt(2, Integer.parseInt(user));
      pstmt.setInt(3, menu_num);
      pstmt.executeUpdate();
    } else {
      rs.close();
      pstmt.close();

      // 장바구니에 없다면 insert
      String insertSql = "INSERT INTO cart (user_id, cafeteria_code, menu_num, menu_name, menu_price, count) VALUES (?, ?, ?, ?, ?, ?)";
      pstmt = myConn.prepareStatement(insertSql);
      pstmt.setInt(1, Integer.parseInt(user));
      pstmt.setString(2, cafeteria_code);
      pstmt.setInt(3, menu_num);
      pstmt.setString(4, menu_name);
      pstmt.setInt(5, menu_price);
      pstmt.setInt(6, count);
      pstmt.executeUpdate();
    }
  } catch(Exception e) {
    e.printStackTrace();
  } finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (myConn != null) try { myConn.close(); } catch (SQLException e) { e.printStackTrace(); }
  }

  response.sendRedirect(request.getHeader("Referer"));
%>