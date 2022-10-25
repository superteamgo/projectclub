<%-- 
    Document   : events
    Created on : 19 Oct 2022, 19:53:04
    Author     : superadmin
--%>

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
 java.sql.SQLException,
 java.util.logging.Level,
 java.util.logging.Logger"
      
%>
<%
            String eventName = request.getParameter("event");
            int eventID = Integer.parseInt(request.getParameter("id"));
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from events where eventid="+ eventID+" ;");
            String path = "static\\";
            String clubName = "";
            while(rs.next()){
                path+= rs.getString("imagepath");
                clubName =  rs.getString("clubname");
            }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="eventRegister.css">
    <title><%= eventName %></title>
</head>
<body>
    <div class="clubTitle">
        <h2><%= clubName %></h2>
        <h3><%= eventName %></h3>
    </div>
    <main>
        <div class="eventImage">
            <img src="<%= path %>" alt="eventImage">
        </div>
        <div class="eventFormMain">
            <h2 class="formTitle">Event Registerion Form</h2>
            <form action="http://localhost:8000/superclub/eventregistration" method="post">
            <div class="eventForm">
                <div class="eventFormData">
                    <!-- <label for="eventname">Event name</label> -->
                    <input type="text" name="name" placeholder="Name" required>
                </div>
                <div class="eventFormData">
                    <!-- <label for="eventname">Event name</label> -->
                    <input type="number" name="regno" placeholder="register no" required>
                </div>
                <div class="eventFormData">
                    <!-- <label for="department">department</label> -->
                    <select name="gender" required>
                        <option value="null" disabled selected>select gender</option>
                        <option value="M">Male</option>
                        <option value="F" >Female</option>
                    </select>
                </div>
                <div class="eventFormData">
                    <!-- <label for="eventname">Event name</label> -->
                    <input type="number" name="phone" placeholder="phone no" required>
                </div>
                <div class="eventFormData">
                    <!-- <label for="department">department</label> -->
                    <select name="department" required>
                        <option value="null" disabled selected>select department</option>
                        <option value="CSE">CSE</option>
                        <option value="IT" >IT</option>
                        <option value="ECE">ECE</option>
                        <option value="EEE">EEE</option>
                        <option value="MECH">MECH</option>
                    </select>
                </div>
                <div class="eventFormData">
                    <!-- <label for="department">year</label> -->
                    <select name="year" id="year" required>
                        <option value="null" disabled selected>select year</option>
                        <option value="1">I</option>
                        <option value="2" >II</option>
                        <option value="3">III</option>
                        <option value="4">IV</option>
                    </select>
                </div>
                <input type="hidden" name="id" value="<%= eventID  %>" />
                <div class="butnDiv">
                    <input id="doneButn" onclick="toggleAlert()" type="submit" value="Submit" >
                </div>
            </div>
        </form>
        </div>
    </main>
</body>
</html>
