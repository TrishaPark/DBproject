<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<%@ include file="bar.jsp" %>
<jsp:include page="cartData.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" type="text/css" href="css/cart.css">
    <style>
        .item-divider {
            border-top: 1px solid #ccc;
            margin: 10px 0;
        }
        .item-divider-gray {
            border-top: 1px solid #ccc;
            margin: 10px 0;
        }
    </style>
    <script>
        function formatPrice(price) {
            return price.toLocaleString() + '원';
        }

        function increaseQuantity(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText);
            quantityElement.innerText = quantity + 1;
            var minusButton = document.getElementById('minus-' + id);
            minusButton.src = 'images/minus2.svg';
            minusButton.onclick = function() { decreaseQuantity(id); };
            updateItemTotal(id);
            updateTotal();
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
                updateItemTotal(id);
                updateTotal();
            }
        }

        function updateItemTotal(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText);
            var priceElement = document.getElementById('price-' + id);
            var price = parseInt(priceElement.getAttribute('data-price'));
            var totalPriceElement = document.getElementById('total-price-' + id);
            totalPriceElement.innerText = formatPrice(quantity * price);
        }

        function updateTotal() {
            var total = 0;
            var quantities = document.getElementsByClassName('quantity-number');
            var prices = document.getElementsByClassName('item-price');
            for (var i = 0; i < quantities.length; i++) {
                var quantity = parseInt(quantities[i].innerText);
                var price = parseInt(prices[i].getAttribute('data-price'));
                total += quantity * price;
            }
            document.getElementById('total-price').innerText = formatPrice(total);
        }

        window.onload = function() {
            var minusElements = document.getElementsByClassName('minus-button');
            for (var i = 0; i < minusElements.length; i++) {
                var id = minusElements[i].id.split('-')[1];
                var quantityElement = document.getElementById('quantity-' + id);
                var quantity = parseInt(quantityElement.innerText);
                var minusButton = document.getElementById('minus-' + id);
                if (quantity > 1) {
                    minusButton.src = 'images/minus2.svg';
                    (function(id) {
                        minusButton.onclick = function() { decreaseQuantity(id); };
                    })(id);
                } else {
                    minusButton.src = 'images/minus1.svg';
                    minusButton.onclick = null;
                }
                updateItemTotal(id);
            }
            updateTotal();
        }
    </script>
</head>
<body>
<div class="container">
    <h1>장바구니</h1>
    <div class="item-divider"></div>
    <%
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) request.getAttribute("cartItems");
        Map<String, List<Map<String, Object>>> categorizedItems = new HashMap<>();
        categorizedItems.put("ms", new ArrayList<>());
        categorizedItems.put("sh", new ArrayList<>());
        categorizedItems.put("tb", new ArrayList<>());

        if (cartItems != null) {
            for (Map<String, Object> item : cartItems) {
                String cafeteriaCode = (String) item.get("cafeteriaCode");
                if (categorizedItems.containsKey(cafeteriaCode)) {
                    categorizedItems.get(cafeteriaCode).add(item);
                }
            }
        }

        String[] cafeteriaCodes = { "ms", "sh", "tb" };
        String[] cafeteriaNames = { "명신관", "순헌관", "더베이크" };

        for (int i = 0; i < cafeteriaCodes.length; i++) {
            String code = cafeteriaCodes[i];
            String name = cafeteriaNames[i];
            List<Map<String, Object>> items = categorizedItems.get(code);
            if (items != null && !items.isEmpty()) {
                if (i > 0) { %>
    <div class="item-divider"></div>
    <% }
    %>
    <div class="cart-section">
        <div class="item-header"><%= name %></div>
        <%
            for (int j = 0; j < items.size(); j++) {
                Map<String, Object> item = items.get(j);
                int price = (int) item.get("price");
                int count = (int) item.get("count");
        %>
        <div class="cart-item">
            <div class="item-info">
                <div class="item-image">
                    <img src="images/image1.png" alt="메뉴 이미지">
                </div>
                <div class="item-details">
                    <p class="item-name"><%= item.get("menuName") %></p>
                    <p class="item-price" id="price-<%= item.get("menuNum") %>" data-price="<%= price %>"><%= String.format("%,d원", price) %></p>
                </div>
                <div class="item-quantity">
                    <div class="quantity-control">
                        <img id="minus-<%= item.get("menuNum") %>" class="minus-button" src="<%= count > 1 ? "images/minus2.svg" : "images/minus1.svg" %>" alt="minus" <%= count > 1 ? "onclick=\"decreaseQuantity(" + item.get("menuNum") + ")\"" : "" %> >
                        <div id="quantity-<%= item.get("menuNum") %>" class="quantity-number"><%= count %></div>
                        <img class="plus-button" src="images/plus.svg" alt="plus" onclick="increaseQuantity(<%= item.get("menuNum") %>)">
                    </div>
                </div>
                <div class="item-total-price" id="total-price-<%= item.get("menuNum") %>"><%= String.format("%,d원", price * count) %></div>
            </div>
            <% if (j < items.size() - 1) { %>
            <div class="item-divider-gray"></div>
            <% } %>
        </div>
        <%
            }
        %>
    </div>
    <%
            }
        }

        if (cartItems == null || cartItems.isEmpty()) {
    %>
    <p style="text-align: center; margin-top: 60px;">장바구니에 담긴 상품이 없습니다.</p>
    <div class="total">
    </div>
    <%
    } else {
    %>
    <div class="item-divider"></div>
    <%
        int totalPrice = 0;
        for (Map<String, Object> item : cartItems) {
            totalPrice += (int) item.get("price") * (int) item.get("count");
        }
    %>
    <div class="total">
        <p>합계</p>
        <p id="total-price" class="total-price"><%= String.format("%,d원", totalPrice) %></p>
    </div>
    <div class="order-button" style="margin-bottom: 20px;">
        <button>주문하기</button>
    </div>
    <%
        }
    %>
</div>
</body>
</html>