<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.Post.model.*"%>
 <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	PostService postSvc = new PostService();
	List<PostVO> list = postSvc.getByMemIDToDisplay("M000001");
	pageContext.setAttribute("list",list);
%>



<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <title>Jennifer Lawernce</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/post/css/PersonalPage_list.css">
<!--   <link rel="stylesheet" href="calender.css"> -->
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- lightcase settings -->
  
  
 
  <script src="<%=request.getContextPath() %>/front_end/post/js/jquery.events.touch.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/course/courboar/js/autotyping.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/course/js/truncateoverride.js"></script>

  
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/purchcour/css/buttonfix.css">
  <!-- fafaicon -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
  <style> /*頁面設定*/

    body {
      overflow-x: hidden;
    }
    
  </style>
</head>


<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->


  <!-- Plan List-->
  <div class=" m-4">
    <div class="row">
      <div class="container">
        <div class="row">
          <div class="col-md-6 my-3">
            <div class="card col-12 card-custom">
            <%
            Date date=new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("EEE, d MMM yyyy", Locale.US);
            %>
              <div class="card-header card-header-custom text-left text-light"><%=formatter.format(date) %></div>
              <div class="card-body card-body-custom">
                <h4 class="text-primary text-left">Plan Today</h4>
                <h6 class="text-muted  text-left">Subtitle</h6>
                <p class="text-left text-white">Some quick example text to build on the card title.</p>
              </div>
            </div>
          </div>
          <div class=" col-md-6 p-3">
            <div class="row justify-content-end">
              <div class="col-sm-12 my-3">
                <div class="card workoutnotecard">
                  <div class="card-body workoutnotecardbody ">
                    <div class="my-2 ">
                      <h4 class="text-left">Hi,&nbsp;${memSvc.getOneMem("M000001").mem_name}</h4>
                      <h4> Do You <span class="txt-rotate" data-period="1800" data-rotate="[ &quot;Work Out Today ?&quot; ]"></span>
                      </h4>
                    </div>
                    <div class="mt-3 text-right">
                      <a href="<%=request.getContextPath()%>/front_end/post/Create_Post.jsp" class="btn btn-primary btnworkoutnote ">
                        <i class="fa fa-edit"></i>Make Post</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--list-->
  <!--Post title-->
  <div class="py-1">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h2 class="text-left">&nbsp;&nbsp;Posts</h2>
          <hr>
        </div>
      </div>
    </div>
  </div>
  <a class="btn btn-lg btn-primary" id="bli_kontaktad_landing" href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
    <i class="fab fa-rocketchat"></i>
  </a>
  <!--fixbutton-->
  <!--lightbox script-->

  <!--lightbox script-->
  <!--blog1-->
  <c:forEach var="postVO" items="${list}">
  
  <div class="p-2 m-5">
    <div class="container">
      <div class="row">
        <div class="col-md-7 order-2 order-md-1 postsection ">
          <div class="col-12 mb-2 mt-1 postimgframe">
            <img class="img-fluid d-block post-img-custom" src="${postVO.post_img}"> </div>
          <div class="row ">
            <div class="col-5 m-2">
              <h5 class="text-left postdate"><fmt:formatDate value="${postVO.post_time}" pattern="dd"/></h5>
              <fmt:setLocale value="en_US" />
              <h6 class="text-left postmonth"><fmt:formatDate value="${postVO.post_time}" pattern="MMM"/>,&nbsp; &nbsp;<fmt:formatDate value="${postVO.post_time}" pattern="yyyy"/></h6>
            </div>
            <div class="col-6  align-self-end text-right">
              <ul class="list-inline postrectbar">
                <li class="list-inline-item">
                  <p class="h4">
                    <i class="fa fa-eye"></i>&nbsp; &nbsp;</p>
                </li>
<!--                 <li class="list-inline-item"> -->
<!--                   <p class="h4"> -->
<!--                     <i class="far fa-heart"></i>&nbsp; &nbsp; </p> -->
<!--                 </li> -->
                <li class="list-inline-item">
                  <p class="h4">
<!--                     <i class="far fa-trash-alt"></i>&nbsp; &nbsp; </p> -->
                    
                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;">
<!-- 			     <input type="submit" class="far fa-trash-alt" value=null> -->
				<button type="submit" class="btn  py-1 mb-2 mt-1"> 
					<i class="far fa-trash-alt"></i>
				</button>
  				
				</span>
			     <input type="hidden" name="post_id"      value="${postVO.post_id}">			  
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="action"     value="delete_post">
			     
			     </FORM>
                </li>
                <li class="list-inline-item">
                  <p class="h4">
                    <i class="far fa-edit"></i>
                  </p>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-md-5 order-1 order-md-2 text-left postsectiontext">
       
          <div class="col-md-2 mt-2 p-0 text-center text-light postclass" style="background-color:${sportTypeColor.get(postVO.sptype_id)}!important; opacity:0.8">${sportTypeMap.get(postVO.sptype_id)} </div>
          <div class="col-md-12 mt-3 p-0 posttitle ">
            <h2 class="text-left">${postVO.post_title}</h2>
          </div>
          <hr>
          
 
      
          
          <div class=" postbriefcontent ">
      
          
            <p class="postbrieftruncate">${ postVO.getPost_con().replaceAll("</?[^>]+>", "") }&nbsp; &nbsp; </p>
          </div>
          <div class="col-md-12 mt-5 align-self-end text-right p-0">
          <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-outline-primary m-2" value="Read More"> 
			     <input type="hidden" name="post_id"      value="${postVO.post_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			     <input type="hidden" name="action"	    value="find_by_post_id">
			</FORM>
<!--             <a class="btn btn-outline-primary m-2" href="#">Read More</a> -->
          </div>
        </div>
      </div>
    </div>
  </div>
  </c:forEach>
  <!--blog1-->
  <!--blog2-->
 
  <!--blog2-->
  <!--blog3-->
  
  <!--blog3-->
  <!-- Sponsor logos -->

<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	

  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
 
  <!--
 
</body>

</html>-->
 
</body>

</html>