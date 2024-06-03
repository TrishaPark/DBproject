package com.dbProject.register;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckUserIdServlet")
public class CheckUserIdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        response.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dbDriver = "oracle.jdbc.driver.OracleDriver";
        String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
        String dbUser = "dbProject"; // Update with your DB username
        String dbPasswd = "000828"; // Update with your DB password


        try {
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

            String sql = "SELECT COUNT(*) FROM user_info WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    out.print("이미 사용 중인 아이디입니다.");
                } else {
                    out.print("사용 가능한 아이디입니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("오류가 발생했습니다. 다시 시도해주세요.");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
}