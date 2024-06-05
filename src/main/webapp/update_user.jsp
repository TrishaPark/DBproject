<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" type="text/css" href="css/update_user_style.css">
</head>

<body>

<%
    String user_id = (String) session.getAttribute("user");
    Connection myConn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
    String dbUser = "dbProject"; // Update with your DB username
    String dbPasswd = "000828"; // Update with your DB password

    try {
        Class.forName(dbDriver);
        myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

        String sql = "SELECT user_name, user_password, nickname FROM user_info WHERE user_id = ?";
        pstmt = myConn.prepareStatement(sql);
        pstmt.setString(1, user_id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String user_name = rs.getString("user_name");
            String user_password = rs.getString("user_password");
            String nickname = rs.getString("nickname");
%>
<div class="update-user-container">
            <form action="process_update_user.jsp" method="post">
                <input type="hidden" name="user_id" value="<%= user_id %>">
                <span>아이디(학번): <strong><%= user_id %></strong></span><br>
				<span>이름: <strong><%= user_name %></strong></span><br>
                <label for="user_password">비밀번호 변경</label>
                <input type="text" id="user_password" name="user_password" value="<%= user_password %>"><br>
                <label for="nickname">닉네임 변경</label>
                <input type="text" id="nickname" name="nickname" value="<%= nickname %>"><br>
                <button type="submit" value="Update">정보 변경</button>
            </form>
            </div>
<%
        } else {
            out.println("<h3>사용자 정보를 찾을 수 없습니다.</h3>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        if(rs != null) try { rs.close(); } catch(SQLException ex) {}
        if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if(myConn != null) try { myConn.close(); } catch(SQLException ex) {}
    }
%>

<a href="javascript:window.close()">닫기</a>

</body>
</html>
