<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 메뉴</title>
</head>
<style>
	.todayMenu {
		display: flex;
		justify-content: space-around;		
		align-items : center;
		font-family: 'Noto Sans KR';
		font-size: 11px;
		color : #3D5576;
		font-weight : 600;
		padding: 20px;
		background-color : #f9f9f9;
		border-radius: 8px;
		height : 50px;
		box-shadow: 0 2px 5px rgba(0,0,0,0.2);
	}
	
	.menu-items{
		display : flex;
		color : black;
		flex-direction: column;
		margin-top:10px;
	}
</style>
<body>
	<header>
		<div class="todayMenu">
			<div class="title"><span>오늘의 메뉴</span></div>
			<div class="meong">
				<span>명신관</span>
			</div>
			<div class="menu-categories">
				<div class="menu-title">스페셜 메뉴</div>
				<div class="menu-items">
					<span>닭곰탕</span>
				</div>
			</div>
			<div class="sunhun">
				<span>순헌관</span>
			</div>
			<div class="menu-categories">
				<div class="menu-title">한식</div>
					<div class="menu-items">
					<span>모듬햄부대찌개</span>
					<span>생선커틀렛</span>
					</div>		
			</div>
			<div class="menu-categories">
				<div class="menu-title">양식</div>
					<div class="menu-items">
					<span>난자완스덮밥</span>
					<span>멘보샤</span>
					</div>		
			</div>
		</div>
	</header>
</body>
</html>