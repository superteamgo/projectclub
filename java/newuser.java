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
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;


public class newuser extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
        response.addHeader("Access-Control-Allow-Origin", "*");
        try ( PrintWriter out = response.getWriter()) {
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String action = request.getParameter("action");
            int uid = Integer.parseInt(request.getParameter("uid"));
            out.println(username+" "+password+" "+email+" "+action+" "+uid);
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            switch (action) {
                case "new":
                    stmt.executeUpdate("insert into login(username,password,email) values('"+username+"','"+password+"','"+email+"')");
                    out.println("<h2>New User successfully created</h2>");
                    break;
                case "trash":
                    stmt.executeUpdate("delete from eventusers where eventid in (select eventid from events where userid="+uid+" );");
                    stmt.executeUpdate("delete from events where userid="+uid+";");
                    stmt.executeUpdate("delete from login where uid="+uid+" ;");
                    // delete from eventusers where eventid in (select eventid from events where userid=1);
                    ResultSet rs =  stmt.executeQuery("select * from login");
                    if(!rs.next()){
                        stmt.executeUpdate("ALTER TABLE login AUTO_INCREMENT = 1;");
                    }
                    out.println("<h2>User successfully deleted</h2>");
                    break;
                default:
                    stmt.executeUpdate("update login set username='"+username+"',password='"+password+"',email='"+email+"' where uid="+uid+" ;");
                    out.println("<h2>Record successfully Updated</h2>");
                    break;
            }
            
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
