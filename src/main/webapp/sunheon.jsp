<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>순헌관페이지</title>
</head>
<style>
	.stitle {
		display:flex;
		margin-top: 100px;
	}
	.stitle .rest{
		font-family: 'Noto Sans KR';
		font-weight : 600;
		font-size : 20px;
		color : #3D5576;
		margin : 17px;
	}
	.stitle .time{
		font-family: 'Noto Sans KR';
		font-weight : 500;
		font-size : 15px;
		color : #525050;
		margin-top : 23px;
		margin-right : 20px;
	}
	.smenu-container{
		display: flex;
		justify-content : flex-start;
		padding: 20px;
		width:100%;
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
        margin-right : 20px;
    }

    .smenu-item img {
        flex: 0 0 auto;
        width: 180px;
        height: 180px;
        margin-right: 20px;
        margin-top : 15px;
    }
	
	.smenu-item .smenu-text {
        flex: 1;
    }

	.smenu-item .smenu-text h3 {
        margin-top: 5px;
        color : #3D5576;
       
    }

	.smenu-item .smenu-text p {
		font-size: 13px;
		margin: 5px 0;
		
	}
	
	button {
        cursor: pointer;
        padding: 10px 20px;
        height : 40px;
        margin-top : 13px;
        background-color: #f8f8f8;
        border-radius : 8px;
        border: 1px solid #ddd;
    }

    button:hover {
        background-color: #e8e8e8;
    }

</style>
</head>
<body>
<div class = stitle>
	<div class = rest>순헌관 식당</div>
	<div class = time>순헌관B1F 11:30~14:00</div>
	<button onclick="location.href='SHpage.jsp'">자세히 보기</button>
</div>
<hr>
  <div class="smenu-container">
    <div class="smenu-item">
        <img src="images/sun1.png" alt="메뉴 1">
        <div class="smenu-text">
            <h3>한식</h3>
            <p>모듬햄부대찌개</p>
            <p>잡곡밥</p>
            <p>생선커틀렛</p>
            <p>야채스크램블에그</p>
            <p>오이생채</p>
            <p>깍두기</p>
            <p>그린샐러드</p>
            <p>숭늉*현미밥</p>
        </div>
    </div>
    <div class="smenu-item">
        <img src="images/sun2.png" alt="메뉴 2">
        <div class="smenu-text">
            <h3>양식</h3>
            <p>난자완스덮밥</p>
            <p>계란국</p>
            <p>멘보샤*단팥춘권</p>
            <p>짜사이무침</p>
            <p>배추김치</p>
            <p>그린샐러드</p>
            <p>숭늉*현미밥</p>
        </div>
    </div>
  </div>
</body>
</html>
