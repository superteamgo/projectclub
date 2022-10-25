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
            int eventID = Integer.parseInt(request.getParameter("id"));
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            Statement stmt1 = con.createStatement();
            Statement stmt2 = con.createStatement();
            Statement stmt3 = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from events where eventid="+ eventID+" ;");
            ResultSet users = stmt1.executeQuery("select * from eventusers where eventid="+ eventID+" ;");
            String title = "";
            while(rs.next()){
                title =  rs.getString("eventname");
            }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="eventusers.css">
    <title><%= title %></title>
</head>
<body>
    
    <header>
        <h2 class="userTitle"><%= title %> </h2>
    </header>
    <table>
        <tr>
          <th>Index</th>
          <th>name</th>
          <th>registerno</th>
          <th>gender</th>
          <th>phoneno</th>
          <th>department</th>
          <th>year</th>
          <th>Member</th>
        </tr>
         <%   
                int i = 0;
                String name = "";
                String regno = "";
                String gender= "";
                String phoneno = "";
                String department = "";
                String year = "";
                while(users.next()){
                     String isMember = "no";
                     name = users.getString("name");
                     regno =  users.getString("registerno");
                     gender =  users.getString("gender");
                     gender = gender.equals("M")?"Male":"Female";
                     phoneno =  users.getString("phoneno");
                     department =  users.getString("department");
                     year =  users.getString("year");
                     switch(year){
                        case "1": year = "First";break;
                        case "2": year = "Second";break;
                        case "3": year = "Third";break;
                        case "4": year = "Fourth";break;
                     }
                     ResultSet member  = stmt2.executeQuery("select * from studentinfo where regno="+ regno +" and clubname= (select clubname from events where eventid="+ eventID  +" limit 1 ) ;");
//                     ResultSet clubName  = stmt2.executeQuery("select clubname from events where eventid="+ regno +" ;");
                     if(member.next()) isMember = "yes";
                    i++;
         %>
                    
        <tr>
          <td><%= i %></td>
          <td><%= name %></td>
          <td><%= regno %></td>
          <td><%= gender %></td>
          <td><%= phoneno %></td>
          <td><%= department %></td>
          <td><%= year %></td>
          <td><%= isMember %></td>
        </tr>
                    
               <% } %>
        <tr>
          <td>1</td>
          <td>peter parker</td>
          <td>2015003</td>
          <td>Male</td>
          <td>123457890</td>
          <td>IT</td>
          <td>Third</td>
          <td>Yes</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Emma Watson</td>
            <td>2015003</td>
            <td>Female</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Tom Cruise </td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Tony Stark</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Christopher Nolan</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Maria Anders</td>
            <td>2015003</td>
            <td>Female</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Sundar Pichai</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>8</td>
            <td>jeff bezos</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>9</td>
            <td>arun vijay</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>10</td>
            <td>Justin Trudeau</td>
            <td>2015003</td>
            <td>Male</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
          </tr>
          <tr>
           <td>11</td>
            <td>Sanna Marin</td>
            <td>2015003</td>
            <td>Female</td>
            <td>123457890</td>
            <td>IT</td>
            <td>Third</td>
            <td>Yes</td>
          </tr>
      </table>

</body>
</html>