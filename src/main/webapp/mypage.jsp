<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<style>
    .components {
        font-family: 'Noto Sans KR';
        margin: 40px;
    }

    .components span {
        font-size: 18px;
    }

    .profile {
        display: flex;
        width: 350px;
        justify-content: space-around;
        margin-bottom: 100px;
    }

    .profile img {
        margin-left: 10px;
        margin-top: 20px;
        margin-right: 20px;
        width: 100px;
        height: 100px;
    }

    .profile .profileInfo {
        margin-top: 10px;
    }

    button {
        cursor: pointer;
        padding: 10px 20px;
        margin: 5px;
        background-color: #f8f8f8;
        border-radius: 8px;
        border: 1px solid #ddd;
    }

    button:hover {
        background-color: #e8e8e8;
    }

    .components .mytitle {
        font-size: 18px;
        font-weight: 600;
        margin-top: 35px;
        margin-bottom: 10px;
    }

    .purchasedmenu {
        display: grid;
        grid-template-columns: 1fr 1fr 2fr 1fr 1fr;
        text-align: center;
        align-items: center;
        width: 1000px;
        font-family: 'Noto Sans KR';
        font-weight: 500;
        margin-bottom: 10px;
    }

    .purchasedmenu .date {
        margin-top: 10px;
    }

    .purchasedmenu .menucnt,
    .purchasedmenu .menuprice {
        font-weight: 600;
    }

    .menuinfo {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .menuinfo .mainmenu {
        margin-top: 3px;
        font-size: 15px;
        font-weight: 600;
    }

    .menuimg img {
        width: 50px;
        height: 50px;
    }

</style>

<body>

   <%@include file="bar.jsp"%>
   <table width="100%" align="center" height="100%">

      <!-- 프로파일 부분 -->
      <div class="components">
      <%
    String user_id = (String) session.getAttribute("user");
	
       

%>
         <span><strong><%= nickname %></strong>님 반갑습니다!</span>
         <div class="profile">
            <img src="images/profile.png" alt="프로필 사진">
            <div class="profileInfo">
               <p>
                  <strong><%= user_id %></strong>
               </p>
               <button onclick="openUpdatePopup('<%= user_id %>')">정보수정</button>
               <script>
               function openUpdatePopup(user_id) {
                // 팝업창을 띄우기 위한 설정
                var popupWidth = 600;
                var popupHeight = 600;
                var left = (window.innerWidth - popupWidth) / 2;
                var top = (window.innerHeight - popupHeight) / 2;
                var popupOptions = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes';

                // 팝업창 열기
                window.open('update_user.jsp?user_id=' + user_id, 'UpdateUser', popupOptions);
               }
               </script>

               <button onclick="location.href='logout.jsp'">로그아웃</button>
            </div>
         </div>
      </div>


      <!-- 주문내역 -->

      <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> menuList = new ArrayList<>();

    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "dbProject";
    String dbPasswd = "000828"; 

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        String query = "SELECT orderdate, menu_img, menu_name, cnt, price FROM orders WHERE user_id=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, user_id);
        rs = pstmt.executeQuery();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        while (rs.next()) {
            Map<String, String> menuItem = new HashMap<>();
            java.sql.Date orderDate = rs.getDate("orderdate");
            menuItem.put("orderdate", sdf.format(orderDate));
            menuItem.put("menu_img", rs.getString("menu_img"));
            menuItem.put("menu_name", rs.getString("menu_name"));
            menuItem.put("cnt", rs.getString("cnt"));
            menuItem.put("price", rs.getString("price"));
            menuList.add(menuItem);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

      <div class="components">
         <div class="mytitle">구매 내역</div>
         <hr>
         <% for (Map<String, String> menuItem : menuList) { %>
         <div class="purchasedmenu">
            <div class="date"><%=menuItem.get("orderdate")%></div>
              <div class="menuimg"><img src="<%=menuItem.get("menu_img")%>" alt="<%=menuItem.get("menu_name")%>"></div>
                <div class="menuinfo">
                  <div class="mainmenu"><%=menuItem.get("menu_name")%></div>
              </div>
              <div class="menucnt"><%=menuItem.get("cnt")%>개</div>
              <div class="menuprice"><%=menuItem.get("price")%>원</div>
         </div>
         <hr style="border: dashed 1px grey;">
         <% } %>
      </div>
</body>
</html>