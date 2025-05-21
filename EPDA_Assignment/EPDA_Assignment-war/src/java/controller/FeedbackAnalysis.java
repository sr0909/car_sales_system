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
public class FeedbackAnalysis extends HttpServlet {

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

        String filter_brand = request.getParameter("filter_brand");
        String filter_model = request.getParameter("filter_model");
        
        try (PrintWriter out = response.getWriter()) {
            // Establish JDBC connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            // Get Average Rating
            String getAvgRatingSql = "SELECT AVG(f.rating) AS avg_rating, c.brand, c.model " +
                                     "FROM FEEDBACK f " +
                                     "JOIN SALES s ON f.sales_id = s.id " +
                                     "JOIN CAR c ON s.car_id = c.id " +
                                     "WHERE c.brand = ? AND c.model = ?";

            pstmt = conn.prepareStatement(getAvgRatingSql);
            pstmt.setString(1, filter_brand);
            pstmt.setString(2, filter_model);

            rs = pstmt.executeQuery();

            boolean hasRatingData = false;
            double avg_rating = 0;

            // Fetch the result
            if (rs.next()) {
                avg_rating = rs.getDouble("avg_rating");
                
                // Get the avg_rating value as an Object
                Object avgRatingObject = rs.getObject("avg_rating");

                // Check if the avgRatingObject is NULL
                if (avgRatingObject != null) {
                    hasRatingData = true;
                }
            }
            
            // Get the feedback list of the filter_brand & filter_model
            String getFeedbackSql = "SELECT f.feedback, f.rating " +
                                    "FROM FEEDBACK f " +
                                    "JOIN SALES s ON f.sales_id = s.id " +
                                    "JOIN CAR c ON s.car_id = c.id " +
                                    "WHERE c.brand = ? AND c.model = ? " +
                                    "AND f.feedback IS NOT NULL AND TRIM(f.feedback) <> ''";
    
            pstmt = conn.prepareStatement(getFeedbackSql);
            pstmt.setString(1, filter_brand);
            pstmt.setString(2, filter_model);

            rs = pstmt.executeQuery();

            List<String> feedbackList = new ArrayList<>();
            List<Integer> ratingList = new ArrayList<>();
            
            boolean hasFeedbackData = false;

            while (rs.next()) {
                hasFeedbackData = true;
                
                feedbackList.add(rs.getString("feedback"));
                ratingList.add(rs.getInt("rating"));
            }
    
            // Store the feedback list and ratings in the session (optional)
            HttpSession session = request.getSession();
            session.setAttribute("feedbackList", feedbackList);
            session.setAttribute("ratingList", ratingList);

            String redirectUrl = String.format("FeedbackAnalysis?hasRatingData=%b&hasFeedbackData=%b&avg_rating=%.2f&filter_brand=%s&filter_model=%s", 
    hasRatingData, hasFeedbackData, avg_rating, filter_brand, filter_model);

            // Redirect to the FeedbackAnalysis servlet
            response.sendRedirect(redirectUrl);
            
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

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            // Get brands
            String brandSql = "SELECT * FROM car_brand ORDER BY brand_name"; 
            List<String> brands = new ArrayList<>();
            
            pstmt = conn.prepareStatement(brandSql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                brands.add(rs.getString("brand_name"));
            }
            
            request.setAttribute("brands", brands);
            
            // Get model list
            String modelSql = "SELECT DISTINCT model FROM car ORDER BY model"; 
            List<Map<String, Object>> modelList = new ArrayList<>();
            
            pstmt = conn.prepareStatement(modelSql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> modelData = new HashMap<>();
                
                modelData.put("model", rs.getString("model"));
                modelList.add(modelData);
            }
            
            request.setAttribute("modelList", modelList);
            
            // Forward to the JSP for display
            RequestDispatcher dispatcher = request.getRequestDispatcher("/feedbackanalysis.jsp");
            dispatcher.forward(request, response);
            
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
