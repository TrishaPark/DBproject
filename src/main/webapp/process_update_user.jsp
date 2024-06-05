<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>회원정보 수정 처리</title>
</head>

<body>

<%
	String user_id = (String) session.getAttribute("user");
    String user_name = request.getParameter("user_name");
    String user_password = request.getParameter("user_password");
    String nickname = request.getParameter("nickname");

    Connection myConn = null;
    PreparedStatement pstmt = null;
    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
    String dbUser = "dbProject"; // Update with your DB username
    String dbPasswd = "000828"; // Update with your DB password

    try {
        Class.forName(dbDriver);
        myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

        String sql = "UPDATE user_info SET user_password = ?, nickname = ? WHERE user_id = ?";
        pstmt = myConn.prepareStatement(sql);        
        pstmt.setString(1, user_password);
        pstmt.setString(2, nickname);
        pstmt.setString(3, user_id);

        int count = pstmt.executeUpdate();

        if(count > 0) {
            out.println("<script>");
            out.println("alert('정보가 성공적으로 업데이트되었습니다.');");
            out.println("window.opener.location.reload();");
            out.println("window.close();");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('업데이트에 실패했습니다.');");
            out.println("window.history.back();");
            out.println("</script>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if(myConn != null) try { myConn.close(); } catch(SQLException ex) {}
    }
%>

</body>
</html>
