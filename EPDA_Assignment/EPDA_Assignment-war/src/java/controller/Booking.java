/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
public class Booking extends HttpServlet {

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
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
        
            String carIdStr = request.getParameter("car_id");
            String staffIdStr = request.getParameter("staff_id");
            String customerIdStr = request.getParameter("customer_id");
            String sales_date = request.getParameter("sales_date");
            String priceStr = request.getParameter("price");
            
            double price = Double.parseDouble(priceStr);
           
            int car_id = Integer.parseInt(carIdStr);
            int staff_id = Integer.parseInt(staffIdStr);
            int customer_id = Integer.parseInt(customerIdStr);
            
            // Define the input format (d-m-Y) and the output format (Y-m-d)
            SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
        
            Date parsedSalesDate = inputFormat.parse(sales_date);
            String formattedSalesDate = outputFormat.format(parsedSalesDate);
            
            String updateCarStatusSql = "UPDATE car SET status = ? WHERE id = ?";
            
            pstmt = conn.prepareStatement(updateCarStatusSql);
            pstmt.setString(1, "Booked");
            pstmt.setInt(2, car_id);
            
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update car status successful
                String createSalesSql = "INSERT INTO sales (car_id, customer_id, staff_id, sales_date, status, price) " + "VALUES (?, ?, ?, ?, ?, ?)";
                
                pstmt = conn.prepareStatement(createSalesSql);
                pstmt.setInt(1, car_id);
                pstmt.setInt(2, customer_id);
                pstmt.setInt(3, staff_id);
                pstmt.setString(4, formattedSalesDate);
                pstmt.setString(5, "Pending");
                pstmt.setDouble(6, price);

                int createdRowsAffected = pstmt.executeUpdate();
                
                if (createdRowsAffected > 0) {
                
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Car booked successfully!");

                    response.sendRedirect(request.getContextPath() + "/Car");
                }
            } else {
                // Update failed
                request.setAttribute("errorMessage", "Booking failed. Please try again.");

                response.sendRedirect(request.getContextPath() + "/Car");
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
//        processRequest(request, response);

        // Get the carId from the request parameter
        String carId = request.getParameter("carId");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            
            String getStaffIdSql = "SELECT * FROM staff WHERE username = ?"; 
            
            pstmt = conn.prepareStatement(getStaffIdSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            int staff_id = 0;
            String staff_name = null;
            
            while (rs.next()) {
                staff_id = rs.getInt("id");
                staff_name = rs.getString("staff_name");
            }
            
            request.setAttribute("staff_id", staff_id);
            request.setAttribute("staff_name", staff_name);
            
            // Get customer list
            String customerSql = "SELECT * FROM customer"; 
            List<Map<String, Object>> customerList = new ArrayList<>();
            
            pstmt = conn.prepareStatement(customerSql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> customerData = new HashMap<>();
                
                customerData.put("customer_id", rs.getInt("id"));
                customerData.put("customer_name", rs.getString("customer_name"));
                customerList.add(customerData);
            }
            
            request.setAttribute("customerList", customerList);
            
            // Check if the carId is not null and proceed
            if (carId != null) {
                int id = Integer.parseInt(carId);
    
                String sql = "SELECT * FROM car WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
            
                if (rs.next()) {
                    // Retrieve car details and set them in the request
                    String brand = rs.getString("brand");
                    String model = rs.getString("model");
                    String color = rs.getString("color");
                    String fuel_type = rs.getString("fuel_type");
                    String transmission = rs.getString("transmission");
                    String status = rs.getString("status");
                    String img_path = rs.getString("img_path");
                    
                    int year = rs.getInt("year");
                    int mileage = rs.getInt("mileage");

                    BigDecimal price = rs.getBigDecimal("price");
                    BigDecimal engine_capacity = rs.getBigDecimal("engine_capacity");
                    
                    String priceStr = price.toString();
                    String engineCapacityStr = engine_capacity.toString();
                    
                    // Get today's date
                    Date today = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                    String formattedDate = formatter.format(today);

                    // Set attributes to forward to JSP
//                    request.setAttribute("mode", "edit");
                    request.setAttribute("car_id", id);
                    request.setAttribute("brand", brand);
                    request.setAttribute("model", model);
                    request.setAttribute("color", color);
                    request.setAttribute("fuel_type", fuel_type);
                    request.setAttribute("transmission", transmission);
                    request.setAttribute("status", status);
                    request.setAttribute("year", year);
                    request.setAttribute("mileage", mileage);
                    request.setAttribute("price", priceStr);
                    request.setAttribute("engine_capacity", engineCapacityStr);
                    request.setAttribute("img_path", img_path);
                    request.setAttribute("today_date", formattedDate);
                
                    // Forward to the JSP for display
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/booking.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Car");
                    out.println("Car not found.");
                }
                
            }
            
            // Close the resources
            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
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
