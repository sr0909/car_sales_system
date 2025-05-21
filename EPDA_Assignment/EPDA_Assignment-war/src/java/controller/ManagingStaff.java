package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
public class ManagingStaff extends HttpServlet {

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
        
        // List to hold staff data
        List<Map<String, Object>> staffList = new ArrayList<>();
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");

//            String sql = "SELECT * FROM staff WHERE role = ?";
            String sql = "SELECT * FROM staff";

            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, "managing");

            // Execute query
            ResultSet rs = stmt.executeQuery();
            
            // Check if ResultSet contains data
            boolean hasData = false;
            
            while (rs.next()) {
                hasData = true;
                
                String dbrole = rs.getString("role");
                String role = "";
                
                if (dbrole.equals("managing")) {
                    role = "Managing Staff";
                } else {
                    role = "Salesman";
                }
                
                Map<String, Object> staffData = new HashMap<>();
                
                staffData.put("no", rs.getRow());
                staffData.put("id", rs.getInt("id"));
                staffData.put("role", role);
                staffData.put("staff_name", rs.getString("staff_name"));
                staffData.put("hired_date", rs.getString("hired_date"));
                staffData.put("terminated_date", rs.getString("terminated_date"));
                staffData.put("salary", rs.getDouble("salary"));
                staffData.put("status", rs.getString("status"));
                staffList.add(staffData);
            }
            
            // Set staffList as request attribute
            request.setAttribute("staffList", staffList);
            request.setAttribute("hasData", hasData);

            // Forward the request to managingstaff.jsp
            request.getRequestDispatcher("managingstaff.jsp").forward(request, response);
            
            // Close the resources
            rs.close();
            stmt.close();
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
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
    
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

        // Handle displaying staff list
        // (Querying and setting staff list as before)

        RequestDispatcher dispatcher = request.getRequestDispatcher("managingstaff.jsp");
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
