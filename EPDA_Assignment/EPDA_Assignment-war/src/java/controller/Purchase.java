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
public class Purchase extends HttpServlet {

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
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // List to hold sales data
        List<Map<String, Object>> salesList = new ArrayList<>();
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            
            String getStaffIdSql = "SELECT * FROM customer WHERE username = ?"; 
            
            pstmt = conn.prepareStatement(getStaffIdSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            int customer_id = 0;
            String customer_name = null;
            
            while (rs.next()) {
                customer_id = rs.getInt("id");
                customer_name = rs.getString("customer_name");
            }
            
//            request.setAttribute("staff_id", staff_id);
//            request.setAttribute("staff_name", staff_name);

            String filterStatus = request.getParameter("filter_status");
            String sql = null;
            
            // Initialize the SQL query depending on filterStatus
            if (filterStatus == null || "Completed".equals(filterStatus)) {
                // If filter_status is null or Completed
                sql = "SELECT * FROM sales WHERE customer_id = ? AND status = 'Completed' ORDER BY sales_date";

                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, customer_id);
                
                filterStatus = "Completed";

            } else if ("ALL".equals(filterStatus)) {
                // If filter_status is ALL
                sql = "SELECT * FROM sales WHERE customer_id = ? ORDER BY sales_date";

                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, customer_id);

            } else {
                // If filter_status is provided and not ALL
                sql = "SELECT * FROM sales WHERE customer_id = ? AND status = ? ORDER BY sales_date";

                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, customer_id);
                pstmt.setString(2, filterStatus); 
            }

            rs = pstmt.executeQuery();
           
            // Check if ResultSet contains data
            boolean hasData = false;
            
            while (rs.next()) {
                hasData = true;
                
                // Get staff name
                String getStaffSql = "SELECT * FROM staff WHERE id = ?"; 
            
                pstmt = conn.prepareStatement(getStaffSql);
                pstmt.setInt(1, rs.getInt("staff_id"));
                ResultSet staffRS = pstmt.executeQuery();

                String staff_name = null;

                while (staffRS.next()) {
                    staff_name = staffRS.getString("staff_name");
                }
                
                // Get car details
                String getCarSql = "SELECT * FROM car WHERE id = ?"; 
            
                pstmt = conn.prepareStatement(getCarSql);
                pstmt.setInt(1, rs.getInt("car_id"));
                ResultSet carRS = pstmt.executeQuery();

                String brand = null;
                String model = null;
                String img_path = null;
                Double price = 0.0;

                while (carRS.next()) {
                    brand = carRS.getString("brand");
                    model = carRS.getString("model");
                    img_path = carRS.getString("img_path");
                    price = carRS.getDouble("price");
                }
                
                
                Map<String, Object> salesData = new HashMap<>();
                
                salesData.put("no", rs.getRow());
                salesData.put("staff_name", staff_name);
                salesData.put("brand", brand);
                salesData.put("model", model);
                salesData.put("img_path", img_path);
                salesData.put("price", price);
                
                salesData.put("id", rs.getInt("id"));
                salesData.put("sales_date", rs.getString("sales_date"));
//                salesData.put("comment", rs.getString("comment"));
                salesData.put("status", rs.getString("status"));
                
                salesList.add(salesData);
            }
            
            request.setAttribute("customer_id", customer_id);
            request.setAttribute("customer_name", customer_name);
            request.setAttribute("salesList", salesList);
            request.setAttribute("hasData", hasData);
            request.setAttribute("filter_status", filterStatus);

            // Forward the request to sales.jsp
            request.getRequestDispatcher("purchase.jsp").forward(request, response);
            
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("sales.jsp");
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
