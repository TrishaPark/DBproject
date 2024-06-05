<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" type="text/css" href="css/cart.css">
    <script>
        function increaseQuantity(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText);
            quantityElement.innerText = quantity + 1;
            var minusButton = document.getElementById('minus-' + id);
            minusButton.src = 'images/minus2.svg';
            minusButton.onclick = function() { decreaseQuantity(id); };
        }

        function decreaseQuantity(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText);
            if (quantity > 1) {
                quantityElement.innerText = quantity - 1;
                if (quantity - 1 === 1) {
                    var minusButton = document.getElementById('minus-' + id);
                    minusButton.src = 'images/minus1.svg';
                    minusButton.onclick = null;
                }
            }
        }

        window.onload = function() {
            var minusElements = document.getElementsByClassName('minus-button');
            for (var i = 0; i < minusElements.length; i++) {
                minusElements[i].src = 'images/minus1.svg';
                minusElements[i].onclick = null;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>장바구니</h1>
    <div class="item-divider"></div>
    <div class="cart-item">
        <div class="item-header">명신관</div>
        <div class="item-info">
            <div class="item-images">
                <img src="images/image1.png" alt="비건야채컵밥 이미지">
            </div>
            <div class="item-details">
                <p class="item-name">[컵밥] 비건야채컵밥</p>
                <p class="item-price">4,500원</p>
            </div>
            <div class="item-quantity">
                <div class="quantity-control">
                    <img id="minus-1" class="minus-button" src="images/minus1.svg" alt="minus">
                    <div id="quantity-1" class="quantity-number">1</div>
                    <img class="plus-button" src="images/plus.svg" alt="plus" onclick="increaseQuantity(1)">
                </div>
            </div>
            <div class="item-total-price">4,500원</div>
        </div>
        <div class="item-divider"></div>
    </div>
    <div class="total">
        <p>합계</p>
        <p class="total-price">4,500원</p>
    </div>
    <div class="order-button">
        <button>주문하기</button>
    </div>
</div>
</body>
</html>