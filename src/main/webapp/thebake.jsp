<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더베이크페이지</title>
</head>
<style>
.btitle {
   display: flex;
   margin-top: 100px;
}

.btitle .rest {
   font-family: 'Noto Sans KR';
   font-weight: 600;
   font-size: 20px;
   color: #3D5576;
   margin: 17px;
}

.btitle .time {
   font-family: 'Noto Sans KR';
   font-weight: 500;
   font-size: 15px;
   color: #525050;
   margin-top: 23px;
   margin-right: 20px;
}

.menu-slider {
   font-family: 'Noto Sans KR';
   display: flex;
   overflow-x: auto;
   scroll-snap-type: x mandatory;
   padding: 20px;
   gap: 20px; /* 각 아이템 간 간격 */
}

.menu-item {
   flex: 0 0 auto;
   width: 250px; /* 각 아이템의 너비 */
   scroll-snap-align: start;
   border: 1px solid #ccc; /* 경계선 스타일 */
   text-align: center;
   background: #fff; /* 배경색 */
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
   border-radius: 8px;
   padding: 10px;
}

.menu-item img {
   width: 100px;
   height: 100px;
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
        String query = "SELECT menu_num, menu_name, menu_price,imageurl FROM menu where cafeteria_code = 'tb'";
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

   <div class="btitle">
      <div class="rest">더베이크</div>
      <div class="time">학생회관 1층 월~금 8:00~20:00 / 토 9:00~19:00 / 일 정기휴무</div>
      <button onclick="location.href='THEBAKEpage.jsp'">자세히 보기</button>
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

   <script>
document.getElementById('menu-slider').addEventListener('mousedown', function(event) {
    let startX = event.pageX;
    let scrollLeft = this.scrollLeft;

    this.addEventListener('mousemove', onMouseMove);
    this.addEventListener('mouseup', () => {
        this.removeEventListener('mousemove', onMouseMove);
    });
    this.addEventListener('mouseleave', () => {
        this.removeEventListener('mousemove', onMouseMove);
    });

    function onMouseMove(event) {
        const x = event.pageX - startX;
        this.scrollLeft = scrollLeft - x;
    }
});
</script>

</body>
</html>