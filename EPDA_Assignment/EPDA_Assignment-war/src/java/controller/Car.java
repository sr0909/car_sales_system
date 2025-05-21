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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class Car extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("role");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        
        // List to hold car data
        List<Map<String, Object>> carList = new ArrayList<>();
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            String filterStatus = request.getParameter("filter_status");
            
            if (userRole.equals("managing")) {
                // Initialize the SQL query depending on filterStatus
                if (filterStatus == null || "Available".equals(filterStatus)) {
                    // If filter_status is null or Completed
                    sql = "SELECT * FROM car WHERE status = 'Available' ORDER BY brand";

                    pstmt = conn.prepareStatement(sql);

                    filterStatus = "Available";

                } else if ("ALL".equals(filterStatus)) {
                    // If filter_status is ALL
                    sql = "SELECT * FROM car ORDER BY brand";

                    pstmt = conn.prepareStatement(sql);

                } else {
                    // If filter_status is provided and not ALL
                    sql = "SELECT * FROM car WHERE status = ? ORDER BY brand";

                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, filterStatus); 
                }
            } else {
                sql = "SELECT * FROM car WHERE status = 'Available' ORDER BY brand";
                
                pstmt = conn.prepareStatement(sql);
            }

            // Execute query
            ResultSet rs = pstmt.executeQuery();
            
            // Check if ResultSet contains data
            boolean hasData = false;
            
            while (rs.next()) {
                hasData = true;
                
                Map<String, Object> carData = new HashMap<>();
                
                carData.put("no", rs.getRow());
                carData.put("id", rs.getInt("id"));
                carData.put("brand", rs.getString("brand"));
                carData.put("model", rs.getString("model"));
                carData.put("year", rs.getString("year"));
                carData.put("mileage", rs.getString("mileage"));
                carData.put("fuel_type", rs.getString("fuel_type"));
                carData.put("price", rs.getDouble("price"));
                carData.put("img_path", rs.getString("img_path"));
                carData.put("status", rs.getString("status"));
                carList.add(carData);
            }
            
            // Set carList as request attribute
            request.setAttribute("userRole", userRole);
            request.setAttribute("carList", carList);
            request.setAttribute("hasData", hasData);
            request.setAttribute("filter_status", filterStatus);

            // Forward the request to car.jsp
            request.getRequestDispatcher("car.jsp").forward(request, response);
            
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
        processRequest(request, response);
        
        HttpSession session = request.getSession();

        // Retrieve and clear the success message from the session
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        
        session.removeAttribute("successMessage");
        session.removeAttribute("errorMessage");

        request.setAttribute("successMessage", successMessage);
        request.setAttribute("errorMessage", errorMessage);

        RequestDispatcher dispatcher = request.getRequestDispatcher("car.jsp");
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
