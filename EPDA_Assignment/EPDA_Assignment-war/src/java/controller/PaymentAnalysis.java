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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Dell Vostro
 */
public class PaymentAnalysis extends HttpServlet {

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

        String type = request.getParameter("type");
        String filter_month = request.getParameter("filter_month");
        String filter_year = request.getParameter("filter_year");

        
        try (PrintWriter out = response.getWriter()) {
            // Establish JDBC connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            if (type.equals("daily")) {
                
                if (filter_month != null) {
                    // Get the current year (you can modify this if needed)
                    int current_year = Calendar.getInstance().get(Calendar.YEAR);

                    // Get the number of days in the selected month
                    Calendar cal = Calendar.getInstance();
                    cal.set(current_year, Integer.parseInt(filter_month) - 1, 1);
                    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

                    List<String> days = new ArrayList<>();
                    List<BigDecimal> payments = new ArrayList<>();

                    // Fill the days array with all days of the selected month
                    for (int i = 1; i <= daysInMonth; i++) {
                        days.add(String.valueOf(i));
                        payments.add(BigDecimal.ZERO); // Default to 0 for payment
                    }

                    // SQL query to get total payments by day for the selected month
                    String getPaymentsSql = "SELECT DAY(payment_date) AS day, SUM(price) AS total_payment " +
                                            "FROM payment " +
                                            "WHERE MONTH(payment_date) = ? AND YEAR(payment_date) = ? " +
                                            "GROUP BY DAY(payment_date)";

                    pstmt = conn.prepareStatement(getPaymentsSql);
                    pstmt.setInt(1, Integer.parseInt(filter_month));
                    pstmt.setInt(2, current_year);
                    rs = pstmt.executeQuery();

                    // Check if ResultSet contains data
                    boolean hasData = false;

                    // Fetch results
                    while (rs.next()) {
                        hasData = true;

                        int day = rs.getInt("day");
                        BigDecimal totalPayment = rs.getBigDecimal("total_payment");

                        // Replace 0 payment with actual total_payment for the day
                        payments.set(day - 1, totalPayment);
                    }

                    // Pass data to JSP
                    request.setAttribute("hasData", hasData);
                    request.setAttribute("days", days);
                    request.setAttribute("payments", payments);
                }

                request.setAttribute("filter_month", filter_month);

            } else if (type.equals("monthly")) {
                
                if (filter_year != null) {
                    List<String> months = new ArrayList<>(Arrays.asList(
                        "January", "February", "March", "April", "May", "June",
                        "July", "August", "September", "October", "November", "December"
                    ));
                    
                    List<BigDecimal> payments = new ArrayList<>(Collections.nCopies(12, BigDecimal.ZERO));
                    
                    // SQL query to get total payments by month for the selected year
                    String getMonthlyPaymentsSql = "SELECT MONTH(payment_date) AS month, SUM(price) AS total_payment " +
                                                    "FROM payment " +
                                                    "WHERE YEAR(payment_date) = ? " +
                                                    "GROUP BY MONTH(payment_date)";

                    pstmt = conn.prepareStatement(getMonthlyPaymentsSql);
                    pstmt.setInt(1, Integer.parseInt(filter_year));
                    rs = pstmt.executeQuery();


                    boolean hasData = false;
                    
                    while (rs.next()) {
                        hasData = true;

                        int month = rs.getInt("month");
                        BigDecimal totalPayment = rs.getBigDecimal("total_payment");

                        // Set the payment for the corresponding month
                        payments.set(month - 1, totalPayment);
                    }

                    // Pass data to JSP
                    request.setAttribute("hasData", hasData);
                    request.setAttribute("months", months);
                    request.setAttribute("payments", payments);
                }
                
                request.setAttribute("filter_year", filter_year);
                
            }
            
            // Forward to JSP
            request.getRequestDispatcher("paymentanalysis.jsp").forward(request, response);
            
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
