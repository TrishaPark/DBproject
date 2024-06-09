 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	String dbDriver = "oracle.jdbc.driver.OracleDriver";
	String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "dbProject";
	String dbPasswd = "000828";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> msMenuList = new ArrayList<>();

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        
        // Fetch top 3 menus for MS
        String queryMS = "SELECT menu_name, price, menu_img FROM (SELECT menu_name, price, menu_img FROM ordertotal WHERE cafeteria_code = 'ms' ORDER BY totalcnt DESC) WHERE ROWNUM <= 3";
        pstmt = conn.prepareStatement(queryMS);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> menuItem = new HashMap<>();
            menuItem.put("menu_name", rs.getString("menu_name"));
            menuItem.put("price", rs.getString("price"));
            menuItem.put("menu_img", rs.getString("menu_img"));
            msMenuList.add(menuItem);
        }
        rs.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    request.setAttribute("msMenuList", msMenuList);
%>

<%@ include file="bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙명식당 :: POPULAR</title>
    <link rel="stylesheet" type="text/css" href="css/POPULARpage.css">
</head>
<body>
<div class="mainpage">
    <ul class="category">
        <li class="menu-item selected" id="mspopular" onclick="selectMenu('ms')"><a href="POPULARpage.jsp">명신관</a></li>
        <li class="menu-item" id="tbpopular" onclick="selectMenu('tb')"><a href="TBpopularpage.jsp">더베이크</a></li>
    </ul>
    <div class="menu-container" id="menu-container">
        <% for (Map<String, String> menuItem : msMenuList) { %>
        <button class="menu-item-card1">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('<%= menuItem.get("menu_img") != null ? menuItem.get("menu_img") : "images/image_yet.png" %>');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name"><%= menuItem.get("menu_name") %></div>
                <div class="menu-item-price"><%= menuItem.get("price") %>원</div>
            </div>
        </button>
        <% } %>
    </div>
</div>
<script>
    function selectMenu(category) {
        var items = document.getElementsByClassName('menu-item');
        for (var i = 0; i < items.length; i++) {
            items[i].classList.remove('selected');
        }
        document.getElementById(category + 'popular').classList.add('selected');
    }

    document.addEventListener('DOMContentLoaded', function() {
        selectMenu('ms');
    });
</script>
</body>
</html>
