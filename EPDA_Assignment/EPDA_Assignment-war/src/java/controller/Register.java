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
import java.sql.Statement;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AppUser;
import model.AppUserFacade;

/**
 *
 * @author Dell Vostro
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    
    @EJB
    private AppUserFacade appUserFacade;

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
        
        // Retrieve form parameters
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        String role = "customer"; 
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            boolean errorStatus = false;
            
            // Check if the password and confirm_password match
            if (!password.equals(confirm_password)) {
                errorStatus = true;
                
                request.setAttribute("errorMessage", "Password and Confirm Password do not match!");
            }
            
            // Check if username exists
            String checkUsernameSql = "SELECT COUNT(*) FROM staff WHERE username = ?";
            pstmt = conn.prepareStatement(checkUsernameSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                errorStatus = true;
                
                request.setAttribute("errorMessage", "Username exists! Please try again.");
            }
            
            if (errorStatus == true) {
                // Set form data as request attributes
                request.setAttribute("email", email);
                request.setAttribute("username", username);

                // Forward the request back to the JSP page
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
                
                return;  // Exit the method 
            }
            
            String sql = "INSERT INTO app_user (username, email, password, user_role) VALUES (?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, role);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) { 
                HttpSession session = request.getSession();
                session.setAttribute("registersuccessMessage", "You have been registered successfully!");

                response.sendRedirect(request.getContextPath() + "/Login?userType=customer");
                
            } else {
                out.println("<h2>Failed to add staff member.</h2>");
            }
            
            // Close the resources
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (Exception e) {
            request.getRequestDispatcher("register.jsp").include(request, response);
            
            e.printStackTrace(); // Log the exception for debugging
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
        processRequest(request, response);
        
       
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
