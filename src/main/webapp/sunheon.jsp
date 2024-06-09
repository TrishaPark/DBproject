<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>순헌관페이지</title>
</head>
<style>
.stitle {
   display: flex;
   margin-top: 100px;
}

.stitle .rest {
   font-family: 'Noto Sans KR';
   font-weight: 600;
   font-size: 20px;
   color: #3D5576;
   margin: 17px;
}

.stitle .time {
   font-family: 'Noto Sans KR';
   font-weight: 500;
   font-size: 15px;
   color: #525050;
   margin-top: 23px;
   margin-right: 20px;
}

.smenu-container {
   display: flex;
   justify-content: flex-start;
   padding: 20px;
   width: 100%;
}

.smenu-item {
   display: flex;
   align-items: flex-start;
   flex: 0 0 auto;
   width: 380px;
   scroll-snap-align: start;
   border: 1px solid #ccc;
   text-align: center;
   background: #fff;
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
   border-radius: 8px;
   padding: 20px;
   margin-right: 20px;
}

.smenu-item img {
   flex: 0 0 auto;
   width: 180px;
   height: 180px;
   margin-right: 20px;
   margin-top: 15px;
}

.smenu-item .smenu-text {
   flex: 1;
}

.smenu-item .smenu-text h3 {
   margin-top: 5px;
   color: #3D5576;
}

.smenu-item .smenu-text p {
   font-size: 13px;
   margin: 5px 0;
}

button {
   cursor: pointer;
   padding: 10px 20px;
   height: 40px;
   margin-top: 13px;
   background-color: #f8f8f8;
   border-radius: 8px;
   border: 1px solid #ddd;
}

button:hover {
   background-color: #e8e8e8;
}
</style>
</head>
<body>

   <%
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   List<Map<String, String>> menuList = new ArrayList<>();
   
   String dbDriver = "oracle.jdbc.driver.OracleDriver";
   String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
   String dbUser = "dbProject";
   String dbPasswd = "000828"; 
    

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        stmt = conn.createStatement();
        String query = "SELECT menu_num, menu_name, menu_price,imageurl FROM menu where cafeteria_code = 'sh'";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            Map<String, String> menuItem = new HashMap<>();
            menuItem.put("menu_num", rs.getString("menu_num"));
            menuItem.put("menu_name", rs.getString("menu_name"));
            menuItem.put("menu_price", rs.getString("menu_price"));
            menuItem.put("imageurl", rs.getString("imageurl"));
            menuList.add(menuItem);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

   <div class=stitle>
      <div class=rest>순헌관 식당</div>
      <div class=time>순헌관B1F 11:30~14:00</div>
      <button onclick="location.href='SHpage.jsp'">자세히 보기</button>
   </div>
   <hr>
   <div id="menu-slider" class="menu-slider">
      <% for (Map<String, String> menuItem : menuList) { %>
      <div class="menu-item">
         <img src="<%=menuItem.get("imageurl")%>"
            alt="<%=menuItem.get("menu_name")%>">
         <h3><%=menuItem.get("menu_name")%></h3>
         <p>
            \
            <%=menuItem.get("menu_price")%></p>
      </div>
      <% } %>
   </div>
</body>
</html>
