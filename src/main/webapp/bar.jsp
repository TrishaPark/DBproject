<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>숙명식당</title>
    <link rel="stylesheet" href="css/barstyle.css"> <!-- 스타일시트 연결 -->
</head>
<style>
 		p {
 			font-family: 'Noto Sans';
            font-size: 16px;
            color : #3D5576;
            font-weight: bold;
        	}
</style>
<body>
    <header>
        <div class="top-bar">
        	<div class="left-dummy"></div>
          	<div class="logo-and-title">
            	<img src="images/logo.svg" alt="로고" class="logo"> <!-- 로고 이미지 -->
            	<div class="page-title"><a href="home_page.jsp">숙명식당</a></div>
          	</div>
          	 <%
    String nickname = (String) session.getAttribute("nickname");
%>
            	<p>환영합니다, <%= nickname %>!</p>
            <div class="user-controls">
        
                <a href="logout.jsp">로그아웃</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
            </div>
        </div>
        <hr>
        <nav class="menu-bar">
            <a href="MSpage.jsp">명신관</a>
            <a href="SHpage.jsp">순헌관</a>
            <a href="THEBAKEpage.jsp">더베이크</a>
            <a href="POPULARpage.jsp">인기메뉴</a>
        </nav>
        <hr>
     	<div class="main-banner">
        <img src="images/schoolfinal.png" alt="메인 배너">
        </div>
    </header>
    
</body>
</html>
