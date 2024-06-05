<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
String user_id=request.getParameter("user_id");
String user_password=request.getParameter("user_password");
String dbDriver = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
String dbUser = "dbProject"; // Update with your DB username
String dbPasswd = "000828"; // Update with your DB password

Connection myConn = null;
Statement stmt = null;
ResultSet rs = null;
boolean isValidUser = false;

try {
    Class.forName(dbDriver);
    myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
    String mySQL = "SELECT user_id FROM user_info WHERE user_id='" + user_id + "' AND user_password ='" + user_password + "'";
    stmt = myConn.createStatement();
    rs = stmt.executeQuery(mySQL);
    
    if (rs.next()) {
        isValidUser = true;
        
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (myConn != null) myConn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

if (isValidUser) {
    session.setAttribute("user", user_id);
    
    response.sendRedirect("home_page.jsp");
} else {
    
    response.sendRedirect("login_page.jsp?error=true");
}
%>