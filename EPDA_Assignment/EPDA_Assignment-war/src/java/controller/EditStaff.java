package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
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
public class EditStaff extends HttpServlet {

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
        
        try (PrintWriter out = response.getWriter()) {
            
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
        
        // Get the staffId from the request parameter
        String staffId = request.getParameter("staffId");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Check if the staffId is not null and proceed
        if (staffId != null) {
            int id = Integer.parseInt(staffId);
            
            
            try (PrintWriter out = response.getWriter()) {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
                String sql = "SELECT * FROM staff WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
            
                if (rs.next()) {
                    // Retrieve staff details and set them in the request
                    String role = rs.getString("role");
                    String staff_name = rs.getString("staff_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String street = rs.getString("street");
                    String city = rs.getString("city");
                    String zip_code = rs.getString("zip_code");
                    String state = rs.getString("state");
                    String country = rs.getString("country");
                    String status = rs.getString("status");
                    String gender = rs.getString("gender");

                    Date dob = rs.getDate("dob");
                    Date hired_date = rs.getDate("hired_date");
                    Date terminated_date = rs.getDate("terminated_date");
                    
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    
                    String formattedDob = sdf.format(dob);
                    String formattedHiredDate = sdf.format(hired_date);
                    String formattedTerminatedDate =    (terminated_date != null) ? sdf.format(terminated_date) : null;
                    
                    BigDecimal salary = rs.getBigDecimal("salary");
                    String salaryStr = salary.setScale(2, RoundingMode.HALF_UP).toString();

                    // Set attributes to forward to JSP
                    request.setAttribute("mode", "edit");
                    request.setAttribute("staff_id", id);
                    request.setAttribute("staffrole", role);
                    request.setAttribute("staff_name", staff_name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("street", street);
                    request.setAttribute("city", city);
                    request.setAttribute("zip_code", zip_code);
                    request.setAttribute("state", state);
                    request.setAttribute("country", country);
                    request.setAttribute("dob", formattedDob);
                    request.setAttribute("hired_date", formattedHiredDate);
                    request.setAttribute("terminated_date", formattedTerminatedDate);
                    request.setAttribute("status", status);
                    request.setAttribute("gender", gender);
                    request.setAttribute("salary", salaryStr);
                
                    // Forward to the JSP for display
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/managingstaffdetails.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // Staff not found
                    // Redirect to the servlet
                    response.sendRedirect(request.getContextPath() + "/ManagingStaff");
                    out.println("Staff not found.");
                }
                
                // Close the resources
                rs.close();
                pstmt.close();
                conn.close();
            
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        } else {
            // Handle the case where staffId is missing
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid staff ID");
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
//        processRequest(request, response);

        String mode = request.getParameter("mode");
        
        if ("update".equals(mode)) {
            
            String staffId = request.getParameter("staff_id");
            String staff_name = request.getParameter("staff_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String zip_code = request.getParameter("zip_code");
            String state = request.getParameter("state");
            String country = request.getParameter("country");
            String dob = request.getParameter("dob");
            String hired_date = request.getParameter("hired_date");
            String terminated_date = request.getParameter("terminated_date");
            String status = request.getParameter("status");
            char gender = request.getParameter("gender").charAt(0);
            double salary = Double.parseDouble(request.getParameter("salary"));
            
            // Define the input format (d-m-Y) and the output format (Y-m-d)
            SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
 
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try (PrintWriter out = response.getWriter()) {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
                
                // Parse the input date string
                Date parsedDob = inputFormat.parse(dob);
                Date parsedHiredDate = inputFormat.parse(hired_date);

                // Format the parsed date to the desired output format
                String formattedDob = outputFormat.format(parsedDob);
                String formattedHiredDate = outputFormat.format(parsedHiredDate);
                
                String sql = "UPDATE staff SET staff_name = ?, email = ?, phone = ?, street = ?, city = ?, zip_code = ?, state = ?, country = ?, status = ?, gender = ?, dob = ?, hired_date = ?, terminated_date = ?, salary = ? WHERE id = ?";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, staff_name);
                pstmt.setString(2, email);
                pstmt.setString(3, phone);
                pstmt.setString(4, street);
                pstmt.setString(5, city);
                pstmt.setString(6, zip_code);
                pstmt.setString(7, state);
                pstmt.setString(8, country);
                pstmt.setString(9, status);
                pstmt.setString(10, String.valueOf(gender));
                pstmt.setString(11, formattedDob);
                pstmt.setString(12, formattedHiredDate);
                
                // Check if terminated_date is provided or not
                if (status.equals("Inactive")) {
                    Date parsedTerminatedDate = inputFormat.parse(terminated_date);
                    String formattedTerminatedDate = outputFormat.format(parsedTerminatedDate);

                    pstmt.setString(13, formattedTerminatedDate);
                } else {
                    pstmt.setNull(13, java.sql.Types.VARCHAR);
                }
            
                pstmt.setDouble(14, salary);
                pstmt.setInt(15, Integer.parseInt(staffId));
                
                int rowsAffected = pstmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    // Update successful
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Staff member updated successfully!");
                
                    response.sendRedirect(request.getContextPath() + "/ManagingStaff");
                } else {
                    // Update failed
                    request.setAttribute("errorMessage", "Update failed. Please try again.");
                    
                    response.sendRedirect(request.getContextPath() + "/EditStaff?staffId=" + staffId);
                }
            
                // Close the resources
                pstmt.close();
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
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
