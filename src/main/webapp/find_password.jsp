<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/lost_password_style.css">
    <title>비밀번호 찾기 결과</title>
</head>
<body>
    <div class="lost_password-container">
        <%
            String user_name = request.getParameter("user_name");
            String user_id = request.getParameter("user_id");

            String dbDriver = "oracle.jdbc.driver.OracleDriver";
            String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
            String dbUser = "dbProject"; // Update with your DB username
            String dbPasswd = "000828"; // Update with your DB password

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Load the Oracle JDBC driver
                Class.forName(dbDriver);

                // Establish a connection
                conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

                // Prepare the SQL query
                String sql = "SELECT user_password FROM users WHERE user_id = ? AND user_name = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, user_name);
                pstmt.setString(2, user_id);

                // Execute the query
                rs = pstmt.executeQuery();

                // Check if a result was returned
                if (rs.next()) {
                    String user_password = rs.getString("user_password");
                    out.println("<p>비밀번호: " + user_password + "</p>");
                } else {
                    out.println("<p>입력하신 정보와 일치하는 사용자를 찾을 수 없습니다.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>SQL 오류가 발생했습니다: " + e.getMessage() + "</p>");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<p>JDBC 드라이버를 찾을 수 없습니다: " + e.getMessage() + "</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>알 수 없는 오류가 발생했습니다: " + e.getMessage() + "</p>");
            } finally {
                // Ensure the result set, prepared statement, and connection are closed
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        <a href="login_page.jsp">로그인 페이지로 돌아가기</a>
    </div>
</body>
</html>