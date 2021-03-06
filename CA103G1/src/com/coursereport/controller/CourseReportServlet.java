package com.coursereport.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Mgr.model.MgrVO;
import com.courlist.model.CourlistService;
import com.courlist.model.CourlistVO;
import com.coursereport.model.CourseReportService;
import com.coursereport.model.CourseReportVO;
import com.mem.model.MemVO;

@WebServlet("/CourseReportServlet")
public class CourseReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CourseReportServlet() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String action1 = req.getParameter("action1");
		System.out.println(action1);
		if("addReport".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courrepText = req.getParameter("courrepText");
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				CourlistVO courlistVO = (CourlistVO) session.getAttribute("brows_courlistVO");
				
				if (courrepText == null || (courrepText.trim()).length() == 0) {
					errorMsgs.add("請輸入檢舉內容");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal = true;
					req.setAttribute("openModal", openModal);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/oneCourlist.jsp?cour_id="+courlistVO.getCour_id()+"&courpageloc=tabone");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始註冊資料 *****************************************/

				String reportItem = req.getParameter("reportItem");
				
				Timestamp ts = new Timestamp(System.currentTimeMillis());  
				
				CourseReportService courseReportSvc = new CourseReportService();
				courseReportSvc.addCourseRep(ts, courlistVO.getCour_id(), memVO.getMem_id(), reportItem, courrepText);
				
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/course/courlist/oneCourlist.jsp?cour_id="+courlistVO.getCour_id()+"&courpageloc=tabone");
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("錯誤訊息: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}			
		}
		
		
		if("updateState".equals(action1)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String courrepText = req.getParameter("courrepText");
//				HttpSession session = req.getSession();
//				MemVO memVO = (MemVO) session.getAttribute("memVO");
//				CourlistVO courlistVO = (CourlistVO) session.getAttribute("brows_courlistVO");
//				
//				if (courrepText == null || (courrepText.trim()).length() == 0) {
//					errorMsgs.add("請輸入檢舉內容");
//				}
//				
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					boolean openModal = true;
//					req.setAttribute("openModal", openModal);
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/courlist/oneCourlist.jsp?cour_id="+courlistVO.getCour_id()+"&courpageloc=tabone");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}

				/**************************************** 2.開始註冊資料 *****************************************/

				String courrepStatus = req.getParameter("courrepStatus");
				String courrepoID = req.getParameter("courrepoID");
				String replyMgrID = req.getParameter("replyMgrID");
				CourseReportService courseReportSvc = new CourseReportService();
				System.out.println(courrepStatus);
				if("CR2".equals(courrepStatus)) {
					CourseReportVO courseReportVO = courseReportSvc.updateCourseRepStatus(courrepStatus, courrepoID, replyMgrID);
 
					CourlistService courlistService = new CourlistService();

					courlistService.updateStates("CL01", courseReportVO.getCour_id());
					System.out.println(courrepoID);
				}else if("CR3".equals(courrepStatus)) {
					courseReportSvc.updateCourseRepStatus(courrepStatus, courrepoID, replyMgrID);
				}
				
				RequestDispatcher successView = req.getRequestDispatcher("/back_end/review/courseReport.jsp");
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("錯誤訊息: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}			
		
		}
	}
}
