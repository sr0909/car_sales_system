package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class EditProfile extends HttpServlet {

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
        
        String mode = request.getParameter("mode");
        
        HttpSession session = request.getSession(false); 
            
        // Retrieve the role attribute from the session
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");

        String tablename = null;
        String dbname = null;

        if (role.equals("customer")) {
            tablename = role;
            dbname = "customer_name";
        } else {
            tablename = "staff";
            dbname = "staff_name";
        }
        
        String name = request.getParameter(dbname);
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String zip_code = request.getParameter("zip_code");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String dob = request.getParameter("dob");
        char gender = request.getParameter("gender").charAt(0);

        // Define the input format (d-m-Y) and the output format (Y-m-d)
        SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            // Parse the input date string
            Date parsedDob = inputFormat.parse(dob);

            // Format the parsed date to the desired output format
            String formattedDob = outputFormat.format(parsedDob);
                
            if ("edit".equals(mode)) {
                sql = "UPDATE " + tablename + " SET " + dbname + " = ?, email = ?, phone = ?, street = ?, city = ?, zip_code = ?, state = ?, country = ?, gender = ?, dob = ? WHERE username = ?";
                
            } else {
                // For first time login customer
                sql = "INSERT INTO " + tablename + " (" + dbname + ", email, phone, street, city, zip_code, state, country, gender, dob, username) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, street);
            pstmt.setString(5, city);
            pstmt.setString(6, zip_code);
            pstmt.setString(7, state);
            pstmt.setString(8, country);
            pstmt.setString(9, String.valueOf(gender));
            pstmt.setString(10, formattedDob);
            pstmt.setString(11, username);
            
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update successful
                session.setAttribute("successMessage", "Your profile updated successfully!");

                response.sendRedirect(request.getContextPath() + "/Profile");
            } else {
                // Update failed
                request.setAttribute("errorMessage", "Update failed. Please try again.");

                response.sendRedirect(request.getContextPath() + "/Profile");
            }
            
            // Close the resources
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
