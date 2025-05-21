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
public class PurchaseDetails extends HttpServlet {

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
        
            String salesIdStr = request.getParameter("sales_id");
            String customerIdStr = request.getParameter("customer_id");
            String feedbackIdStr = request.getParameter("feedback_id");
            String feedback = request.getParameter("feedback");
            String ratingStr = request.getParameter("rating");
            
            int sales_id = Integer.parseInt(salesIdStr);
            int customer_id = Integer.parseInt(customerIdStr);
            int feedback_id = Integer.parseInt(feedbackIdStr);
            int rating = 0;
            
            // Check is the rating empty or not
            if (ratingStr == null || ratingStr.isEmpty()) {
                String errorMessage = "Please rate the purchase!";
                
                response.sendRedirect(request.getContextPath() + "/PurchaseDetails?salesId=" + sales_id + "&errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));

                return;  // Exit the method 
            } else {
                rating = Integer.parseInt(ratingStr);
            }
            
            String feedbackMode = request.getParameter("feedbackMode");
            String sql = null;
            
            if (feedbackMode.equals("create")) {
                sql = "INSERT INTO feedback (sales_id, customer_id, feedback, rating) " + "VALUES (?, ?, ?, ?)";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, sales_id);
                pstmt.setInt(2, customer_id);
                pstmt.setString(3, feedback);
                pstmt.setInt(4, rating);
                
            } else {
                sql = "UPDATE feedback SET feedback = ?, rating = ? WHERE id = ?";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, feedback);
                pstmt.setInt(2, rating);
                pstmt.setInt(3, feedback_id);
            }
            
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Feedback made successfully!");

                response.sendRedirect(request.getContextPath() + "/Purchase");
            } else {
                // Update failed
                request.setAttribute("errorMessage", "Feedback failed. Please try again.");

                response.sendRedirect(request.getContextPath() + "/Purchase");
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

        // Get the salesId from the request parameter
        String salesId = request.getParameter("salesId");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            
            String getCustomerIdSql = "SELECT * FROM customer WHERE username = ?"; 
            
            pstmt = conn.prepareStatement(getCustomerIdSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            int customer_id = 0;
            String customer_name = null;
            
            while (rs.next()) {
                customer_id = rs.getInt("id");
                customer_name = rs.getString("customer_name");
            }
            
            request.setAttribute("customer_id", customer_id);
            request.setAttribute("customer_name", customer_name);
            
            
            // Check if the salesId is not null and proceed
            if (salesId != null) {
                int id = Integer.parseInt(salesId);
            
                String sql = "SELECT * FROM sales WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
            
                if (rs.next()) {
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
                    String color = null;
                    String fuel_type = null;
                    String transmission = null;
                    String img_path = null;
                    String priceStr = null;
                    String engineCapacityStr = null;
                    
                    int year = 0;
                    int mileage = 0;
                    
                    Double price = 0.0;
                    Double engine_capacity = 0.0;

                    while (carRS.next()) {
                        brand = carRS.getString("brand");
                        model = carRS.getString("model");
                        color = carRS.getString("color");
                        fuel_type = carRS.getString("fuel_type");
                        transmission = carRS.getString("transmission");
                        img_path = carRS.getString("img_path");
                        
                        year = carRS.getInt("year");
                        mileage = carRS.getInt("mileage");
                        
                        price = carRS.getDouble("price");
                        engine_capacity = carRS.getDouble("engine_capacity");
                        
                        priceStr = price.toString();
                        engineCapacityStr = engine_capacity.toString();
                    }
                    
                    // Get payment info if sales status = Completed
                    String status = rs.getString("status");
                    
                    if (status.equals("Completed")) {
                        String getPaymentSql = "SELECT * FROM payment WHERE sales_id = ?"; 

                        pstmt = conn.prepareStatement(getPaymentSql);
                        pstmt.setInt(1, id);
                        ResultSet paymentRS = pstmt.executeQuery();
                        
                        String payment_method = null;
                        String payment_date = null;
                        Double amount_paid = 0.0;
                        Double balance = 0.0;

                        while (paymentRS.next()) {
                            payment_method = paymentRS.getString("payment_method");
                            payment_date = paymentRS.getString("payment_date");
                            amount_paid = paymentRS.getDouble("amount_paid");
                            balance = paymentRS.getDouble("balance");
                        }
                        
                        request.setAttribute("payment_method", payment_method);
                        request.setAttribute("payment_date", payment_date);
                        request.setAttribute("amount_paid", amount_paid);
                        request.setAttribute("balance", balance);
                    }
                    
                    // Get feedback
                    String getFeedbackSql = "SELECT * FROM feedback WHERE sales_id = ?"; 

                    pstmt = conn.prepareStatement(getFeedbackSql);
                    pstmt.setInt(1, id);
                    ResultSet feedbackRS = pstmt.executeQuery();
                    
                    String feedbackMode = "create";
                    String feedback = null;
                    int feedback_id = 0;
                    int rating = 0;

                    while (feedbackRS.next()) {
                        feedbackMode = "edit";
                        
                        feedback_id = feedbackRS.getInt("id");
                        feedback = feedbackRS.getString("feedback");
                        rating = feedbackRS.getInt("rating");
                    }
                        
                    request.setAttribute("feedback_id", feedback_id);
                    request.setAttribute("feedbackMode", feedbackMode);
                    request.setAttribute("feedback", feedback);
                    request.setAttribute("rating", rating);
                    
                    // Set attributes to forward to JSP
                    request.setAttribute("mode", status); // Set sales status
                    request.setAttribute("sales_id", id);
                    request.setAttribute("car_id", rs.getInt("car_id"));
                    request.setAttribute("staff_name", staff_name);
                    request.setAttribute("sales_date", rs.getString("sales_date"));
                    request.setAttribute("comment", rs.getString("comment"));
                    request.setAttribute("brand", brand);
                    request.setAttribute("model", model);
                    request.setAttribute("color", color);
                    request.setAttribute("fuel_type", fuel_type);
                    request.setAttribute("transmission", transmission);
                    request.setAttribute("year", year);
                    request.setAttribute("mileage", mileage);
                    request.setAttribute("price", priceStr);
                    request.setAttribute("engine_capacity", engineCapacityStr);
                    request.setAttribute("img_path", img_path);
                    
                    
                    // Set the error message in url as request
                    String errorMessage = request.getParameter("errorMessage");
                    if (errorMessage != null) {
                        request.setAttribute("errorMessage", errorMessage);
                    }
                
                    // Forward to the JSP for display
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/purchasedetails.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Purchase");
                    out.println("Purchase history not found.");
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
