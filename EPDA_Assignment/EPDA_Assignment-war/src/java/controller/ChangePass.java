/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dell Vostro
 */
public class ChangePass extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false); 
            
        // Retrieve the role attribute from the session
        String username = (String) session.getAttribute("username");
        
        String old_password = request.getParameter("old_password");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            boolean errorStatus = false;
            
            // Check is old password match with db
            String checkOldPassSql = "SELECT * FROM app_user WHERE username = ?";
            pstmt = conn.prepareStatement(checkOldPassSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                
                if (!dbPass.equals(old_password)) {
                    errorStatus = true;
                
                    request.setAttribute("errorMessage", "Wrong old password! Please try again.");
                }
            }
            
            // Check if the password and confirm_password match
            if (!password.equals(confirm_password)) {
                errorStatus = true;
                
                request.setAttribute("errorMessage", "New Password and Confirm New Password do not match!");
            }
            
            if (errorStatus == true) {
                // Forward the request back to the JSP page
                RequestDispatcher dispatcher = request.getRequestDispatcher("changepass.jsp");
                dispatcher.forward(request, response);

//response.sendRedirect(request.getContextPath() + "/ChangePass");
                
                return;  // Exit the method 
            }
            
            String sql = "UPDATE app_user SET password = ? WHERE username = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, password);
            pstmt.setString(2, username);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                session.setAttribute("successMessage", "Your password have been changed successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to change password!");
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("changepass.jsp");
            dispatcher.forward(request, response);
            
            // Close the resources
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        HttpSession session = request.getSession();

        // Retrieve and clear the success message from the session
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        
        session.removeAttribute("successMessage");
        session.removeAttribute("errorMessage");

        request.setAttribute("successMessage", successMessage);
        request.setAttribute("errorMessage", errorMessage);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/changepass.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
