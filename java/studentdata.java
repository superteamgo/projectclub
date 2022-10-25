import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;


public class studentdata extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            
            
        // getting data from user by post method
        
        String name = request.getParameter("studentname");
        int regno = Integer.parseInt(request.getParameter("regno"));
        String gender = request.getParameter("gender");
        int year = Integer.parseInt(request.getParameter("stdYear"));
        String clubname = request.getParameter("clubName");
        String department = request.getParameter("department");
        String dob = request.getParameter("brithDay");
        String email = request.getParameter("email");
        String[] terms = request.getParameterValues("terms");
        
            
            
            
        // datadase connections stuff
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
        Statement stmt = con.createStatement();
        String terms_of_service = "no",privacy_policy = "no";
        if(terms.length==2){
            terms_of_service = privacy_policy = "yes";
        }else{
            if(Arrays.asList(terms).contains("yes1")){
                terms_of_service = "yes";
            }else{
                privacy_policy = "yes";
            }
        }
        
        // insert the data into table
        
        String sql = "insert into studentinfo(name,regno,gender,year,department,clubname,dob,email,terms_of_service,privacy_policy)"
        + "values('"+name+"','"+regno+"','"+gender+"','"+year+"','"+department+"','"+clubname+"','"+dob+"','"+email+
        "','"+terms_of_service+"','"+privacy_policy+"')";
        stmt.executeUpdate(sql);
        out.println("<h2 style='color:green'>Successfully User Registered In Database</h2>");
            
    }
    catch (SQLException e) {
        out.println("<h2 style='color:orange'>Error found while inserting data in database</h2>");
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
