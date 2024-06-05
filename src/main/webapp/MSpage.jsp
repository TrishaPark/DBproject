<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "db2012133";
    String password = "ss2";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Map<String, String>> menuList = new ArrayList<>();

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
        String query = "SELECT * FROM menu";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            // TODO 명신관 메뉴 받아오기
            Map<String, String> menuItem = new HashMap<>();

            menuList.add(menuItem);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    request.setAttribute("menuList", menuList);
%>

<%@ include file="bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>명신관</title>
    <link rel="stylesheet" type="text/css" href="css/MSpage.css">
</head>
<body>
<div class="mainpage">
    <ul class="category">
        <li class="menu-item selected" id="cupbab" onclick="selectMenu('cupbab')"><a href="MSpage.jsp">컵밥</a></li>
        <li class="menu-item" id="western" onclick="selectMenu('western')"><a href="MSpageWestern.jsp">양식</a></li>
        <li class="menu-item" id="special" onclick="selectMenu('special')"><a href="MSpageSpecial.jsp">스페셜메뉴</a></li>
    </ul>
    <div class="menu-container" id="menu-container">
        <button class="menu-item-card1">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image1.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">비건야채컵밥</div>
                <div class="menu-item-price">4,500원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card2">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image2.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">참치마요컵밥</div>
                <div class="menu-item-price">4,500원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card3">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image3.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">참치김치컵밥</div>
                <div class="menu-item-price">4,500원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="img/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card4">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image4.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">순두부컵밥</div>
                <div class="menu-item-price">3,800원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card5">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image5.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">제육컵밥</div>
                <div class="menu-item-price">5,500원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card6">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image6.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">치킨마요덮밥</div>
                <div class="menu-item-price">4,900원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="img/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
        <button class="menu-item-card7">
            <div class="menu-item-background">
                <div class="menu-item-image" style="background-image: url('images/image7.png');"></div>
                <div class="menu-item-divider"></div>
                <div class="menu-item-name">스팸마요덮밥</div>
                <div class="menu-item-price">4,900원</div>
                <div class="menu-item-add-container">
                    <img class="menu-item-add-icon" src="img/cart.svg" alt="Cart Icon">
                    <div class="menu-item-add-text">담기</div>
                </div>
            </div>
        </button>
    </div>
</div>

		<div id="cubbab1" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab1')">&times;</span>
	            <p>비건야채겁밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab1Quantity">수량 :</label>
                <input type="number" id="cubbab1Quantity" name="quantity" value="0" min="0" max="5">
            </div>   
                <button id="addToCartcubbab1" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab1')" class="add-to-cart">닫기</button>	
         </div>
         <div id="cubbab2" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab2')">&times;</span>
	            <p>참치마요컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab2Quantity">수량 :</label>
                <input type="number" id="cubbab2Quantity" name="quantity" value="0" min="0" max="5">
            </div>
                <button id="addToCartcubbab2" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab2')" class="add-to-cart">닫기</button>	
         </div>
         <div id="cubbab3" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab3')">&times;</span>
	            <p>참치김치컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab3Quantity">수량 :</label>
                <input type="number" id="cubbab3Quantity" name="quantity" value="0" min="0" max="5">
            </div>               
                <button id="addToCartcubbab3" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab3')" class="add-to-cart">닫기</button>
         </div>
         <div id="cubbab4" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab4')">&times;</span>
	            <p>순두부컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab4Quantity">수량 :</label>
                <input type="number" id="cubbab4Quantity" name="quantity" value="0" min="0" max="5">
            </div>               
                <button id="addToCartcubbab4" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab4')" class="add-to-cart">닫기</button>
         </div>
         <div id="cubbab5" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab5')">&times;</span>
	            <p>제육컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab5Quantity">수량 :</label>
                <input type="number" id="cubbab5Quantity" name="quantity" value="0" min="0" max="5">
            </div>   
                <button id="addToCartcubbab1" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab5')" class="add-to-cart">닫기</button>	
         </div>
         <div id="cubbab6" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab6')">&times;</span>
	            <p>치킨마요컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab6Quantity">수량 :</label>
                <input type="number" id="cubbab6Quantity" name="quantity" value="0" min="0" max="5">
            </div>   
                <button id="addToCartcubbab6" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab6')" class="add-to-cart">닫기</button>	
         </div>
         <div id="cubbab7" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('cubbab7')">&times;</span>
	            <p>스팸마요컵밥</p>
	        </div>
	        <div class="quantity">
                <label for="cubbab7Quantity">수량 :</label>
                <input type="number" id="cubbab7Quantity" name="quantity" value="0" min="0" max="5">
            </div>   
                <button id="addToCartcubbab7" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('cubbab7')" class="add-to-cart">닫기</button>	
         </div>
         <script src="javascript/MSpage.js"></script>
		 <script src="javascript/MSpagemodal.js"></script>

<script>
    function selectMenu(category) {
        var items = document.getElementsByClassName('menu-item');
        for (var i = 0; i < items.length; i++) {
            items[i].classList.remove('selected');
        }
        document.getElementById(category).classList.add('selected');
    }

    document.addEventListener('DOMContentLoaded', function() {
        selectMenu('cupbab');
    });
</script>
</body>
</html>