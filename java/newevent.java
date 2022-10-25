import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class newevent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            // session management
            HttpSession session = request.getSession(false);
            String uid = "";
            if(session !=null){
                uid = (String) session.getAttribute("uid");
            }
            else{
                out.println("<h2>session is null</h2>");
            }
            
            // data from the user
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            String status = request.getParameter("status");
            String eventid = request.getParameter("eventid");
            if(status!=null){
                stmt.executeUpdate("delete from eventusers where eventid="+ eventid +" ;");
                stmt.executeUpdate("delete from events where eventid= "+ eventid +";");
                response.sendRedirect("/superclub/user.jsp"); 
            }else{
                
                String ename = request.getParameter("eventname");
                String cname = request.getParameter("clubname");
                String date = request.getParameter("datetime");
                Part filePart = request.getPart("file");

                // convert 24 hour time to 12 hour with AM / PM
                String time[] = date.split("T")[1].split(":");
                int hour = Integer.parseInt(time[0]) % 24;
                String niceTime = Integer.toString(hour%12==0?12:hour%12) + ":" + time[1] +" "+ (hour < 12 ? "AM" : "PM");

                // saving the file 
                String fileName = filePart.getSubmittedFileName();
                String filePath  = getServletContext().getRealPath("/")+"static"+ File.separator  + fileName;
                for (Part part : request.getParts()) {
                  part.write(filePath);
                }

                stmt.executeUpdate("insert into events(userid,clubname,eventname,eventdate,eventtime,imagepath) values("+uid+",'"+cname+"','"+ename+"','"+date.split("T")[0]+"','"+niceTime+"','"+fileName+"')");    
                response.sendRedirect("/superclub/user.jsp");  
                out.println("<h2>New event successfully created "+ filePath+"</h2>");
            }
           
        }
        catch (SQLException e) {
            throw new ServletException("Servlet Could not display records.", e);
        }   
        catch (ClassNotFoundException ex) { 
            Logger.getLogger(clubServer.class.getName()).log(Level.SEVERE, null, ex);
        } 
    
    }
   
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
