<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*, java.util.*, oracle.jdbc.OracleTypes, oracle.jdbc.*"%>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
</head>
<body>

<%
    String user_name = request.getParameter("user_name");
    String user_id = request.getParameter("user_id");
    String nickname = Optional.ofNullable(request.getParameter("nickname")).filter(n -> !n.trim().isEmpty()).orElse(user_name);
    String user_password = request.getParameter("user_password");

    Connection myConn = null;
    CallableStatement cstmt = null;
    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@//localhost:1521/xe"; // Update with your DB details
    String dbUser = "dbProject"; // Update with your DB username
    String dbPasswd = "000828"; // Update with your DB password

    try {
        Class.forName(dbDriver);
        myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

        // PL/SQL 프로시저 호출
        String plsql = "{call register_user(?, ?, ?, ?, ?)}";
        cstmt = myConn.prepareCall(plsql);
        cstmt.setString(1, user_name);
        cstmt.setString(2, user_id);
        cstmt.setString(3, user_password);
        cstmt.setString(4, nickname);
        cstmt.registerOutParameter(5, Types.VARCHAR);

        cstmt.execute();
        
        // 결과 메시지 가져오기
        String result = cstmt.getString(5);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("login_page.jsp?register_success=true");
        } else {
            response.sendRedirect("register.jsp?register_err=" + URLEncoder.encode(result, "UTF-8"));
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        if (cstmt != null) try { cstmt.close(); } catch (SQLException ex) {}
        if (myConn != null) try { myConn.close(); } catch (SQLException ex) {}
    }
%>

<a href="login_page.jsp">로그인 페이지</a>

</body>
</html>