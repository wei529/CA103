<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.mem.model.*"%> 
<%@ page import="com.coach.model.*"%>
<%
  CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO");//錯誤處理
//   CoachVO coachVO = (CoachVO) request.getAttribute("coachtVO");
//   MemVO memVO = new MemService().getOneMem("M000001");
  MemVO memVO=(MemVO)session.getAttribute("memVO");
  CoachService coachSvc=new CoachService();
  CoachVO coachVO= coachSvc.getOneCoachByMemId(memVO.getMem_id());
%>

    
<!DOCTYPE html>
<html>
<head>
<title>addCourlist</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
<!--   <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico"> -->
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/Course.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/font.css">
  
	
  
  <!-- summernote-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
 
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/course/courlist/js/jquery.events.touch.js"></script> 
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/editpostform.css">

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
         
          <jsp:useBean id="coachSvc1" scope="page" class="com.coach.model.CoachService" /><jsp >
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
	               
	               <c:if test="${coachSvc1.getOneCoachByMemId(memVO.mem_id)!=null}">
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
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/024.jpg);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:13rem;"> </div>
      </div>
    </div>
  </div>

  <!-- Sponsors -->
  <div class="py-5 text-white opaque-overlay">
    <div class="container">
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
          <h2 class="text-gray-dark text-md-left text-primary">
          <i class="fa fa-book text-md-left"></i> &nbsp; 新增課程 &nbsp; <br>
          </h2>
          
          
		<%-- 錯誤表列 --%>
		<div class="text-md-left">
			<c:if test="${not empty errorMsgs}">
				<font style="color:#f70655">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color:#f70655">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
          
          <p class="text-md-left">" * " 為必填項目</p>
          
          <form METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do" name="form1" enctype="multipart/form-data">
            
            <div class="form-group">
				<h4 class="text-md-left">課程名稱*</h4>
				<input type="TEXT" name="cname" size="45" class="form-control" id="cname"
				value="<%= (courlistVO==null)? "請輸入課程名稱" : courlistVO.getCname()%>" />
			</div>
			<br>
            
            <div class="form-group">
              <h4 class="text-md-left">運動種類*</h4>
              <jsp:useBean id="sportSvc" scope="page" class="com.sptype.model.SptypeService" />
			  <select size="1" name="sptype_id" class="form-control">
				<c:forEach var="sptypeVO" items="${sportSvc.all}">
				 <option value="${sptypeVO.sptype_id}" ${(courlistVO.sptype_id==sptypeVO.sptype_id)? 'selected':'' } >${sptypeVO.sport}
				</c:forEach>
			  </select>			
            </div>
            <br>
            
<!--             <div class="form-group"> -->
<!--               <h4 class="text-md-left">教練編號*</h4> -->
<%-- 				<jsp:useBean id="coa_idSvc" scope="page" class="com.coach.model.CoachService" /> --%>
<!-- 				<select size="1" name="coa_id"  class="form-control"> -->
<%-- 					<c:forEach var="coachVO" items="${coa_idSvc.all}"> --%>
<%-- 						<option value="${coachVO.coa_id}" ${(courlistVO.coa_id==coachVO.coa_id)?'selected':'' } >${coachVO.coa_id} --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 			<br> -->
			
<!-- 			<div class="form-group"> -->
<!--               <h4 class="text-md-left">教練名稱*</h4> -->
<%-- 				<jsp:useBean id="mem_nameSvc" scope="page" class="com.mem.model.MemService" /> --%>
<!-- 				<select size="1" name="coa_id"  class="form-control"> -->
<%-- 					<c:forEach var="memVO" items="${mem_nameSvc.all}"> --%>
<%-- 						<option value="${courlistVO.coa_id}" ${(coachVO.coa_id==courlistVO.coa_id && coachVO.mem_id==memVO.mem_id)?'selected':'' } >${memVO.mem_name} --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 			<br> -->
			
			<!-- 			教練編號  -->
            <div class="form-group">
				<input type="hidden" name="coa_id" value="<%=coachVO.getCoa_id()%>" />
			</div>
			<br>
