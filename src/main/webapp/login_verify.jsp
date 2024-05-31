<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1916008";
String passwd = "ss2";

Connection myConn = null;
Statement stmt = null;
ResultSet rs = null;
boolean isValidUser = false;

try {
    Class.forName(dbdriver);
    myConn = DriverManager.getConnection(dburl, user, passwd);
    String mySQL = "SELECT s_id FROM student WHERE s_id='" + userID + "' AND s_pwd='" + userPassword + "'";
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
    session.setAttribute("user", userID);
    response.sendRedirect("main.jsp");
} else {
    
    response.sendRedirect("login_page.jsp?error=true");
}
%>