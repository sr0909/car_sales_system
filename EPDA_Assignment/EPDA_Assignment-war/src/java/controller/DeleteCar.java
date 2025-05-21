/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dell Vostro
 */
public class DeleteCar extends HttpServlet {

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
        
        String carId = request.getParameter("carId");

        if (carId != null && !carId.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");

                String sql = "DELETE FROM car WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(carId));

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Delete successful
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Car deleted successfully!");
                    
                    response.sendRedirect(request.getContextPath() + "/Car");
                } else {
                    // Delete failed
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Fail to delete!");
                    
                    response.sendRedirect(request.getContextPath() + "/Car");
                }

            } catch (Exception e) {
                e.printStackTrace();
                // Handle errors and redirect with error message
                response.sendRedirect(request.getContextPath() + "/Car?errorMessage=" + URLEncoder.encode("An error occurred. Please try again.", "UTF-8"));
            } finally {
                // Ensure resources are closed
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Handle missing staffId
            response.sendRedirect(request.getContextPath() + "/Car?errorMessage=" + URLEncoder.encode("Invalid Car ID.", "UTF-8"));
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
