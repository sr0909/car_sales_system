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
public class Profile extends HttpServlet {

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
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
            
            HttpSession session = request.getSession(false); 
            
            // Retrieve the role attribute from the session
            String role = (String) session.getAttribute("role");
            String username = (String) session.getAttribute("username");

            if (role != null) {
                String tablename = null;
                String dbname = null;
                
                if (role.equals("customer")) {
                    tablename = role;
                    dbname = "customer_name";
                } else {
                    tablename = "staff";
                    dbname = "staff_name";
                }
                
                if (username != null && !username.isEmpty()) {
                    String sql = "SELECT * FROM " + tablename + " WHERE username = ?";
                    
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, username);
                    
                    ResultSet rs = stmt.executeQuery();
                    
                    // Check if ResultSet contains data
                    boolean hasData = false;
                    
                    if (rs.next()) {
                        hasData = true;
                        
                        // Retrieve data from the result set
                        String name = rs.getString(dbname);
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        String street = rs.getString("street");
                        String city = rs.getString("city");
                        String zip_code = rs.getString("zip_code");
                        String state = rs.getString("state");
                        String country = rs.getString("country");
                        String gender = rs.getString("gender");
                        
                        Date dob = rs.getDate("dob");
                    
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                        String formattedDob = sdf.format(dob);
                    
                        request.setAttribute("hasData", hasData);
                        request.setAttribute("name", name);
                        request.setAttribute("email", email);
                        request.setAttribute("phone", phone);
                        request.setAttribute("street", street);
                        request.setAttribute("city", city);
                        request.setAttribute("zip_code", zip_code);
                        request.setAttribute("state", state);
                        request.setAttribute("country", country);
                        request.setAttribute("dob", formattedDob);
                        request.setAttribute("gender", gender);
                        
                        // Forward to the JSP for display
//                        RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
//                        dispatcher.forward(request, response);
                    } else {
                        String getEmailSql = "SELECT * FROM app_user WHERE username = ?";
                    
                        PreparedStatement pstmt = conn.prepareStatement(getEmailSql);
                        pstmt.setString(1, username);

                        ResultSet emailRS = pstmt.executeQuery();
                        
                        if (emailRS.next()) {
                            request.setAttribute("email", emailRS.getString("email"));
                        }
                        
                        emailRS.close();
                        pstmt.close();
                    }
                    
                    request.setAttribute("dbname", dbname);
                    
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
                    dispatcher.forward(request, response);
                    
                    // Close the resources
                    rs.close();
                    stmt.close();
                    conn.close();
                }
            }
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
        

        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
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
