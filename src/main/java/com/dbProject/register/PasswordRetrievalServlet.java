package com.dbProject.register;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PasswordRetrievalServlet")
public class PasswordRetrievalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String dbDriver = "oracle.jdbc.driver.OracleDriver";
    private static final String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
    private static final String dbUser = "dbProject"; // Update with your DB username
    private static final String dbPasswd = "000828"; // Update with your DB password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_name = request.getParameter("user_name");
        String user_id = request.getParameter("user_id");

        // 입력된 값 디버깅 출력
        System.out.println("Received user_name: " + user_name);
        System.out.println("Received user_id: " + user_id);
        
        String user_password = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
            String sql = "SELECT user_password FROM user_info WHERE user_name = ? AND user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_name);
            pstmt.setString(2, user_id);

            // SQL 쿼리 디버깅 출력
            System.out.println("Executing query: " + pstmt.toString());

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user_password = rs.getString("user_password");
                System.out.println("Password found: " + user_password);
            } else {
                System.out.println("No matching user found in the database.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        String message;
        if (user_password != null) {
            message = "Your password is: " + user_password;
        } else {
            message = "No matching user found.";
        }

        System.out.println("Response message: " + message);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(message);
    }
}