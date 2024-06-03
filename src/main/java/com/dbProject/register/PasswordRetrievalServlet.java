package com.dbProject.register;

import java.io.IOException;
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
        
        String user_password = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
            String sql = "SELECT user_password FROM users WHERE user_id = ? AND user_name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_name);
            pstmt.setString(2, user_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user_password = rs.getString("user_password");
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

        request.setAttribute("userPassword", user_password);
        request.getRequestDispatcher("lost_password.jsp").forward(request, response);
    }
}