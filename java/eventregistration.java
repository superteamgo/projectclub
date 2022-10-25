import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author superadmin
 */
public class eventregistration extends HttpServlet {
// eventusers;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            int regno = Integer.parseInt(request.getParameter("regno"));
            String gender = request.getParameter("gender");
            long phone = Long.parseLong(request.getParameter("phone"));
            String department = request.getParameter("department");
            int year = Integer.parseInt(request.getParameter("year"));
            int eventID = Integer.parseInt(request.getParameter("id"));
            
            
            
            
        // datadase connections stuff
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
        
        String sql = "insert into eventusers(name,registerno,gender,phoneno,department,year,eventid) values(?,?,?,?,?,?,?)";
        
        // insert the data into table
        
        PreparedStatement  stmt = con.prepareStatement(sql);
        
        stmt.setString(1, name);
        stmt.setInt(2, regno);
        stmt.setString(3, gender);
        stmt.setLong(4, phone);
        stmt.setString(5, department);
        stmt.setInt(6, year);
        stmt.setInt(7, eventID);
        stmt.executeUpdate();
        
        
        out.println("<h2 style='color:green'>Successfully User Registered In Database</h2>");
            
        }
        catch (SQLException e) {
        throw new ServletException("Servlet Could not display records.", e);
    }   
        catch (ClassNotFoundException ex) { 
            Logger.getLogger(clubServer.class.getName()).log(Level.SEVERE, null, ex);
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
