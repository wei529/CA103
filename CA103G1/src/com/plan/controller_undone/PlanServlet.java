package com.plan.controller_undone;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plan.model.PlanService;
import com.plan.model.PlanVO;

public class PlanServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String plan_name = req.getParameter("plan_name");
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (plan_name == null || plan_name.trim().length() == 0) {
					errorMsgs.add("計畫名稱: 請勿空白");
				}

				java.sql.Date plan_create_date = null;
				try {
					plan_create_date = java.sql.Date.valueOf(req.getParameter("plan_create_date").trim());
				} catch (IllegalArgumentException e) {
					plan_create_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				PlanVO planVO = new PlanVO();
				planVO.setMem_id(mem_id);
				planVO.setPlan_name(plan_name);
				planVO.setPlan_vo(plan_vo);
				planVO.setPlan_cover(plan_cover);
				planVO.setPlan_start_date(plan_start_date);
				planVO.setPlan_end_date(plan_end_date);
				planVO.setSptype_id(sptype_id);
				planVO.setPlan_view(plan_view);
				planVO.setPlan_create_date(plan_create_date);
				planVO.setPlan_privacy(plan_privacy);
				planVO.setPlan_status(plan_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PlanService planSvc = new PlanService();
				planVO = planSvc.addPlan(mem_id, plan_name, plan_vo, plan_cover, plan_start_date, plan_end_date,
						sptype_id, plan_view, plan_privacy, plan_status);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/addEmp.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
