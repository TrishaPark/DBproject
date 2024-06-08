package com.dbProject.register;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleTypes;

@WebServlet("/CheckUserPasswordServlet")
public class CheckUserPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        String user_password = request.getParameter("user_password");
        response.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        CallableStatement cstmt = null;
        String dbDriver = "oracle.jdbc.driver.OracleDriver";
        String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
        String dbUser = "dbProject"; // Update with your DB username
        String dbPasswd = "000828"; // Update with your DB password

        try {
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);

            String plsql = "{call check_user_password(?, ?, ?)}";
            cstmt = conn.prepareCall(plsql);
            cstmt.setString(1, user_id);
            cstmt.setString(2, user_password);
            cstmt.registerOutParameter(3, OracleTypes.VARCHAR);

            cstmt.execute();

            String result = cstmt.getString(3);
            out.print(result);
        } catch (Exception e) {
            e.printStackTrace();
            out.print("오류가 발생했습니다. 다시 시도해주세요.");
        } finally {
            if (cstmt != null) try { cstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
}