<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .order-details {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #fafafa;
        }
        .order-details p {
            margin: 10px 0;
            font-size: 16px;
            color: #555;
        }
        .action-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .action-buttons button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .action-buttons button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>주문 확인</h1>
        <%
        // Session user ID retrieval and check
        String userId = (String) session.getAttribute("user");
        if (userId == null || userId.trim().isEmpty()) {
            out.println("<script>alert('Session expired or not logged in.'); location='login.jsp';</script>");
            return;
        }

        // Retrieve order details from database
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String orderId = request.getParameter("orderId");
        
        if (orderId == null || orderId.trim().isEmpty()) {
            out.println("<script>alert('Invalid order ID.'); location='cart.jsp';</script>");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "dbProject", "000828");
            String sql = "SELECT ORDERNO, ORDERDATE, CAFETERIA_CODE, MENU_NAME, CNT, PRICE FROM orders WHERE ORDERNO = ? AND USER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderId);
            pstmt.setString(2, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String orderNo = rs.getString("ORDERNO");
                String orderDate = rs.getString("ORDERDATE");
                String cafeteriaCode = rs.getString("CAFETERIA_CODE");
                String menuName = rs.getString("MENU_NAME");
                int count = rs.getInt("CNT");
                int price = rs.getInt("PRICE");

                %>
                <div class="order-details">
                    <p>주문 번호: <%= orderNo %></p>
                    <p>주문 날짜: <%= orderDate %></p>
                    <p>식당: <%= cafeteriaCode %></p>
                    <p>메뉴: <%= menuName %></p>
                    <p>수량: <%= count %></p>
                    <p>총 가격: <%= String.format("%,d원", price) %></p>
                </div>
                <%
            } else {
                out.println("<script>alert('Order not found.'); location='cart.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error retrieving order details: " + e.getMessage() + "'); location='cart.jsp';</script>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException se) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException se) {}
            if (conn != null) try { conn.close(); } catch (SQLException se) {}
        }
        %>
        <div class="action-buttons">
            <button onclick="location.href='home_page.jsp'">홈페이지로 이동</button>
            <button onclick="location.href='mypage.jsp'">주문 내역 확인</button>
        </div>
    </div>
</body>
</html>
