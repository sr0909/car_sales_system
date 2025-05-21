/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Dell Vostro
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
                 maxFileSize = 1024 * 1024 * 10,         // 10MB
                 maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class AddCar extends HttpServlet {

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
        
        String mode = request.getParameter("mode");
        
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carsales?zeroDateTimeBehavior=convertToNull", "root", "");
        
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String color = request.getParameter("color");
            String fuel_type = request.getParameter("fuel_type");
            String transmission = request.getParameter("transmission");
            String status = request.getParameter("status");
        
            String priceStr = request.getParameter("price");
            String engineCapacityStr = request.getParameter("engine_capacity");
            
            double price = 0.0;
            double engine_capacity = 0.0;
            
            price = Double.parseDouble(priceStr);
            engine_capacity = Double.parseDouble(engineCapacityStr);

            String yearStr = request.getParameter("year");
            String mileageStr = request.getParameter("mileage");

            int year = Integer.parseInt(yearStr);
            int mileage = Integer.parseInt(mileageStr);
            
            String imagePath = null;
            int carId = 0;
            
            if ("edit".equals(mode)) {
                String carIdStr = request.getParameter("car_id");
                carId = Integer.parseInt(carIdStr);
        
                sql = "UPDATE car SET year = ?, price = ?, mileage = ?, color = ?, fuel_type = ?, transmission = ?, engine_capacity = ?, status = ? WHERE id = ?";
               
            } else {
                // Directory name to save the uploaded img
                String SAVE_DIR = "images";

                // Getting the upload file part
                Part filePart = request.getPart("img_path");

                // Get the original file name
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Extract file extension
                String fileExtension = "";
                int dotIndex = originalFileName.lastIndexOf('.');
                if (dotIndex > 0) {
                    fileExtension = originalFileName.substring(dotIndex + 1);
                }
                
                // Generate timestamp String
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
                String timestamp = now.format(formatter);

                // Construct the file name
                String fileName = brand + "_" + model + "_" + timestamp + "." + fileExtension;

                // Define the directory where you want to save the uploaded files
                String savePath = "C:\\Users\\Dell Vostro\\Documents\\NetBeansProjects\\EPDA_Assignment\\EPDA_Assignment-war\\build\\web\\images";

                // Ensure the directory exists
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }

                // Full path where the file will be saved
                Path filePath = new File(savePath, fileName).toPath();

                // Save the file using Files.copy
                try (InputStream inputStream = filePart.getInputStream()) {
                    Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
    //                response.getWriter().println("File saved successfully!");
                } catch (IOException e) {
                    e.printStackTrace();
    //                response.getWriter().println("Error saving file: " + e.getMessage());
                }

                // Relative path to be stored in the database
                imagePath = SAVE_DIR + File.separator + fileName;

                // SQL to insert car data
                sql = "INSERT INTO car (brand, model, year, price, mileage, color, fuel_type, transmission, engine_capacity, img_path, status) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
            }
            
            pstmt = conn.prepareStatement(sql);
            
            if ("edit".equals(mode)) {
                
                pstmt.setInt(1, year);
                pstmt.setDouble(2, price);
                pstmt.setInt(3, mileage);
                pstmt.setString(4, color);
                pstmt.setString(5, fuel_type);
                pstmt.setString(6, transmission);
                pstmt.setDouble(7, engine_capacity);
                pstmt.setString(8, status);
                pstmt.setInt(9, carId);
                
            } else {
                
                pstmt.setString(1, brand);
                pstmt.setString(2, model);
                pstmt.setInt(3, year);
                pstmt.setDouble(4, price);
                pstmt.setInt(5, mileage);
                pstmt.setString(6, color);
                pstmt.setString(7, fuel_type);
                pstmt.setString(8, transmission);
                pstmt.setDouble(9, engine_capacity);
                pstmt.setString(10, imagePath);
                pstmt.setString(11, status);
            }
            
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Add/Edit successful
                HttpSession session = request.getSession();
                
                if ("edit".equals(mode)) {
                    session.setAttribute("successMessage", "Car details updated successfully!");
                } else {
                    session.setAttribute("successMessage", "Car added successfully!");
                }
                
                response.sendRedirect(request.getContextPath() + "/Car");
            } else {
                // Add/Edit failed
                request.setAttribute("errorMessage", "Operation failed. Please try again.");

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
            
            String brandSql = "SELECT * FROM car_brand ORDER BY brand_name"; 
            List<String> brands = new ArrayList<>();
            
            pstmt = conn.prepareStatement(brandSql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                brands.add(rs.getString("brand_name"));
            }
            
            request.setAttribute("brands", brands);
                
            // Check if the carId is not null and proceed
            if (carId != null) {
                int id = Integer.parseInt(carId);
    
                String sql = "SELECT * FROM car WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
            
                if (rs.next()) {
                    // Retrieve staff details and set them in the request
                    String brand = rs.getString("brand");
                    String model = rs.getString("model");
                    String color = rs.getString("color");
                    String fuel_type = rs.getString("fuel_type");
                    String transmission = rs.getString("transmission");
                    String status = rs.getString("status");
                    
                    int year = rs.getInt("year");
                    int mileage = rs.getInt("mileage");

                    BigDecimal price = rs.getBigDecimal("price");
                    BigDecimal engine_capacity = rs.getBigDecimal("engine_capacity");
                    
                    String priceStr = price.toString();
                    String engineCapacityStr = engine_capacity.toString();

                    // Set attributes to forward to JSP
                    request.setAttribute("mode", "edit");
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
                    
                    // If status == Booked or Paid, get customer_name & staff_name
                    String getSalesSql = "SELECT * FROM sales WHERE car_id = ?";
                    pstmt = conn.prepareStatement(getSalesSql);
                    pstmt.setInt(1, id);
                    ResultSet salesRS = pstmt.executeQuery();

                    if (salesRS.next()) {
                        int customer_id = salesRS.getInt("customer_id");
                        int staff_id = salesRS.getInt("staff_id");
                        
                        
                        String getCustomerSql = "SELECT * FROM customer WHERE id = ?";
                        pstmt = conn.prepareStatement(getCustomerSql);
                        pstmt.setInt(1, customer_id);
                        ResultSet customerRS = pstmt.executeQuery();
                        
                        if (customerRS.next()) {
                            request.setAttribute("customer_name", customerRS.getString("customer_name"));
                        }
                        
                        String getStaffSql = "SELECT * FROM staff WHERE id = ?";
                        pstmt = conn.prepareStatement(getStaffSql);
                        pstmt.setInt(1, staff_id);
                        ResultSet staffRS = pstmt.executeQuery();
                        
                        if (staffRS.next()) {
                            request.setAttribute("staff_name", staffRS.getString("staff_name"));
                        }
                        
                        customerRS.close();
                        staffRS.close();
                    }
                
                    // Forward to the JSP for display
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/cardetails.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Car");
                    out.println("Car not found.");
                }
                
            } else {
                // Handle the case where to add new car
                RequestDispatcher dispatcher = request.getRequestDispatcher("/cardetails.jsp");
                dispatcher.forward(request, response);
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
