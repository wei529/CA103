<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>

<%
   
  MemVO memVO= new MemService().getOneMem("M000004");
  session.setAttribute("memVO", memVO);
  
  String perpageloc=request.getParameter("perpageloc");
//  設在URL參數裡 ?perpageloc=course#personalnav
//  #personalnav讓頁面停留在personal nav bar位置
//  然後getParameter("perpageloc") 作為personal NavBar focus之判斷
	//id="event"
	//id="post"
	//id="mycalender"
	//id="friend"
	//id="workoutplan"
	//id="mypage"
  
  session.setAttribute("perpageloc", perpageloc);
  String sessionPerpageloc=(String)session.getAttribute("perpageloc");
 
  


%>



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>Jennifer Lawernce</title>

<!-- CSS dependencies -->
 <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
	
<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
	
<style>
 

/*頁面設定*/
body {
	overflow-x: hidden;
}
</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>


</head>

<body class="text-center">
  <!-- Navbar --> 
 <nav   class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="<%=request.getContextPath()%>/index.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp">Course</a>
          </li>
         
          <jsp:useBean id="coachSvc" scope="page" class="com.coach.model.CoachService" /><jsp >
          <c:if test="${memVO!=null}">
	          <li class="nav-item mx-2 btn-lg dropdown" >
	            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name}
	              <i class="fa fa-caret-down dropbtn"></i>
	            </a>
	            <div class="dropdown-content" id="myDropdown">
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file "><font class="fontstyle">&nbsp&nbsp個人頁面</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp"><i class="fa fa-calculator"><font class="fontstyle">&nbsp&nbsp計畫</font></i></a>
	              <a href="#"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/course/purchcour/page/purchcour.jsp"><i class="fa fa-film" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp課程</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp"> <i class="fa fa-hand-spock-o" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp活動</font></i></a>
	<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp貼文</i></a> -->
	              <a href="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp"><i class="fa fa-check" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp行事曆</font></i></a>
	               
	               <c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id)!=null}">
	               	<a href="<%=request.getContextPath() %>/front_end/course/coach/page/coach.jsp"><i class="fa fa-sticky-note"><font class="fontstyle">&nbsp&nbsp教練管理</font></i></a>
	               </c:if>
	              <a href="<%=request.getContextPath() %>/front_end/mem/updateMember/updateMember.jsp"><i class="fa fa-address-card" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp會員資料</font></i></a>
	              <a href="<%=request.getContextPath() %>/mem/mem.do?action=loggedout"><font class="fontstyle">登出</font></a>
	            </div>
	          </li>
          </c:if>
        </ul>
        
         <c:if test="${memVO==null}">
        	<a class="btn btn-lg btn-primary" href="<%=request.getContextPath() %>/Mem_Login_Signup.jsp" id="registerBtn">Register now</a>
		 </c:if>      	
      </div>
    </div>	
  </nav>
	<!-- Cover -->
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/jogback.jpg&quot;);">
	</div>
	<!-- Personal Pic -->
	<div class="row mb-5 personalarea" id="personalnav">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${memVO.mem_id}">
			</div>
		</div>
		<div class="col-md-4 align-self-end ml-1">
			<h1 class="text-left text-primary">Jennifer Lawrence</h1>
			<p class="text-left">Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.</p>
		</div>
		<!-- Personal Pic -->
	
	</div>
		<!-- NavBar Personal focus 判斷式-->
	
	<%
	if(sessionPerpageloc!=null){
	String sessionPerpagelocClass="#"+sessionPerpageloc;
	
	%>
	 
	<script>
	 $(document).ready(function() {
      
        $("<%=sessionPerpagelocClass%>").css({"color": "#12bbad", "border-bottom": " 0.8px solid #12bbad"});
    
	 });
    </script>
    <% }%>
    
    <script>
    $(document).ready(function() {
        
        $(".personalnavlink").click(function() {
        	var href= this.rel;
        	location.href= href;
        });
    
	 });
    
    
    
    </script>
	
	<!-- NavBar Personal focus 判斷式-->
	
	
	<!-- NavBar Personal-->
	<div class="container containerHrT " >
		<hr>
	</div>
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0"
		id="profile-navbar">
		<div class="container">
			<div
				class="collapse navbar-collapse text-right justify-content-center marignBun"
				id="navbar3SupportedContent">
				<ul class="navbar-nav">
				<!-- mypage-->
					<li class="nav-item"><a class="nav-link personalnavlink" rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=mypage#personalnav" id="mypage"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
				<!-- Workoutplan-->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=workoutplan#personalnav"
						id="workoutplan"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light dropdown-item-custom"
								href="#">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Plan</a>
						</div></li>
					<!-- Friend-->
					<li class="nav-item"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=friend#personalnav" id="friend"> <i
							class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=course#personalnav" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="course"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#" >MyCourse</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Course</a>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=event#personalnav" id="event">
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link personalnavlink" id="post"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=post#personalnav"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>&nbsp;&nbsp;Post&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link personalnavlink "  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=mycalender#personalnav" id="mycalender"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>
							&nbsp;MyCalender&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container containerHrB  ">
		<hr>
	</div>
	
	<!--header  -->
	
	<div class="py-4" id="jys">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-left">Course Board</h2>
					<hr>
				</div>
			</div>
		</div>
	</div>
	<!--fixbutton-->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>
	<!--fixbutton-->
	

	

	<!--courboar-->
		<!-- Sponsor logos -->
		<div class="py-5 section" >
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1 class="mb-4">Sponsors</h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2 col-6"></div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/logo_1.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/logo_4.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/logo_3.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/logo_2.png">
					</div>
				</div>
			</div>
		</div>
		
	
		<!-- Call to action -->
		<div class="py-5 section section-fade-in-out" id="register"
			style="background-image: url('<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/cover_2.jpg');">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-left">
						<h1 class="mb-3">Set and Achieve Goals</h1>
						<p>
							By discovering the power of goal setting by committing to reaching an exercise milestone and then working out just how you’ll achieve it, you can enjoy the 
							benefits of exercise and the confidence that comes along with it.
						</p>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Footer -->
		<footer class="text-md-left text-center p-4">
			<div class="container">
				<div class="row">
					<div class="col-lg-12"></div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<p class="text-muted">
							<br> <br> <br>
						</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- JavaScript dependencies -->
		
		<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
			integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
			crossorigin="anonymous"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
			crossorigin="anonymous"
			integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"></script>
		<!-- Script: Smooth scrolling between anchors in a same page -->
		<script
			src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script>


  
</body>

</html>




