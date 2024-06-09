<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.util.*, javax.servlet.http.*, java.text.SimpleDateFormat"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.StringWriter"%>
<%@ page import="java.util.Random"%>


<!DOCTYPE html>
<html>
<head>
<title>Order Submission</title>

</head>
<body>
	<%
	Random rand = new Random();
	int generateRandomNumber = 100000 + rand.nextInt(900000);
	
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean canOrder = true;
    ArrayList<String> errors = new ArrayList<>();
    String newOrderId = "";
    

    // 세션 ID
    String userId = (String) session.getAttribute("user");
    if (userId == null || userId.trim().isEmpty()) {
        out.println("<script>alert('Session expired or not logged in.'); location='login.jsp';</script>");
        return;
    }

    // POST 요청으로부터 selected menu details 가져오기
    String selectedMenuDetails = request.getParameter("selectedMenuDetails");
    //디버깅 out.println("<p>Selected Menu Details: " + selectedMenuDetails + "</p>"); 
    if (selectedMenuDetails == null || selectedMenuDetails.trim().isEmpty()) {
        out.println("<script>alert('No items selected.'); history.back();</script>");
        return;
    }
    String[] selectedMenus = selectedMenuDetails.split(",");
    
    

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "dbProject", "000828");
        conn.setAutoCommit(false);
        

        // 모든 메뉴에 대해서 반복문 생성
        for (String menuDetail : selectedMenus) {
            try {
                String[] parts = menuDetail.split(":");
                String menuNum = parts[0];
                int count = Integer.parseInt(parts[1]);
                out.println("<p>Processing menuNum: " + menuNum + " with count: " + count + "</p>");

                // 데이터베이스에서 fetch details
                String sql = "SELECT CAFETERIA_CODE, MENU_NAME, MENU_PRICE, STOCK, IMAGEURL FROM menu WHERE MENU_NUM = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(menuNum));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    int stock = rs.getInt("STOCK");
                    String cafeteriaCode = rs.getString("CAFETERIA_CODE");
                    String menuName = rs.getString("MENU_NAME");
                    int menuPrice = rs.getInt("MENU_PRICE");
                    String menuimg = rs.getString("IMAGEURL");
                    //디버깅 out.println("잘 받아왔나: " + stock + " " + cafeteriaCode + " " + menuName + " " + menuPrice + " " + menuimg + "<br>");

                    if (count > stock) {
                        errors.add(menuName + " 는 재고가 부족합니다.");
                        canOrder = false;
                        continue;
                    } else {
                    	// menu 테이블의 재고 수정
                        String updateStockSql = "UPDATE menu SET STOCK = STOCK - ? WHERE MENU_NUM = ?";
                        try (PreparedStatement updatePstmt = conn.prepareStatement(updateStockSql)) {
                            updatePstmt.setInt(1, count);
                            updatePstmt.setInt(2, Integer.parseInt(menuNum));
                            updatePstmt.executeUpdate();
                            //디버깅 out.println("Stock update result for menuNum " + menuNum + ": " + count + " rows affected.<br>"); // Debugging line
                        }
                        
                        String orderId = null;
                        String orderIdQuery = "SELECT order_seq.NEXTVAL FROM dual";
                        try (Statement orderIdStmt = conn.createStatement()) {
                            ResultSet orderIdRs = orderIdStmt.executeQuery(orderIdQuery);
                            if (orderIdRs.next()) {
                                orderId = "ORD" + orderIdRs.getInt(1);
                            }
                        }
                        java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());

                        String insertOrderSql = "INSERT INTO orders (ORDERNO, USER_ID, ORDERDATE, CAFETERIA_CODE, MENU_NAME, CNT, PRICE, MENU_IMG) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertPstmt = conn.prepareStatement(insertOrderSql)) {
                            insertPstmt.setString(1, orderId);
                            insertPstmt.setString(2, userId);
                            insertPstmt.setDate(3, sqlDate);
                            insertPstmt.setString(4, cafeteriaCode);
                            insertPstmt.setString(5, menuName);
                            insertPstmt.setInt(6, count);
                            insertPstmt.setInt(7, menuPrice * count);
                            insertPstmt.setString(8, menuimg); 
                            insertPstmt.executeUpdate();
                            //디버깅 out.println("Order insert result for orderId " + orderId + ": " + count + " rows affected.<br>");
                        }
                        
                        //주문 테이블에 들어간 정보를 cart 테이블에서 삭제
                        String deleteCartSql = "DELETE FROM cart WHERE USER_ID=? AND MENU_NUM=?";
                        try(PreparedStatement deletePstmt = conn.prepareStatement(deleteCartSql)){
                        	deletePstmt.setString(1, userId);
                        	deletePstmt.setInt(2, Integer.parseInt(menuNum));
                        	deletePstmt.executeUpdate();
                        	//디버깅 out.println("Cart table update result for menuNum " + menuNum + ": " + count + " rows affected.<br>"); 
                        }
                        
                        //ordertotal 테이블에 수량 증가
                        String updateOrderTotalSql = "UPDATE ordertotal SET TOTALCNT = TOTALCNT + ? WHERE MENU_NUM=?";
                        try(PreparedStatement updateOTPstmt = conn.prepareStatement(updateOrderTotalSql)){
                        	updateOTPstmt.setInt(1, count);
                        	updateOTPstmt.setInt(2, Integer.parseInt(menuNum));
                        	updateOTPstmt.executeUpdate();
                            //디버깅 out.println("Ordertotal update result for menuNum " + menuNum + ": " + count + " rows affected.<br>"); 
                        }
                        
                    }

                    
                } else {
                    out.println("<p>Error: Menu item not found for menuNum " + menuNum + "</p>"); //디버깅
                }
            } catch (Exception innerEx) {
                out.println("<p>Error processing menuNum " + menuDetail + ": " + innerEx.getMessage() + "</p>");
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                innerEx.printStackTrace(pw);
                out.println("<pre>" + sw.toString() + "</pre>");
            }
        }

        if (!canOrder) {
            conn.rollback();
            out.println("<script>alert('Some items are out of stock: " + String.join(",", errors) + "'); history.back();</script>");
        } else {
            conn.commit();
            out.println("<script>alert('주문이 완료 되었습니다.'); window.location.href='home_page.jsp';</script>");
        } 
    } catch (Exception e) {
        e.printStackTrace();
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<pre>" + sw.toString() + "</pre>");
        if (conn != null) try { conn.rollback(); } catch (SQLException se) { 
            StringWriter sw2 = new StringWriter();
            PrintWriter pw2 = new PrintWriter(sw2);
            se.printStackTrace(pw2);
            out.println("<pre>" + sw2.toString() + "</pre>");
        }
        out.println("<script>alert('Error during order processing: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException se) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            se.printStackTrace(pw);
            out.println("<pre>" + sw.toString() + "</pre>");
        }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException se) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            se.printStackTrace(pw);
            out.println("<pre>" + sw.toString() + "</pre>");
        }
        if (conn != null) try { conn.close(); } catch (SQLException se) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            se.printStackTrace(pw);
            out.println("<pre>" + sw.toString() + "</pre>");
        }
    }
    %>
</body>
</html>

