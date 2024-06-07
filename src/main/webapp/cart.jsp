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
        .item-checkbox {
            margin-right: 15px;
            transform: scale(1.5);
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-number {
            min-width: 30px;
            text-align: center;
        }
        .order-button {
            width: 100%;
            margin-top: 20px;
            text-align: right;
        }
    </style>
    <script>
        function formatPrice(price) {
            return price.toLocaleString() + '원';
        }

        function increaseQuantity(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText) + 1;
            quantityElement.innerText = quantity;
            updateItemTotal(id);
            updateTotal();
            updateQuantityInDatabase(id, quantity);
        }

        function decreaseQuantity(id) {
            var quantityElement = document.getElementById('quantity-' + id);
            var quantity = parseInt(quantityElement.innerText) - 1;
            if (quantity > 0) {
                quantityElement.innerText = quantity;
                updateItemTotal(id);
                updateTotal();
                updateQuantityInDatabase(id, quantity);
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
            var selectedItems = document.querySelectorAll('.item-checkbox:checked');
            selectedItems.forEach(function(item) {
                var id = item.value;
                var quantity = parseInt(document.getElementById('quantity-' + id).innerText);
                var price = parseInt(document.getElementById('price-' + id).getAttribute('data-price'));
                total += quantity * price;
            });
            document.getElementById('total-price').innerText = formatPrice(total);
        }

        function updateQuantityInDatabase(menuNum, quantity) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'cartData.jsp', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    console.log('수량 업데이트 성공');
                } else {
                    console.error('수량 업데이트 실패');
                }
            };
            xhr.send('action=updateQuantity&menuNum=' + menuNum + '&quantity=' + quantity);
        }

        function deleteItems() {
            var selectedItems = document.querySelectorAll('.item-checkbox:checked');
            var menuNums = [];
            selectedItems.forEach(function(item) {
                menuNums.push(item.value);
            });
            if (menuNums.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'cartData.jsp', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        console.log('삭제 성공');
                        location.reload();
                    } else {
                        console.error('삭제 실패');
                    }
                };
                xhr.send('action=deleteItems&menuNums=' + menuNums.join(','));
            }
        }

        window.onload = function() {
            var minusElements = document.getElementsByClassName('minus-button');
            for (var i = 0; i < minusElements.length; i++) {
                var id = minusElements[i].id.split('-')[1];
                var quantityElement = document.getElementById('quantity-' + id);
                var quantity = parseInt(quantityElement.innerText);
                var minusButton = document.getElementById('minus-' + id);
                minusButton.src = 'images/minus2.svg';
                minusButton.onclick = function() { decreaseQuantity(id); };
                updateItemTotal(id);
            }

            var checkboxes = document.getElementsByClassName('item-checkbox');
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = true;
                checkboxes[i].addEventListener('change', updateTotal);
            }
            updateTotal();
        }
    </script>
</head>
<body>
<div class="container">
    <h1>장바구니</h1>
    <%
     List<Map<String, Object>> cartItems = (List<Map<String, Object>>) request.getAttribute("cartItems");
     boolean isEmptyCart = (cartItems == null || cartItems.isEmpty());
     if (!isEmptyCart) {
    %>
    <div style="text-align: left; display: flex; align-items: center; margin-bottom: 20px;">
        <div style="display: flex; align-items: center;">
            <input type="checkbox" id="toggleSelectAllCheckbox" onclick="toggleSelectAll()" checked style="transform: scale(1.5);">
            <label for="toggleSelectAllCheckbox" style="margin-left: 5px; cursor: pointer;">전체선택</label>
            <span style="margin: 0 10px;">|</span>
            <span onclick="deleteItems()" style="cursor: pointer; text-decoration: underline; font-size: 16px;">선택삭제</span>
        </div>
    </div>
    <%
        }
    %>
    <div class="item-divider"></div>
    <%
    	
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
        
        boolean isFirstSection = true;
        for (int i = 0; i < cafeteriaCodes.length; i++) {
            String code = cafeteriaCodes[i];
            String name = cafeteriaNames[i];
            List<Map<String, Object>> items = categorizedItems.get(code);
            if (items != null && !items.isEmpty()) {
            	if (!isFirstSection) { %>
    <div class="item-divider"></div>
    <% }
        isFirstSection = false;     	
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
                <input type="checkbox" class="item-checkbox" value="<%= item.get("menuNum") %>" style="margin-right: 20px;">
                <div class="item-image">
                    <img src="images/image_yet.png" alt="메뉴 이미지">
                </div>
                <div class="item-details">
                    <p class="item-name"><%= item.get("menuName") %></p>
                    <p class="item-price" id="price-<%= item.get("menuNum") %>" data-price="<%= price %>"><%= String.format("%,d원", price) %></p>
                </div>
                <div class="item-quantity" style="position: absolute; right: 120px;">
                    <div class="quantity-control">
                        <img id="minus-<%= item.get("menuNum") %>" class="minus-button" src="images/minus2.svg" alt="minus" onclick="decreaseQuantity(<%= item.get("menuNum") %>)">
                        <div id="quantity-<%= item.get("menuNum") %>" class="quantity-number"><%= count %></div>
                        <img class="plus-button" src="images/plus.svg" alt="plus" onclick="increaseQuantity(<%= item.get("menuNum") %>)">
                    </div>
                </div>
                <div class="item-total-price" style="position: absolute; right: 20px;" id="total-price-<%= item.get("menuNum") %>"><%= String.format("%,d원", price * count) %></div>
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

        if (isEmptyCart) {
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
<script>
    function toggleSelectAll() {
        var checkboxes = document.querySelectorAll('.item-checkbox');
        var allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
        checkboxes.forEach(checkbox => {
            checkbox.checked = !allChecked;
        });
    }
</script>
</body>
</html>