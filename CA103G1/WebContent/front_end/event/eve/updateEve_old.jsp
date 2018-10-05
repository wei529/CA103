<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.eve.model.*"%>
<%@ page import="com.mem.model.*" %>
<%
  MemVO memVO=(MemVO)session.getAttribute("memVO");
  EventVO eveVO = (EventVO) request.getAttribute("eveVO");
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>


<!-- datetimepicker-->	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>	
	
	
	
<!-- summernote-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
  <link href="<%=request.getContextPath() %>/front_end/event/eve/summernote/summernote-bs4.css" rel="stylesheet">
  <script src="<%=request.getContextPath() %>/front_end/event/eve/summernote/summernote-bs4.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">



<title>�קﬡ�� - updateEve.jsp</title>

</head>
<body style="color:black; background-color:#e9ecef !important;"> <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="#">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg dropdown" id="navUserBtn">
            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">User&nbsp;
              <i class="fa fa-caret-down dropbtn"></i>
            </a>
            <div class="dropdown-content" id="myDropdown">
              <a href="#">
                <i class="fa fa-file">&nbsp;&nbsp;�ӤH����</i>
              </a>
              <a href="#">
                <i class="fa fa-calculator">&nbsp;&nbsp;�p�e</i>
              </a>
              <a href="#">
                <i class="fa fa-users" aria-hidden="true">&nbsp;&nbsp;�n��</i>
              </a>
              <a href="#">
                <i class="fa fa-film" aria-hidden="true">&nbsp;&nbsp;�ҵ{</i>
              </a>
              <a href="#">
                <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp;&nbsp;����</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;�K��</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;��ƾ�</i>
              </a>
              <a href="#">�n�X</a>
            </div>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#" id="registerBtn">Register now</a>
      </div>
    </div>
  </nav>

  <div class="align-items-center py-5 section-fade-in-out " id="coverfirstImg" style="background: url(&quot;assets/conference/cover_marathon.png&quot;);">
  </div>
  
  
  
  <table id="table-1">
	<tr><td>
		 <h3>�קﬡ�� - updateEve.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/front_end/event/eve/select_event_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<h3>�קﬡ��:</h3>

<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>



<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1" enctype="multipart/form-data" >
<table>
	<tr>
		<td>���ʹϤ�:</td>
		<td>			
				<div id="updateImgDiv">
				<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=<%=eveVO.getEve_id()%>">
				</div>
				<div class="imgdiv" style="display: none;"><img src="#" id="upload_pic1"  /></div>
				<input type="file" name="eve_photo" id="eve_photo"/>
				<input type="button" id="btn_cancel" value="�����󴫹Ϥ�"><br>
		</td>
	
	</tr>

	
	<tr>
		<td>���ʼ��D:</td>
		<td><input type="TEXT" name="eve_title" size="45" 
			 value="<%=eveVO.getEve_title()%>" /></td>
		<td>${errorMsgs.eve_title}</td>	 
	</tr>
	<tr>
		<td>�D��H�m�W:</td>
		<td><input type="TEXT"  size="45" readonly="readonly"
			 value="<%= (memVO==null)? "" :memVO.getMem_name() %>" /></td>
		<td>${errorMsgs.mem_id}</td>	 
	</tr>	
	<tr>
		<td>���W����:</td>
		<td>
			<input name="ereg_startdate" id="ereg_startdate" type="text" value="${eveVO.ereg_startdate}">~
			<input name="ereg_enddate" id="ereg_enddate" type="text" value="${eveVO.ereg_enddate}">
		</td>
		<td>${errorMsgs.ereg_startdate}</td>
	</tr>
	<tr>
		<td>���ʮɶ�:</td>
		<td>
			<input name="eve_startdate" id="eve_startdate" type="text">~
			<input name="eve_enddate" id="eve_enddate" type="text">
		</td>
		<td>${errorMsgs.eve_startdate}</td>
	</tr>
	<tr>
		<td>���ʤH��:</td>
		<td> �O�_�����ʳ̧C�H�ƭ���
			<input type="radio" name="estart_limit_check" id="estart_limit_no" value="0" <%=(eveVO.getEstart_limit()==0) ? "checked":"" %>  >�L
			<input type="radio" name="estart_limit_check" id="estart_limit_yes" value="1"  <%=(eveVO.getEstart_limit()>0) ? "checked":"" %> >��
		     <input type="TEXT" name="estart_limit" id="estart_limit" size="10"
			 value="<%= (eveVO.getEstart_limit()==0)? "" : eveVO.getEstart_limit()%>" />�H<br>
			  �O�_�����ʤH�ƤW��
			 <input type="radio" name="estart_max_check" id="estart_max_no" value="0" <%=(eveVO.getEstart_max()==0) ? "checked":"" %>>�L
			 <input type="radio" name="estart_max_check" id="estart_max_yes" value="1" <%=(eveVO.getEstart_max()>0) ? "checked":"" %> >��
		     <input type="TEXT" name="estart_max" id="estart_max" size="10"
			 value="<%= (eveVO.getEstart_max()==0)? "" : eveVO.getEstart_max() %>"/>�H
		</td>
		<td>${errorMsgs.estart_max}</td>
	</tr>
	
	<tr>
		<td>�B�����O</td>
		<td>
			<select size="1" name="sptype_id">
				<c:forEach var="sptype" items="${sportTypeMap}">
					<option value="${sptype.key}" ${(sptype.key==eveVO.sptype_id)? 'selected':'' } >${sptype.value}
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>���ʦa�I:</td>
		<td> 
			<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
			<select size="1" name="city_id">
				<c:forEach var="cityVO" items="${citySvc.all}">
					<option value="${cityVO.city_id}" ${(cityVO.city_id==eveVO.city_id)? 'selected':'' } >${cityVO.city_name}
				</c:forEach>
			</select>
			<input type="TEXT" name="eve_location" 
			 value="<%= (eveVO==null)? "" : eveVO.getEve_location()%>" />
		</td>
		<td>${errorMsgs.eve_location}</td>
	</tr>
	<tr>
		<td>���W���ʶO��:</td>
		<td>
			<input type="radio" name="eve_charge_check" id="eve_charge_no" value="0" <%=(eveVO.getEve_charge()==0) ? "checked":"" %>>�K�O
			<input type="radio" name="eve_charge_check" id="eve_charge_yes" value="1"  <%=(eveVO.getEve_charge()>0) ? "checked":"" %>>�C�H
		    <input type="TEXT" name="eve_charge" id="eve_charge" size="10"
			 value="<%=(eveVO.getEve_charge()==0)? "" : eveVO.getEve_charge()%>" />��<br>			 
		</td>
		<td>${errorMsgs.eve_charge}</td>
	</tr>
	<tr>
		<td>�D��H������X:</td>
		<td><input type="TEXT" name="econtact_info" size="45" placeholder="�榡09XX-XXXXXX"
			 value="<%= (eveVO==null)? "" : eveVO.getEcontact_info()%>" /></td>
		<td>${errorMsgs.econtact_info}</td>	 
	</tr>
	<tr>
		<td>���ʱԭz:</td>
		<td>
			<textarea id="econtent_summernote" name="editordata"></textarea>
	      	<input type="hidden" name="eve_content"  id="eve_content">   
		</td>
		<td>${errorMsgs.eve_content}</td>
	</tr>
	<tr>
		<td>���ʫإ߮ɶ�:</td>
		<td>
			<fmt:formatDate value="${eveVO.eestablish_date}" pattern="yyyy-MM-dd HH:mm "/>   
		</td>
		<td>${errorMsgs.eve_content}</td>
	</tr>
	
</table>
<br>
<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
<input type="hidden" name="action" value="update">
<input type="hidden" name="mem_id" value="${memVO.mem_id}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
<button  id="addBtnSubmit" type="submit">�T�{�ק�</button></FORM>	


<br>�e�X�ק諸�ӷ��������|:<br><b>
   <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
   <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%></b>
<script>
$(document).ready(function(){
	$("#estart_limit_no").focus(function(){
		$('#estart_limit').attr('disabled', true);
		$('#estart_limit').val("");
	});
	$("#estart_limit_yes").focus(function(){
		$('#estart_limit').attr('disabled', false);
	});
	
	$("#estart_max_no").focus(function(){
		$('#estart_max').attr('disabled', true);
		$('#estart_max').val("");
	});
	$("#estart_max_yes").focus(function(){
		$('#estart_max').attr('disabled', false);
	});
	
	$("#eve_charge_no").focus(function(){
		$('#eve_charge').attr('disabled', true);
		$('#eve_charge').val("");
	});
	$("#eve_charge_yes").focus(function(){
		$('#eve_charge').attr('disabled', false);
	});
	
});



</script>
<!-- summernote	  -->
 <script>
      $(document).ready(function(){
 
    	//��l��summernote
        $('#econtent_summernote').summernote({
            height: 200,                 
            minHeight: null,             
            maxHeight: 400,             
            focus: true ,
          });
    	
        //summernote���(�N��r��ܦbsummernote�W)     
		$("#econtent_summernote").summernote("code", '<%= (eveVO==null)? "" : eveVO.getEve_content()%>');
		
        //summernote����
        $("#addBtnSubmit").click(function(){
          var markupStr = $('#econtent_summernote').summernote('code');
          $("#eve_content").val(markupStr);
          console.log( $("#eve_content").val());

        });

      });

    </script> 	
    
    <!--     �W�ǹϤ� -->
    <script>
		$("#eve_photo").change(function(){
			
			if(this.files&&this.files[0]){
				$("#updateImgDiv").hide();
				$("#upload_pic1").parent().show();
				var reader=new FileReader();
				reader.onload=function(e){
				$("#upload_pic1").attr("src",e.target.result);
				}
				reader.readAsDataURL(this.files[0]);
			}
		});
		 $("#btn_cancel").click(function () {
			    $("#updateImgDiv").show();
		 		$("#upload_pic1").parent().hide();
			  $("#eve_photo").val("");        	 
	    });	
</script>           
    

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#ereg_startdate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       //step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEreg_startdate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // �h������(���t)���e
        });
        
        $.datetimepicker.setLocale('zh');
        $('#ereg_enddate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       //step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEreg_enddate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // �h������(���t)���e
        });
        
        $.datetimepicker.setLocale('zh');
        $('#eve_startdate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
	       value: '<%= (eveVO==null)? "" : eveVO.getEve_startdate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // �h������(���t)���e
        });
        
        
        $.datetimepicker.setLocale('zh');
        $('#eve_enddate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEve_enddate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // �h������(���t)���e
        });
        
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

