<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.ServletException,
 jakarta.servlet.http.HttpServlet,
 jakarta.servlet.http.HttpServletRequest,
 jakarta.servlet.http.HttpServletResponse,
 java.io.IOException,
 java.io.PrintWriter,
 java.sql.Connection,
 java.sql.DriverManager,
 java.sql.Statement,
 java.sql.ResultSet,
 jakarta.servlet.http.HttpSession,
 java.sql.SQLException,
 java.util.logging.Level,
 java.util.logging.Logger"
      
%>
<%  
            HttpSession session1 = request.getSession(false);
            String uid = "";
            if(session1 !=null){
                uid = (String) session1.getAttribute("uid");
            }
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from events where userid="+uid+" ;");
            
            Statement stmt1 = con.createStatement();
            ResultSet data = stmt1.executeQuery("select * from login where uid="+uid+" ;");
            String username = "";
            if(data.next()){
                username = data.getString("username");
            }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="user.css">
    <title>User page</title>
</head>
<body>
    <header>
        <div class="logoDiv">
            <img src="https://nec.edu.in/wp-content/themes/vajra/assets/images/logo_2.svg" alt="nec logo">
        </div>
        <div class="navText">
            <div class="list">
                <div class="navProfile">
                    <div class="profileName">
                        <h2><%= username %></h2>
                        <div>
                            <ul>
                                <li>Setting</li>
                                <li>Profile</li>
                                <li>Logout</li>
                            </ul>
                        </div>
                    </div>
                    <div class="profileImage">
                        <img src="https://cdn-icons-png.flaticon.com/512/3177/3177440.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="eventColor">
        <div class="eventIndex">
            <h2>Club Events</h2>
            <button onclick="toggleAlert()"><img src="https://cdn-icons-png.flaticon.com/512/4315/4315609.png" alt="">Create</button>
        </div>
        <div class="superClubList events">
             <%  
                 Statement stmt2 = con.createStatement();
                 
                while(rs.next()){
                    
                    String path = "static\\";
                    String title = "";
                    String clubName = "";
                    String datetime = "";
                    String id = "";
                    id = rs.getString("eventid") ;
                    title = rs.getString("eventname");
                    clubName = rs.getString("clubname");
                    datetime+= rs.getString("eventdate").replace('-','/') +" - ";
                    datetime+= rs.getString("eventtime");
                    path+= rs.getString("imagepath");
                    ResultSet length = stmt2.executeQuery("select count(*) as len from eventusers where eventid="+id+" ;");
                    length.next();
                    
             %>
                    
                    <div class="superClubDiv enentsDiv">
                        <img src="<%= path %>" alt="">
                        <div class="eventTime"><%= datetime %></div>
                        <div class="superClubText">
                            <h2><%= clubName %></h2>
                            <p><%= title %></p>
                            <div class="eventMeta">
                                <span class="spanCount">Registered : <span><%= length.getString("len") %></span> </span>
                                <span class="viewButn"> <a href="http://localhost:8000/superclub/eventusers.jsp?id=<%= id %>" target="_blank"><button>View</button></a> </span>
                                <span class="spanButn"> <button onclick="trashEvent('<%= id %>')">Trash</button> </span>
                            </div>
                        </div>
                    </div>
                     <% } %>
<!--            <div class="superClubDiv enentsDiv">
            <img src="./images/nature2.jpg" alt="">
            <div class="eventTime">12/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>ECO Club</h2>
                <p>To Create a Human Resource</p>
                <div class="eventMeta">
                    <span class="spanCount">Registered : <span>13</span> </span>
                    <span class="viewButn"> <button>View</button> </span>
                    <span class="spanButn"> <button>Trash</button> </span>
                </div>
            </div>
            
            </div>
        <div class="superClubDiv enentsDiv">
            <img src="./images/nature3.jpg" alt="">
            <div class="eventTime">06/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>NSS Club</h2>
                <p>A military, also known collectively</p>
                <div class="eventMeta">
                    <span >Registered : 5 </span>
                    <span class="viewButn"> <button>View</button> </span>
                    <span class="spanButn"> <button>Trash</button> </span>
                </div>
            </div>
            
        </div>
        <div class="superClubDiv enentsDiv">
            <img src="./images/nature6.jpg" alt="">
            <div class="eventTime">25/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>NCC Club</h2>
                <p>The Army profession is a unique</p>
                <div class="eventMeta">
                    <span >Registered : 24 </span>
                    <span class="viewButn"> <button>View</button> </span>
                    <span class="spanButn"> <button>Trash</button> </span>
                </div>
            </div>
            
        </div>-->
        </div>

<div class="alertMaster" style="display: none;" >
    <form action="http://localhost:8000/superclub/newevent" method="POST" enctype="multipart/form-data">
    <div class="master" >
        <h2 class="title"> Event Registration form</h2>
            <div class="studentForm">
                <div class="dataInput">
                    <label for="eventname">Event name</label>
                    <input type="text" name="eventname" id="eventname" required>
                </div>
                <div class="dataInput">
                    <label for="clubname">club name</label>
                    <select name="clubname" id="clubname" required>
                        <option value="null" disabled selected>select club</option>
                        <option value="NSS club">NSS club</option>
                        <option value="CSI club" >CSI club</option>
                        <option value="NCC club">NCC club</option>
                        <option value="ECO club">ECO club</option>
                        <option value="SCIENCE club">SCIENCE club</option>
                    </select>
                </div>
                <div class="dataInput">
                    <label for="clubname">Date time</label>
                    <input type="datetime-local" name="datetime" id="datetime">
                </div>
                <div class="dataInput">
                    <label for="eventimage">event image</label>
                    <input type="file" name="file" id="eventimage">
                </div>
                <div class="butnDiv">
                    <input id="doneButn" onclick="toggleAlert()" type="submit" value="Submit" >
                </div>
            </div>
    </div>
    </form>
</div>



<!-- <div class="eventData">
    <h2>NCC Club</h2>
    <p>The Army profession is a unique vocation</p>
    <div class="eventContent">
    </div>
</div> -->
<script src="app.js"></script>
</body>
</html>