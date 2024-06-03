<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
</head>
<body>

<%
	
    String user_name = request.getParameter("user_name");
    String user_id = request.getParameter("user_id");
    String nickname = request.getParameter("nickname");
    String user_password = request.getParameter("user_password");

    if (nickname == null || nickname.trim().isEmpty()) {
        nickname = user_name;
    }
    
    Connection myConn = null;
    PreparedStatement pstmt = null;
    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
    String dbUser = "dbProject"; // Update with your DB username
    String dbPasswd = "000828"; // Update with your DB password

    try {
    	Class.forName(dbDriver);
        myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

        String sql = "INSERT INTO user_info (user_name, user_id, user_password, nickname) VALUES (?, ?, ?, ?)";
        pstmt = myConn.prepareStatement(sql);
        pstmt.setString(1, user_name);
        pstmt.setString(2, user_id);
        pstmt.setString(3, user_password);
        pstmt.setString(4, nickname);
        

        int count = pstmt.executeUpdate();
        
        if(count > 0) {
        	response.sendRedirect("login_page.jsp?register_success=true");
            
        } else {
        	response.sendRedirect("register.jsp?register_err=true");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if(myConn != null) try { myConn.close(); } catch(SQLException ex) {}
    }
%>

<a href="login_page.jsp">로그인 페이지</a>

</body>
</html>