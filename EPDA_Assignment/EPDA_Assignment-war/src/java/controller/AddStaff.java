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
//import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dell Vostro
 */
public class AddStaff extends HttpServlet {

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
        
        // Get the form data from the request
        String role = request.getParameter("role");
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        
        String genderParam = request.getParameter("gender");
        char gender = '\0';
        
        String salaryParam = request.getParameter("salary");
        double salary = 0.0;

        // Define the input format (d-m-Y) and the output format (Y-m-d)
        SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            boolean errorStatus = false;
            
            // Check is the role, gender empty or not
            if (role == null || role.isEmpty()) {
                errorStatus = true;
                
                // Set error message as request attributes
                request.setAttribute("errorMessage", "Role cannot be empty!");
            }
            
            if (salaryParam != null && !salaryParam.trim().isEmpty()) {
                try {
                    salary = Double.parseDouble(salaryParam);
                } catch (NumberFormatException e) {
                    // Handle the case where salary input is invalid (not a number)
                    response.sendRedirect(request.getContextPath() + "/errorPage.jsp?errorMessage=Invalid%20salary%20format");
                    return;
                }
            } else {
                // Handle the case where salary is empty
                errorStatus = true;
                
                request.setAttribute("errorMessage", "Salary cannot be empty!");
            }
            
            if (genderParam == null || genderParam.isEmpty() || genderParam.length() != 1) {
                errorStatus = true;

                request.setAttribute("errorMessage", "Gender cannot be empty!");
            } else {
                gender = request.getParameter("gender").charAt(0);
            }
            
            // Check if the password and confirm_password match
            if (!password.equals(confirm_password)) {
                errorStatus = true;
                
                request.setAttribute("errorMessage", "Password and Confirm Password do not match!");
            }
            
            // Check if username exists
            String checkUsernameSql = "SELECT COUNT(*) FROM staff WHERE username = ?";
            pstmt = conn.prepareStatement(checkUsernameSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                errorStatus = true;
                
                request.setAttribute("errorMessage", "Username exists!");
            }
            
            if (errorStatus == true) {
                // Set form data as request attributes
                request.setAttribute("staffrole", role);
                request.setAttribute("staff_name", staff_name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("street", street);
                request.setAttribute("city", city);
                request.setAttribute("zip_code", zip_code);
                request.setAttribute("state", state);
                request.setAttribute("country", country);
                request.setAttribute("dob", dob);
                request.setAttribute("hired_date", hired_date);
                request.setAttribute("terminated_date", terminated_date);
                request.setAttribute("status", status);
                request.setAttribute("username", username);
                request.setAttribute("gender", gender);
                request.setAttribute("salary", salary);

                // Forward the request back to the JSP page
                RequestDispatcher dispatcher = request.getRequestDispatcher("managingstaffdetails.jsp");
                dispatcher.forward(request, response);
                
                return;  // Exit the method 
            }
            
            // Parse the input date string
            Date parsedDob = inputFormat.parse(dob);
            Date parsedHiredDate = inputFormat.parse(hired_date);

            // Format the parsed date to the desired output format
            String formattedDob = outputFormat.format(parsedDob);
            String formattedHiredDate = outputFormat.format(parsedHiredDate);

            String sql = "INSERT INTO staff (staff_name, email, phone, street, city, zip_code, state, country, dob, hired_date, terminated_date, status, gender, salary, username, role) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staff_name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, street);
            pstmt.setString(5, city);
            pstmt.setString(6, zip_code);
            pstmt.setString(7, state);
            pstmt.setString(8, country);
            pstmt.setString(9, formattedDob);
            pstmt.setString(10, formattedHiredDate);
            
            // Check if terminated_date is provided or not
            if (status.equals("Inactive")) {
                Date parsedTerminatedDate = inputFormat.parse(terminated_date);
                String formattedTerminatedDate = outputFormat.format(parsedTerminatedDate);
                
                pstmt.setString(11, formattedTerminatedDate);
            } else {
                pstmt.setNull(11, java.sql.Types.VARCHAR);
            }

            pstmt.setString(12, status);
            pstmt.setString(13, String.valueOf(gender));
            pstmt.setDouble(14, salary);
            pstmt.setString(15, username);
            pstmt.setString(16, role);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                // Insert into app_user table
                String appUserSql = "INSERT INTO app_user (username, email, password, user_role) VALUES (?, ?, ?, ?)";

                PreparedStatement appUserPstmt = conn.prepareStatement(appUserSql);
                appUserPstmt.setString(1, username);
                appUserPstmt.setString(2, email);
                appUserPstmt.setString(3, password);
                appUserPstmt.setString(4, role);

                int appUserResult = appUserPstmt.executeUpdate();
                
                if (appUserResult > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Staff member and user account created successfully!");
                    
                    // Redirect to the servlet
                    response.sendRedirect(request.getContextPath() + "/ManagingStaff");
                } else {
                    // Handle failure to insert into app_user
                    out.println("<h2>Failed to add user account.</h2>");
                }

                appUserPstmt.close();
                
            } else {
                out.println("<h2>Failed to add staff member.</h2>");
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
