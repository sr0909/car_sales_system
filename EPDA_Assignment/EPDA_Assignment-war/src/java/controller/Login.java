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
//import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dell Vostro
 */
public class Login extends HttpServlet {

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
        
        // Get the username and password from the request (login form)
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        Connection conn = null;
        
        try (PrintWriter out = response.getWriter()) {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            // Query
            String sql = "SELECT * FROM app_user WHERE username = ? AND user_role = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);  // Set the username 
            stmt.setString(2, userType);  // Set the user_role 

            // Execute query
            ResultSet rs = stmt.executeQuery();
            
            // Loop through the result set
            if (rs.next()) {
                // Retrieve data from the columns of the current row
                String dbPassword = rs.getString("password");
                String dbRole = rs.getString("user_role");
                
                    if (dbPassword.equals(password)) {
                        // Password matches, login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username); // Store username in session
                        session.setAttribute("role", dbRole); // Store role in session

                        // Redirect to home.jsp
                        response.sendRedirect("welcome.jsp"); 
                    } else {
                        // Password does not match, login failed
                        response.sendRedirect("login.jsp?userType=" + userType + "&error=true");
                    }
                
            } else {
                // Username does not exist in the database
                response.sendRedirect("login.jsp?userType=" + userType + "&error=true");
            }

            // Close the resources
            rs.close();
            stmt.close();
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
        String registersuccessMessage = (String) session.getAttribute("registersuccessMessage");
        
        session.removeAttribute("registersuccessMessage");

        request.setAttribute("registersuccessMessage", registersuccessMessage);

        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
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
