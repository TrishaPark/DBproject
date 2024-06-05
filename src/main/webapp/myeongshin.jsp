<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명신관페이지</title>
</head>
<style>
	.mtitle {
		display:flex;
		margin-top: 100px;
	}
	.mtitle .rest{
		font-family: 'Noto Sans KR';
		font-weight : 600;
		font-size : 20px;
		color : #3D5576;
		margin : 17px;
	}
	.mtitle .time{
		font-family: 'Noto Sans KR';
		font-weight : 500;
		font-size : 15px;
		color : #525050;
		margin-top : 23px;
		margin-right : 20px;
	}
    .menu-slider {
    	font-family : 'Noto Sans KR';
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
<div class = mtitle>
	<div class = rest>명신관 식당</div>
	<div class = time>명신관B1F 11:00~18:00</div>
	<button onclick="location.href='MSpage.jsp'">자세히 보기</button>
</div>
<hr>
<div id="menu-slider" class="menu-slider">
    <div class="menu-item">
        <img src="images/myeong1.png" alt="메뉴 1">
        <h3>돈까스</h3>
        <p>\6500</p>
        
    </div>
    <div class="menu-item">
        <img src="images/myeong2.png" alt="메뉴 2">
        <h3>순두부컵밥</h3>
        <p>\3800</p>
    </div>
    <div class="menu-item">
        <img src="images/myeong3.png" alt="메뉴 3">
        <h3>참치마요컵밥</h3>
        <p>\4500</p>
    </div>
    <div class="menu-item">
        <img src="images/myeong4.jpg" alt="메뉴 4">
        <h3>쫄면</h3>
        <p>\4500</p>
    </div>
    <div class="menu-item">
        <img src="images/myeong5.jpg" alt="메뉴 5">
        <h3>라면</h3>
        <p>\3500</p>
    </div>
    <div class="menu-item">
        <img src="images/myeongUdong.jpg" alt="메뉴 6">
        <h3>우동</h3>
        <p>\5300</p>
    </div>
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