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

            Class.forName("com.mysql.jdbc.Driver");
            Connection con =  DriverManager.getConnection ("jdbc:mysql://127.0.0.1:3306/superdatabase?useSSL=false","root","root");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from events order by eventid desc;");
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>new website</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <div class="logoDiv">
            <a href="/superclub" style="text-decoration: none;color: white;">
            <img src="https://nec.edu.in/wp-content/themes/vajra/assets/images/logo_2.svg" alt="nec logo">
            </a>
            <h2 class="webTitle"></h2>
        </div>
        <ul>
            <li> home<hr></li>
            <li> events<hr></li>
            <li class="list"> 
                clubs<hr>
            <ul class="sublist">
                <li><a href="#1">ECO club</a></li>
                <li><a href="#2">CSI club</a></li>
                <li><a href="#3">NCC club</a></li>
                <li><a href="#4">SCIENCE club</a></li>
                <li><a href="#5">NSS club</a></li>
            </ul>
            </li>
            <li>
                <span class="joinButn"><a href="./memberShip.html">Register</a></span>
                <span><a href="./loginPage.html" style="text-decoration: none;color: white;">Login</a></span>
            </li>
        </ul>
    </header>
    
    <div class="container">
        <!-- <img src="./images/Auditorium.jpg" alt="sample image"> -->
        <div class="imageText">
            <h2>Nec Clubs</h2>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. A, asperiores, dicta magnam ut nesciunt optio quo porro laudantium maxime alias inventore est rerum ipsam velit, fugiat consectetur autem officia sed</p>
        </div>
        <!-- <div class="newsDiv">
            <h4>
                National Engineering College, Kovilpatti, Tamil Nadu offers a wide 
                variety of high-quality education and training opportunities for 
                every student, awarding qualifications through the highly reputed 
                Anna University
            </h4>
        </div> -->
    </div>
    <div class="homeEvents">
        
    <div class="eventColor">
        <h2>
            Upcomming Events
        </h2>
        <div class="superClubList events">
            <%   
                while(rs.next()){
                    String path = "static\\";
                    String title = "";
                    String clubName = "";
                    String datetime = "";
                    String id = "";
                    id = rs.getString("eventid") ;
                    title = rs.getString("eventname");
                    clubName = rs.getString("clubname");
                    String dateList[] =  rs.getString("eventdate").split("-");
                    datetime+= dateList[2]+"/"+dateList[1]+"/"+dateList[0]+" - ";
                    datetime+= rs.getString("eventtime");
                    path+= rs.getString("imagepath"); %>
                    
                        <div class="superClubDiv enentsDiv">
                            <img src="<%= path  %>" alt="">
                            <div class="eventTime"><%= datetime %></div>
                            <div class="superClubText">
                                <h2>
                                   <%= clubName %>
                                </h2>
                                <p>
                                   <%= title %>
                                </p>
                                <a href="<%= "http://localhost:8000/superclub/events.jsp?event="+title+"&id="+id %>" class="eventLink">Register</a>
                            </div>

                        </div>
                    
               <% } %>
        <div class="superClubDiv enentsDiv">
            <img src="./images/nature2.jpg" alt="">
            <div class="eventTime">12/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>
                    ECO Club
                </h2>
                <p>
                    To Create a Human Resource of Organized
                </p>
                <a href="#" class="eventLink">Register</a>
            </div>
            
        </div>
        <div class="superClubDiv enentsDiv">
            <img src="./images/nature3.jpg" alt="">
            <div class="eventTime">06/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>
                   NSS Club
                </h2>
                <p>
                    A military, also known collectively
                </p>
                <a href="#" class="eventLink">Register</a>
            </div>
            
        </div>
        <div class="superClubDiv enentsDiv">
            <img src="./images/nature6.jpg" alt="">
            <div class="eventTime">25/05/2022 - 10.30 AM</div>
            <div class="superClubText">
                <h2>
                    NCC Club
                </h2>
                <p>
                    The Army profession is a unique vocation
                </p>
                <a href="#" class="eventLink">Register</a>
            </div>
            
        </div>
        </div>
    </div> 
    </div> 
        <h2 class="clubMainTitle">NEC Club</h2>
        <div class="listClubs">
        <div class="clubDiv" onclick="toggle(1)">
            <img src="./images/nature4.jpg" alt="">
            <div class="clubText">
                ECO club
            </div>
        </div>
        <div class="clubDiv" onclick="toggle(2)">
            <img src="./images/nature2.jpg" alt="">
            <div class="clubText">
                CSI club
            </div>
        </div>
        <div class="clubDiv" onclick="toggle(3)">
            <img src="./images/nature3.jpg" alt="">
            <div class="clubText">
                NCC club
            </div>
        </div>
        <div class="clubDiv" onclick="toggle(4)">
            <img src="./images/nature5.jpg" alt="">
            <div class="clubText">
                SCIENCE club
            </div>
        </div>
        <div class="clubDiv" onclick="toggle(5)">
                <img src="./images/nature1.jpg" alt="">
                <div class="clubText">
                    NSS club
                </div>
        </div>
       
        
        
        <div class="clubDiv" onclick="toggle(6)">
                <img src="./images/nature6.jpg" alt="">
                <div class="clubText">
                    FINE ARTS club
                </div>
        </div>
    </div>
    <div class="styleDiv">
        <h2>
            National Engineering College
        </h2>
    </div>
    <div class="contentMain" id="1">
        <div class="content">
        <div class="contentImage">
            <img src="./images/treesmall.jpg" alt="plant tree">
        </div>
        <div class="contenText">
            <h2>
                <!-- <hr> -->
                Eco Club
            </h2>
            Eco club offer programs and activities to encourage others to reduce pollution, plant trees, save water, 
            clean surroundings and more. Eco club in our college is a voluntary group 
            which promotes the participation of student teachers in learning and improving their environment.
            Eco club offer programs and activities to encourage others to reduce pollution, plant trees, save water, 
            clean surroundings and more. Eco club in our college is a voluntary group 
            which promotes the participation of student teachers in learning and improving their environment.
            Eco club offer programs and activities to encourage others to reduce pollution, plant trees, save water, 
        </div>
    </div>
    </div>
    <div class="clubActive">
        <h2>Club Activities</h2>
        <div class="ActiveDiv">
            <div class="activeContent">
                <div class="fluid">
                    <img src="https://www.neallandscapes.co.uk/wp-content/uploads/2022/09/kids-planting-and-caring-for-different-plants-at-school-1.jpg" alt="club activities images">
                </div>
                <div class="activeText">
                    <h2>Nature Go Green</h2>
                    <p>Nature, in the broadest sense, is the physical world or universe. 
                        "Nature" can refer to the phenomena of the physical world, 
                        and also to life in general</p>
                </div>
            </div>
            <div class="activeContent">
                <div class="fluid">
                    <img src="./images/eco1.jpg" alt="club activities images">
                </div>
                <div class="activeText">
                    <h2>Preserve your nature.</h2>
                    <p>Unsurpassed opportunities to participate in the 
                    advancement of entire fields of knowledge</p>
                </div>
            </div>
            <div class="activeContent">
                <div class="fluid">
                    <img src="./images/nature8.jpg" alt="club activities images">
                </div>
                <div class="activeText">
                    <h2>Graduate Education</h2>
                    <p>
                       As far as we know, our world is unique in the universe, 
                       defined by three elements, Air, Land and Water</p>
                </div>
            </div>
        </div>
    </div>
    <div class="csiClub" id="2">
            <div class="topContent">
                <img src="./images/nature4orignal.jpg" alt="">
                <div class="topContentText">
                    <h2>
                        Computer Society of India
                    </h2>
                    <p>
                        Computer Society of India is a body of computer professionals in India. 
                        It was started on 6 March 1965 by a few computer professionals and 
                        has now grown to be the national body representing computer professionals. 
                        It has 72 chapters across India, 511 student branches, and 100,000 members
                    </p>
                </div>
            </div>
            <div class="csiClubActive">
                <div class="csiClubList">
                    <h2> What we do</h2>
                    <p>
                        Having 488 student branches and rooted firmly at 73 different locations, 
                        CSI has plans of opening more chapters & activity centers in smaller towns of the country. 
                        The idea is to spread the knowledge, and provide opportunities to as many interested as possible
                    </p>
                </div>
                <div class="csiClubList">
                    <h2> About CSI</h2>
                    <p>
                        The seed for the Computer Society of India (CSI) was first shown in the year 1965 
                        with a handful of IT enthusiasts who were a computer user group and 
                        felt the need to organize tteir activities.
                        The Society is targeted at the IT professionals 
                    </p>
                </div>
                <div class="csiClubList">
                    <h2> CSI Awards</h2>
                    <p>
                        We Recognize Innovations And Indigenous Developments In The Field Of Information Technology In India. 
                        CSI Awards Are Instituted To Acknowledge And 
                        Motivate Individuals And Organizations Working In The ICT Field. 
                    </p>
                </div>
            </div>
    </div>
    <div class="superClub" id="3">
            <div class="superHeader">
                <div>
                    <img src="https://www.telegraph.co.uk/content/dam/news/2022/05/11/TELEMMGLPICT000153454699_trans_NvBQzQNjv4Bq5oI2RUtWbBHSsDfhI3EIqTsoP6K2mMXO8tELEPpzIJQ.jpeg" alt="">
                </div>
                <div>
                    <h2>National Cadet Corps</h2>
                    <p>
                        The National Cadet Corps (NCC) is the youth wing of the Indian Armed Forces with its headquarters in New Delhi, India. 
                        It is open to school and college students on voluntary basis as a Tri-Services Organisation, comprising the Army, 
                        the Navy and the Air Force, engaged in developing the youth of the country into disciplined and patriotic citizens. 
                        The soldier youth foundation in India is a voluntary organization which recruits cadets from high schools, higher secondary, colleges and 
                        universities all over India. 
                    </p>
                </div>
            </div>
        <h2 class="clubListTitle">Club Achievements</h2>
        <div class="superClubList">
            <div class="superClubDiv">
                <img src="./images/ncca5.jpg" class="imageCover" alt="">
                <div class="superClubText">
                    <h2>
                        AIM OF NCC
                    </h2>
                    <p>
                        To Create a Human Resource of Organized, Trained and Motivated Youth,
                         To Provide Leadership in all Walks of life and be Always Available for the Service of the Nation.
                    </p>
                </div>
                
            </div>
            <div class="superClubDiv">
                <img src="./images/ncca4.jpg" class="imageCover" alt="">
                <div class="superClubText">
                    <h2>
                        Armed Force
                    </h2>   
                    <p>
                        A military, also known collectively as armed forces, is a heavily armed, 
                        highly organized force primarily intended for warfare. 
                        It is typically authorized and maintained by a sovereign state, 
                        with its members identifiable by their distinct military uniform
                    </p>
                </div>
                
            </div>
            <div class="superClubDiv">
                <img src="./images/ncca3.jpg" class="imageCover" alt="">
                <div class="superClubText">
                    <h2>
                        Indian Military
                    </h2>
                    <p>
                        The Army profession is a unique vocation of experts who are entrusted to defend the Constitution and 
                        the rights and interests of the American people
                    </p>
                </div>
                
            </div>
        </div>
    </div>
    <div class="newClub" id="4">
        <div class="newClubHeader">
            <img src="./images/nature7.jpg" alt="">
            <div class="newHeaderDiv">
                <h2> Science Club </h2>
            </div>
        </div>
        <div class="newClubContent">
            <h2>What Is Science</h2>
            <p>
            Science is a systematic enterprise that builds and organizes 
            knowledge in the form of testable explanations and 
            predictions about the universe
            </p>
        </div>
        <h2 class="newTitle">Club Winners</h2>
        <div class="newClubActive">
            <div class="newClubDiv">
                <div class="newClubDiv1">
                    <img src="./images/nature3.jpg" alt="">
                </div>
                <div class="newClubDiv2">
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                        
                    </p>
                    <button>Read More</button>
                </div>
            </div>
            <div class="newClubDiv">
                <div class="newClubDiv1">
                    <img src="./images/nature7.jpg" alt="">
                </div>
                <div class="newClubDiv2">
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                        
                    </p>
                    <button>Read More</button>
                </div>
            </div>
            <div class="newClubDiv">
                <div class="newClubDiv1">
                    <img src="./images/nature2.jpg" alt="">
                </div>
                <div class="newClubDiv2">
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                        Molestiae dolor eaque, ullam commodi nostrum voluptatem aut 
                        eos id veniam sunt, reiciendis, ipsa necessitatibus asperiores 
                        optio esse soluta consequatur dolore! Laborum
                    </p>
                    <button>Read More</button>
                </div>
            </div>
        </div>  
    </div>
    <div class="nssClub" id="5">
        <div class="nssHome">
            <img src="./images/nature3.jpg" alt="">
            <h2 class="nssTitle">
                National Service Scheme
            </h2>
            <div class="nssWapper">
            <div class="nssImageText">
                <h2>About NSS</h2>
                <p>
                    Lorem ipsum dolor, sit amet consectetur adipisicing elit. 
                    Ipsa dicta, laborum sit, ea qui quo corrupti eaque, 
                    incidunt repudiandae 
                </p>
            </div>
            <div class="nssImageText">
                <h2>Major Activities</h2>
                <p>
                    In India, the idea of involving students in the task of national service 
                    dates back to the times of Mahatma Gandhi, 
                    the father of the nation
                </p>
            </div>
            <div class="nssImageText">
                <h2>National Youth Festivals</h2>
                <p>
                    A NSS volunteer who takes part in the community service 
                    programme would either be a college level 
                    or a senior secondary level student
                </p>
            </div>
        </div>
        </div>
        <div class="superClubList">
            <div class="superClubDiv">
                <img src="./images/nss1.jpg" alt="">
                <div class="superClubText">
                    <h2>
                        AIM OF NCC
                    </h2>
                    <p>
                        To Create a Human Resource of Organized, Trained and Motivated Youth,
                         To Provide Leadership in all Walks of life and be Always Available for the Service of the Nation.
                    </p>
                </div>
                
            </div>
            <div class="superClubDiv">
                <img src="./images/nss2.jpg" alt="">
                <div class="superClubText">
                    <h2>
                       NSS Armed Force
                    </h2>
                    <p>
                        A military, also known collectively as armed forces, is a heavily armed, 
                        highly organized force primarily intended for warfare. 
                        It is typically authorized and maintained by a sovereign state, 
                        with its members identifiable by their distinct military uniform
                    </p>
                </div>
                
            </div>
            <div class="superClubDiv">
                <img src="./images/generic.jpg" alt="">
                <div class="superClubText">
                    <h2>
                        NSS Force
                    </h2>
                    <p>
                        The Army profession is a unique vocation of experts who are entrusted to defend the Constitution and 
                        the rights and interests of the American people
                    </p>
                </div>
                
            </div>
        </div>  
    </div>
<script>
    const toggle = (id)=> window.location.href = `#${id}`
</script>
</body>
</html>