<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙명통계</title>
</head>
<style>
h2{
	text-align: center;
	font-family:'Noto Sans KR';
	font-size: 17px;
	color : #3D5576;
}

ul,li{
  list-style:none;
}

.blind{
  position:absolute;
  clip:rect(0 0 0 0);
  width:1px;
  height:1px;
  overflow:hidden;
}

.charts-container {
    display: flex;
    justify-content: space-around;
    align-items: flex-start;
    margin: 20px;
}

.vertical_chart_box {
    width: 33%;
    margin: 10px;
}

.vertical_chart_box .chart_box {
    position: relative;
    margin-bottom: 45px;
    padding-left: 20px;
    height: 150px; /* 조정하고 싶은 높이 */
}

.vertical_chart_box .axis_y {
    display: flex;
    flex-direction: column-reverse;
    align-items: center;
    justify-content: space-between;
    position: absolute;
    top: 0;
    left: 0;
    margin: 0;
    padding: 0;
    width: 20px;
    height: 100%;
    font-size: 12px;
    color: #4a4a4a;
}

.vertical_chart_box .axis_y:before {
    content: '';
    position: absolute;
    top: 5px;
    bottom: 0;
    right: 0;
    width: 1px;
    background: #d3d3d3;
}

.vertical_chart_box .axis_x {
    display: flex;
    justify-content: center;
    position: relative;
    padding: 0;
    height: 100%;
    border-bottom: 1px solid #d3d3d3;
}

.vertical_chart_box .axis_x .item {
    flex: 1;
    position: relative;
}

.vertical_chart_box .axis_x .item .text_box {
    position: absolute;
    bottom: -43px;
    left: 50%;
    text-align: center;
    transform: translate(-50%, 0);
}

.vertical_chart_box .axis_x .item .text_box .restaurant,
.vertical_chart_box .axis_x .item .text_box .ppl {
    display: block;
    font-size: 12px;
    line-height: 19px;
    color: #4a4a4a;
}

.vertical_chart_box .axis_x .item .text_box .ppl {
    margin-top: 3px;
    color: #999;
}

.vertical_chart_box .axis_x .item .graph {
    display: flex;
    flex-direction: column-reverse;
    position: relative;
    margin: 0 auto;
    padding: 0;
    width: 35px;
    height: 100%;
    background: #e8e8e8;
    overflow: hidden;
    border : none;
}

.vertical_chart_box .axis_x .item .graph .res {
    display: block;
    position: relative;
    margin-bottom: -4px;
    padding-top: 4px;
    box-sizing: content-box;
    width: 100%;
    border : none;
}

.vertical_chart_box .axis_x .item .graph .res.data1 {
    background: #e73ea9;
    z-index: 3;
}

.vertical_chart_box .axis_x .item .graph .res.data2 {
    background: #30d97d;
    z-index: 2;
}

.vertical_chart_box .axis_x .item .graph .res.data3 {
    background: #f5dc12;
    z-index: 1;
}

.vertical_chart_box .axis_x .item .graph button {
    border: 0;
}

</style>

<body>
	<div class="charts-container">
		<div class="vertical_chart_box">
			<h2>명신관</h2>
			<div class="chart_box">
				<ul class="axis_y">
					<li class="item">0<span class="blind">명</span></li>
					<li class="item">20<span class="blind">명</span></li>
					<li class="item">40<span class="blind">명</span></li>
					<li class="item">60<span class="blind">명</span></li>
					<li class="item">80<span class="blind">명</span></li>
					<li class="item">100<span class="blind">명</span></li>
				</ul>
				<ul class="axis_x">
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">한식</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data1" style="height: 40%;"><span
								class="blind">한식</span></span>
						</button>
					</li>
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">양식</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data1" style="height: 70%;"><span
								class="blind">양식</span></span>
						</button>
					</li>
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">스페셜</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data1" style="height: 80%;"><span
								class="blind">스페셜</span></span>
						</button>
					</li>
				</ul>
			</div>
		</div>



		<div class="vertical_chart_box">
			<h2>순헌관</h2>
			<div class="chart_box">
				<ul class="axis_y">
					<li class="item">0<span class="blind">명</span></li>
					<li class="item">20<span class="blind">명</span></li>
					<li class="item">40<span class="blind">명</span></li>
					<li class="item">60<span class="blind">명</span></li>
					<li class="item">80<span class="blind">명</span></li>
					<li class="item">100<span class="blind">명</span></li>
				</ul>
				<ul class="axis_x">
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">한식</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data2" style="height: 50%;"><span
								class="blind">한식</span></span>
						</button>
					</li>
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">양식</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data2" style="height: 90%;"><span
								class="blind">양식</span></span>
						</button>
				</ul>
			</div>
		</div>




		<div class="vertical_chart_box">
			<h2>더베이크</h2>
			<div class="chart_box">
				<ul class="axis_y">
					<li class="item">0<span class="blind">명</span></li>
					<li class="item">20<span class="blind">명</span></li>
					<li class="item">40<span class="blind">명</span></li>
					<li class="item">60<span class="blind">명</span></li>
					<li class="item">80<span class="blind">명</span></li>
					<li class="item">100<span class="blind">명</span></li>
				</ul>
				<ul class="axis_x">
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">커피</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data3" style="height: 85%;"><span
								class="blind">한식</span></span>
						</button>
					</li>
					<li class="item">
						<div class="text_box">
							<strong class="restaurant">베이커리</strong> <span class="ppl">--명</span>
						</div>
						<button type="button" class="graph">
							<span class="res data3" style="height: 45%;"><span
								class="blind">양식</span></span>
						</button>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>