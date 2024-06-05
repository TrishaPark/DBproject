<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/SHpage.css">
<title>숙명식당 :: 순헌관 식권 구매</title>
</head>
<body>
<%@include file="bar.jsp" %>
	

	<div class="mainpage">
		<div class="SH-text">순헌관B1F 11:30 ~ 14:00 | 식권구매 </div>
		<div class="divider3"></div>
		<%
			Connection myConn = null; 
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
		    String dbDriver = "oracle.jdbc.driver.OracleDriver";
		    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
		    String dbUser = "dbProject"; // Update with your DB username
		    String dbPasswd = "000828"; // Update with your DB password
            ArrayList<String> koreanMenu = new ArrayList<>();
            ArrayList<String> westernMenu = new ArrayList<>();
            try{
            	Class.forName(dbDriver);
            	myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
            	stmt = myConn.createStatement();
            }catch(ClassNotFoundException e){
            	System.out.println("jdbc driver 로딩 실패");
           	}catch(SQLException e){
            	System.out.println("오라클 연결 실패");
            }
            
            try {
                Class.forName(dbDriver);
                myConn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

                String sql = "SELECT menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8 FROM SHmenu WHERE today = ? AND menucategorie = ?";
                pstmt = myConn.prepareStatement(sql);
             	// Fetch Korean menu
                pstmt.setString(1, "2024-05-30");
                pstmt.setString(2, "한식");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    koreanMenu.add(rs.getString("menu1"));
                    koreanMenu.add(rs.getString("menu2"));
                    koreanMenu.add(rs.getString("menu3"));
                    koreanMenu.add(rs.getString("menu4"));
                    koreanMenu.add(rs.getString("menu5"));
                    koreanMenu.add(rs.getString("menu6"));
                    koreanMenu.add(rs.getString("menu7"));
                    koreanMenu.add(rs.getString("menu8"));
                }
                rs.close();
                pstmt.close();
                
             	// Fetch Western menu
                pstmt = myConn.prepareStatement(sql);
                pstmt.setString(1, "2024-05-30");
                pstmt.setString(2, "양식");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    westernMenu.add(rs.getString("menu1"));
                    westernMenu.add(rs.getString("menu2"));
                    westernMenu.add(rs.getString("menu3"));
                    westernMenu.add(rs.getString("menu4"));
                    westernMenu.add(rs.getString("menu5"));
                    westernMenu.add(rs.getString("menu6"));
                    westernMenu.add(rs.getString("menu7"));
                    westernMenu.add(rs.getString("menu8"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {
                	e.printStackTrace();
                }if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (myConn != null) try { myConn.close(); } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
                
        %>
		<span class="buttoncontainer">
			<button class="SHmenu1">
				<div>
					<div class="menu-items">
			            <% 
	                       for (String menuItem : koreanMenu) {
	                       		out.println("<p>" + menuItem + "</p>");
	                       }
	                    %>
			        </div>
			        <hr>
			        <div class="footer">
			            <div class="category">한식</div>
			            <p class="price">6,500원</p>
	        		</div>
			        <div class="menu-item-add">
					    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
					    <span class="menu-item-add-text">담기</span>
					</div>
				</div>
			</button>
			<button class="SHmenu2">
				<div>
					<div class="menu-items">
			            <% 
	                       for (String menuItem : westernMenu) {
	                       		out.println("<p>" + menuItem + "</p>");
	                       }
	                     %>
			        </div>
		        	<hr>
			        <div class="footer">
			            <div class="category">양식</div>
			            <p class="price">6,500원</p>
	        		</div>
			        <div class="menu-item-add">
					    <img class="menu-item-add-icon" src="images/cart.svg" alt="Cart Icon">
					    <span class="menu-item-add-text">담기</span>
					</div>
				</div>
			</button>
		</span>
	</div>
	<!-- 모달 -->
		<!-- Korean Meal Modal -->
	    <div id="koreanMealModal" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('koreanMealModal')">&times;</span>
	            <p>한식 식권</p>
	        </div>
	        <div class="quantity">
                <label for="koreanQuantity">수량 :</label>
                <input type="number" id="koreanQuantity" name="quantity" value="0" min="0" max="5">
            </div>
                
                <button id="addToCartKorean" class="add-to-cart">장바구니</button>
                <button onclick="closeModal('koreanMealModal')" class="add-to-cart">닫기</button>
         		
         </div>
	
	    <!-- Western Meal Modal -->
	    <div id="westernMealModal" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeModal('westernMealModal')">&times;</span>
	            <p>양식 식권</p>
	        </div>
	        <div class="quantity">
                <label for="WesternQuantity">수량 :</label>
                <input type="number" id="WesternQuantity" name="quantity" value="0" min="0" max="5">
            </div>
                
	            <button id="addToCartWestern" class="add-to-cart">장바구니</button>
	            <button onclick="closeModal('westernMealModal')" class="add-to-cart">닫기</button>
          		  
        </div>
	<script src="javascript/SHpage.js"></script>
	<script src="javascript/SHmodal.js"></script>
</body>
</html>