<%System.out.println("XXXXXXXXXXXXX"+coachVO.getCoa_id());%>			
						
			<div class="form-group">
              <h4 class="text-md-left">課程介紹*</h4>
				<textarea id="cour_text_summernote"></textarea>
				<input type="hidden" name="cour_text"  id="cour_text">
						
				<script>
		    	//初始化summernote
				$(document).ready(function () {	
		    		$('#cour_text_summernote').summernote({
						height: 200,                 
			            minHeight: null,             
			            maxHeight: 400,             
			            focus: true ,
					});
			
			    //summernote賦值(將文字顯示在summernote上)    
			   		$("#cour_text_summernote").summernote("code", '<%= (courlistVO==null)? "" : courlistVO.getCour_text()%>');
			   
				//summernote取值
				   $("#addBtnSubmit").click(function(){
			          var markupStr = $('.note-editable').html();
			          $("#cour_text").val(markupStr);
			        });				

				});
				</script>	
		
			</div>
			<br> 
			
			<div class="form-group">
              <h4 class="text-md-left">課程費用*</h4>
				<input type="text" name="cour_cost" id="cour_cost" size="45" class="form-control"
				value="<%= (courlistVO==null)? "1000" : courlistVO.getCour_cost()%>" />
			</div>
			<br>
			
			<div class="form-group text-md-left">
              <h4 class="text-md-left">課程主頁圖*</h4>
				<input type="file" name="cour_pho" size="45" 
				value="<%= (courlistVO==null)? "" : courlistVO.getCour_pho()%>" />
			</div>
			<br>
			
			<div class="form-group text-md-left">
              <h4 class="text-md-left">課程狀態*</h4>
				<input type="radio" name="cour_lau" value="CL01">下架 &nbsp;
				<input type="radio" name="cour_lau" value="CL02" checked>上架 &nbsp;
				<input type="radio" name="cour_lau" value="CL03">停權 
			</div>
			<br>
			
			<div class="form-group text-md-left">
              <h4 class="text-md-left">課程公告</h4>
<!-- 				<input type="TEXT" name="cour_ann" size="45" class="form-control" -->
<%-- 				value="<%= (courlistVO==null)? "請輸入課程公告" : courlistVO.getCour_ann()%>" /></td> --%>
				<textarea class="form-control text-light" name="cour_ann" id="cour_ann" style="background-color:#1f1f1f; border-color:#505050;" rows="5">
				<%= (courlistVO==null)? "請輸入課程公告" : courlistVO.getCour_ann()%>
				</textarea>
			</div>
			<br>

            
              				
			<!-- 送出  -->
			<input type="hidden" name="action" value="insert">
			<div class="text-md-right">
				<button id="magicBtn" type="button" class="btn btn-outline-primary btn-sm m-1">Magic</button>
				<button id="addBtnSubmit" type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
			</div>
            
            
          </form>
        </div>
      </div>
    </div>
  </div>

  <script>
	$("#magicBtn").click(function(){
		$("#cname").val("誰說工程師不能當猛男？！");
		$("#cour_text_summernote").summernote("code",'猛男教練David，在籃球領域上有深厚的經驗，並且持續提升台灣基層工程師的專業知識和技能，特辦「誰說工程師不能當猛男？！」特訓班。<br>由猛男教練David主講，搭配 TibaMe 引爆運動訓練教練團隊與選手示範，共同傳遞「Seafood的力量」給台灣工程師幼苗們。<br>課程內容包括撐不起來的伏地挺身、JAVA、Android以及幹話特訓。<br>......啊說好的籃球勒？！<br>');
		$("#cour_cost").val("8787");
		$("#cour_ann").val("請同學們牢記大衛seafood猛男秀開播時間，準時收看！！");
	});  
  </script>

					
  
  
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12"></div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/gymback.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3"></h1>
          <p></p>
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
<!--   <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 
<!--summernote-->
  <script src="js/summernotecutom.js"></script>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
  

  
</body>
</html>