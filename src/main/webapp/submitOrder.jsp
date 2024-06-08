<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.sql.DataSource"%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Submission</title>
</head>
<body>
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String userId = (String) session.getAttribute("user");
    if (userId == null || userId.trim().isEmpty()) {
        out.println("<script>alert('Session expired or not logged in.'); location='login.jsp';</script>");
        return;
    }

    // Database connection details
    String dbDriver = "oracle.jdbc.driver.OracleDriver";
    String dbURL = "jdbc:oracle:thin:@//localhost:1521/xe"; // Update with your DB details
    String dbUser = "dbProject"; // Update with your DB username
    String dbPasswd = "000828"; // Update with your DB password

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        conn.setAutoCommit(false);

        // Prepare SQL to fetch cart details
        String sql = "SELECT c.MENU_NUM, c.COUNT, c.CAFETERIA_CODE, c.MENU_NAME, c.MENU_PRICE, m.STOCK FROM cart c JOIN menu m ON c.MENU_NUM = m.MENU_NUM WHERE c.USER_ID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(userId));
        rs = pstmt.executeQuery();

        boolean canOrder = true;

        // Check stock availability and gather order details
        while (rs.next()) {
            int menuNum = rs.getInt("MENU_NUM");
            int count = rs.getInt("COUNT");
            int stock = rs.getInt("STOCK");
            String cafeteriaCode = rs.getString("CAFETERIA_CODE");
            String menuName = rs.getString("MENU_NAME");
            int menuPrice = rs.getInt("MENU_PRICE");

            if (count > stock) {
                out.println("<script>alert('재고가 부족합니다.'); history.go(-1);</script>");
                canOrder = false;
                break;
            } else {
                // Reduce stock
                String updateStockSql = "UPDATE menu SET STOCK = STOCK - ? WHERE MENU_NAME = ?";
                try (PreparedStatement updatePstmt = conn.prepareStatement(updateStockSql)) {
                    updatePstmt.setInt(1, count);
                    updatePstmt.setString(2, menuName);
                    updatePstmt.executeUpdate();
                }

                // Create a unique order number
                String orderId = "ORD" + cafeteriaCode + count;
                java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());

                // Insert order into orders table
                String insertOrderSql = "INSERT INTO orders (ORDERNO, USER_ID, ORDERDATE, CAFETERIA_CODE, MENU_NAME, CNT, PRICE) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertPstmt = conn.prepareStatement(insertOrderSql)) {
                    insertPstmt.setString(1, orderId);
                    insertPstmt.setString(2, userId);
                    insertPstmt.setDate(3, sqlDate);
                    insertPstmt.setString(4, cafeteriaCode);
                    insertPstmt.setString(5, menuName);
                    insertPstmt.setInt(6, count);
                    insertPstmt.setInt(7, menuPrice * count);
                    insertPstmt.executeUpdate();
                }
            }
        }

        rs.close();
        pstmt.close();

        if (canOrder) {
            conn.commit();
            out.println("<script>alert('주문이 완료되었습니다.'); location = 'cart.jsp';</script>");
        } else {
            if (conn != null) try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
        }
    } catch (Exception e) {
        e.printStackTrace();
        if (conn != null) try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
        out.println("<script>alert('주문 처리 중 오류가 발생했습니다: " + e.getMessage() + "'); history.go(-1);</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException se) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException se) {}
        if (conn != null) try { conn.close(); } catch (SQLException se) {}
    }
    %>
</body>
</html>