//              1.�H�U���Y�@�Ѥ��e������L�k���
		 var ereg_startdateStr = $('#ereg_startdate').val()+" 00:00:00";
       	 var limitdate = new Date();
       	 limitdate.setDate(limitdate.getDate()+180); //�]�ج��ʪ��ɶ��b�b�~��
       	 var newDate =ereg_startdateStr.replace(/-/g,'/');
       	 ereg_startdate=new Date(newDate);
       	 
       	 $('#ereg_startdate').datetimepicker({   		 
             beforeShowDay: function(date) {
            	 var today = new Date();
//              	 console.log("����:"+today);
           	  if ( (date.getYear() < today.getYear()) || 
    		           (date.getYear() == today.getYear() && date.getMonth() < today.getMonth()) || 
    		           (date.getYear() == today.getYear() && date.getMonth() == today.getMonth() && date.getDate() < today.getDate())
    		           ||
    		           (date.getYear() >  limitdate.getYear()) || 
    		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
    		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                 ) {
                      return [false, ""]
                 }
                 return [true, ""];
          }});
       	 
       	 
       	 
    	
		 $('#eve_startdate,#ereg_enddate,#eve_enddate').datetimepicker({
		 
            beforeShowDay: function(date) {
          	  if ( (date.getYear() < ereg_startdate.getYear()) || 
   		           (date.getYear() == ereg_startdate.getYear() && date.getMonth() <  ereg_startdate.getMonth()) || 
   		           (date.getYear() == ereg_startdate.getYear() && date.getMonth() == ereg_startdate.getMonth() && date.getDate() < ereg_startdate.getDate())
   		           ||
   		           (date.getYear() >  limitdate.getYear()) || 
   		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
   		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                ) {
                     return [false, ""]
                }
                return [true, ""];
         }});
	       
	    $('#ereg_startdate').change(function(){ 
	    	if($('#eve_startdate').val()<$('#ereg_startdate').val()){
	    		 $('#eve_startdate').val($('#ereg_startdate').val()+" 00:00");
       	 	}
	    	if($('#ereg_enddate').val()<$('#ereg_startdate').val()){
	    		 $('#ereg_enddate').val($('#ereg_startdate').val());
       	 	}
	    	
	    	if($('#eve_enddate').val()<$('#ereg_startdate').val()){
	    		 $('#eve_enddate').val($('#ereg_startdate').val()+" 00:00");
     	 	}
      
        	 var ereg_startdateStr = $('#ereg_startdate').val()+" 00:00:00";
           	 var limitdate = new Date();
           	 limitdate.setDate(limitdate.getDate()+180); //�]�ج��ʪ��ɶ��b�b�~��
           	 var newDate =ereg_startdateStr.replace(/-/g,'/');
           	 ereg_startdate=new Date(newDate);
        	
        	        	 
        	 if($('#eve_enddate').val()!=""){
        		 var latterTimeStr=$('#ereg_enddate').val();
            	 if($('#ereg_enddate').val()<$('#eve_startdate').val()){
            		  latterTimeStr=$('#eve_startdate').val();
            	 }
            	 var newDate =latterTimeStr.replace(/-/g,'/');
            	 latterTime=new Date(newDate);
//         		 $('#eve_enddate').val($('#ereg_startdate').val());
        		 $('#eve_enddate').datetimepicker({
                     beforeShowDay: function(date) {
                   	  if ( (date.getYear() <  latterTime.getYear()) || 
            		       (date.getYear() ==  latterTime.getYear() && date.getMonth() <   latterTime.getMonth()) || 
            		       (date.getYear() ==  latterTime.getYear() && date.getMonth() ==  latterTime.getMonth() && date.getDate() <  latterTime.getDate())
            		       ||
		 		           (date.getYear() >  limitdate.getYear()) || 
		 		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
		 		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                         ) {
                              return [false, ""]
                         }
                         return [true, ""];
                 }});
        	 }       	 
        });
        
        $('#ereg_enddate,#eve_startdate').change(function(){
//         	 console.log("���ʶ}�l�ɶ�"+$('#eve_startdate').val());
        	 var ereg_enddateStr = $('#ereg_enddate').val()+" 00:00:00";
        	 var eve_startdateStr= $('#eve_startdate').val()+":00";
     
//         	 console.log(ereg_enddateStr<eve_startdateStr);
        	 
        	 var latterTimeStr=ereg_enddateStr;
        	 if(ereg_enddateStr<eve_startdateStr){
        		  latterTimeStr=eve_startdateStr;
        	 }
//         	 console.log(latterTimeStr);
        	 
        	 var newDate =latterTimeStr.replace(/-/g,'/');
        	 latterTime=new Date(newDate);
        	 console.log(($('#eve_enddate').val()+":00")>latterTimeStr);
        	 
        	 if(($('#eve_enddate').val()+":00")<latterTimeStr){
        		 if($('#eve_startdate').val()!=""){
        			    var ereg_enddateStr = $('#ereg_enddate').val()+" 00:00";
                	    var eve_startdateStr= $('#eve_startdate').val();
                	    var latter= (ereg_enddateStr>eve_startdateStr)?ereg_enddateStr:eve_startdateStr;
        	 			$('#eve_enddate').val( latter);
        	 		 }else{
        	 			$('#eve_enddate').val($('#ereg_enddate').val());
        	 		 }
        	 }
   	 		
   	 		 
   	 		 if($('#eve_startdate').val()<$('#ereg_startdate').val()){
   	 			$('#ereg_startdate').val($('#eve_startdate').val());
   	 			if($('#eve_startdate').val()>$('#ereg_enddate').val()){
   	 			$('#ereg_enddate').val($('#eve_startdate').val());	
   	 			}
   	 		 }
   	 		 if($('#ereg_enddate').val()<$('#ereg_startdate').val()){
   	 			$('#ereg_startdate').val($('#ereg_enddate').val());
   	 		 }
        	 
        	 
        	 $('#eve_enddate').datetimepicker({
                 beforeShowDay: function(date) {
               	  if ( (date.getYear() < latterTime.getYear()) || 
        		       (date.getYear() == latterTime.getYear() && date.getMonth() <  latterTime.getMonth()) || 
        		       (date.getYear() == latterTime.getYear() && date.getMonth() == latterTime.getMonth() && date.getDate() < latterTime.getDate())
        		       ||
	 		           (date.getYear() >  limitdate.getYear()) || 
	 		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
	 		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())   
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});
        });
        

        
        
        	
</script>



  <div class="py-5" id="speakers">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h2>�M�ݱ��ˬ���</h2>
          <div class="tab-content mt-2">
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="carousel slide" data-ride="carousel" id="bs4-multi-slide-carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="row">
              <div class="col-lg-4 col-md-4 img-group ">
                <a href="#">
                  <img src="assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title1</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              
                <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                  <span class="carousel-control-prev-icon"></span>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group">
                <a href="#">
                  <img src="assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title2</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group">
                <a href="#">
                  <img src="assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title3</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
           
                <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                  <span class="carousel-control-next-icon"></span>
                </a>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="row">
              <div class="col-lg-4 col-md-4 img-group">
                <a href="#">
                  <img src="assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title4</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
          
                <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                  <span class="carousel-control-prev-icon"></span>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group">
                <a href="#">
                  <img src="assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title5</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group">
                <a href="#">
                  <img src="assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title6</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
             
                <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                  <span class="carousel-control-next-icon"></span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>




     <!-- Sponsor logos -->
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="mb-4">Sponsors</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_1.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_4.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_3.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_2.png"> </div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/cover_2.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3">Something Here</h1>
          <p>Pre-register to get a priority access to the event. Fares will be published later on.&nbsp;
            <br>Get the maximum from the lectures together with the possibility of joining exclusive side-events.</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="text-md-left text-center p-4">
    <div class="container">
      <div class="row">
        <div class="col-lg-12"> </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <p class="text-muted">
            <br>
            <br> Copyright 2018 Pingendo - All rights reserved.
            <br>
            <br> </p>
        </div>
      </div>
    </div>
  </footer>
    
</body>



</html>