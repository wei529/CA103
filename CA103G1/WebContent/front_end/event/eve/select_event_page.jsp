<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />

<%  //模擬會員的SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000003"));
 %> 

<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>select_event_page.jsp</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>Event Page: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Event Page: Home</p>

<h3>資料查詢:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/event/eve/listAllEve.jsp'>List</a> all Eves. <br><br></li>
  
    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
       <b>選擇活動編號:</b>
       <select size="1" name="eve_id">
         <c:forEach var="eveVO" items="${eveSvc.all}" > 
          <option value="${eveVO.eve_id}">${eveVO.eve_title}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp" >
       <b>主辦會員的活動管理new:</b>
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  </ul>

<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1">
        <b><font color=blue>萬用複合查詢:</font></b> <br>
        <b>關鍵字:</b>
        <input type="text" name="keyword"><br>
           
       <b>活動時間:</b>
        <input name="eve_startdate" id="f_date1" type="text">~
		<input name="eve_enddate" id="f_date1" type="text"><br>
       
        <b>活動金額:</b>
       <select size="1" name="eve_charge" >
       	  <option value="">不限
          <option value="0">免費        
          <option value="300">300元以下
          <option value="500">300元~500元
          <option value="1000">500元~1000元
          <option value="1001">1000元以上
       </select><br>
       
          	
    	
       <jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
       <b>選擇活動地區:</b>
       <select size="1" name="city_id" >
          <option value="">全台灣
         <c:forEach var="cityVO" items="${citySvc.all}" > 
          <option value="${cityVO.city_id}">${cityVO.city_name}
         </c:forEach>   
       </select><br>
       
       <b>選擇運動種類:</b>
       <select size="1" name="sptype_id" >
          <option value="">不限
         <c:forEach var="sptype" items="${sportTypeMap}" > 
          <option value="${sptype.key}">${sptype.value}
         </c:forEach>   
       </select><br>
       
       <b>排序依:</b>
       <input type="radio" name="orderBy" value="hot" checked >熱門活動
       <input type="radio" name="orderBy" value="eve_startdate">活動時間
       <input type="radio" name="orderBy" value="new">最新刊登

        <br>  		        
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="listEves_ByCompositeQuery">
     </FORM>
  </li>
</ul>



<h3><font color=orange>新增活動</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/event/eve/addEve.jsp'>Add</a> Event </li>
</ul>


<h3>聊天室</h3>

<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<c:forEach var="evelsVO" items="${evelistSvc.getEveListsByMem(memVO.mem_id)}">	
	<ul>
		<li>
			活動名稱: ${evelsVO.eve_id}-${eveSvc.getOneEve(evelsVO.eve_id).eve_title}
			<a href='<%=request.getContextPath() %>/front_end/event/evechat/evechat.jsp?eve_id=${evelsVO.eve_id}'>Enter</a>
		</li>
	</ul>	
</c:forEach>

</body>
</html>