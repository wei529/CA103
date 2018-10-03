package com.mem.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import com.mailservice.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import redis.clients.jedis.Jedis;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet {

	public void doGet (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		doPost(req,res);
	}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException { 

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("password");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/*****************************2.登入-在資料庫查詢會員的帳號密碼*****************************************/
				MemVO loggedMember = new MemVO();
				String email = req.getParameter("email");
				String psw = req.getParameter("password");
				loggedMember.setMem_account(email);
				loggedMember.setMem_password(psw);
				MemService memSvc = new MemService();
				loggedMember = memSvc.loginMem(loggedMember.getMem_account(), loggedMember.getMem_password());
				System.out.println(loggedMember.getMem_status());
				
				/***************************3.登入完成,準備轉交(Send the Success view)*************/
				if("MS0".equals(loggedMember.getMem_status())) {
					HttpSession session = req.getSession();
					session.setAttribute("memVO", loggedMember);
					String url = "/front_end/mem/login/Verify.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 TestView.jsp
					successView.forward(req, res);
				}else {
					HttpSession session = req.getSession();
					session.setAttribute("memVO", loggedMember);
					String url = "/front_end/mem/login/TestView.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 TestView.jsp
					successView.forward(req, res);
					
				}
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(NullPointerException npe) {
				errorMsgs.add("帳號密碼有誤" + npe.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/updateMember/FailPage.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("loggedout".equals(action)) {
			System.out.println("I am here");
			System.out.println(req.getContextPath());
			System.out.println(req.getAttribute(action));
			System.out.println(req.getServletPath());
			System.out.println(req.getPathTranslated());
			System.out.println(req.getRequestURL());
			System.out.println(req.getRequestURI());
			System.out.println(req.getQueryString());
			
			HttpSession session = req.getSession();
			session.invalidate();
			
			String url = "/front_end/mem/login/Mem_Login_Signup.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 TestView.jsp
			successView.forward(req, res);
		}
		
		if ("mem_signUp".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("regPassword");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal=true;
					req.setAttribute("openModal",openModal );
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.開始註冊資料*****************************************/
				
				MemVO memVO = new MemVO();
				
				String regaccount = req.getParameter("regEmail");
				String regName = req.getParameter("regName");
				String regPsw = req.getParameter("regPassword");
				memVO.setMem_account(regaccount);
				memVO.setMem_name(regName);
				memVO.setMem_password(regPsw);
				memVO.setMem_email(regaccount);
				memVO.setMem_status("MS0");
				
				MailService verifyEMail = new MailService();
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");
				
				String verifyCode = returnAuthCode();	
				jedis.set(regaccount, verifyCode);
				jedis.expire(regaccount, 100);
				
				System.out.println("Auth code is: " + verifyCode);
				String subject = "[Work It Out] 會員認證信";
			    String messageText = "Hello! " + regName + " 請輸入此驗證碼:" + verifyCode + "\n"; 
			    verifyEMail.sendMail(regaccount, subject, messageText);
				System.out.println("email has been sent");
				
				jedis.close();
			    
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(regaccount, regName, regPsw);
				MemVO loggedMember = memSvc.loginMem(regaccount, regPsw);
				HttpSession session = req.getSession();
				session.setAttribute("memVO", loggedMember); //把帳號先存起來 為了之後去redis取驗證碼
				
				String url = "/front_end/mem/login/Verify.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		
		
		if("verifyCode".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("verifyCode");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入驗證碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/mem/login/Verify.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.與redis資料庫比對驗證碼是否正確*****************************************/
				
				MemVO memVO = new MemVO();
				
				String verifyCode = req.getParameter("verifyCode");
				
				//開啟redis取得驗證碼
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");
				HttpSession session = req.getSession();
				memVO = (MemVO)session.getAttribute("memVO");
				String tempAuth = jedis.get(memVO.getMem_account());
				
				
				if (tempAuth == null) {
					System.out.println("連結信已逾時，請重新申請");
				} else if (verifyCode.equals(tempAuth)){
					memVO.setMem_status("MS1");
					MemService memSev = new MemService();
					memSev.updateStatus(memVO.getMem_account(), memVO.getMem_status());
					System.out.println("驗證成功!");
				} else {
					System.out.println("驗證有誤，請重新申請");
				}							
				jedis.close();
			    
				String url = "/front_end/mem/login/TestView.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
			
		
			
		}
		
		if ("mem_update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String str = req.getParameter("password");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入密碼");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/mem/login/TestView.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
				

				/*****************************2.執行會員資料修改*****************************************/
				HttpSession session = req.getSession();
				MemVO loggedMember = (MemVO)session.getAttribute("memVO");
				MemService memSvc = new MemService();
				MemVO updatedMem = memSvc.getOneMem(loggedMember.getMem_id());
				
				byte[] memPhoto = null;
				Part part = req.getPart("memPhoto");
				InputStream is = part.getInputStream();
				memPhoto = new byte[is.available()];
				is.read(memPhoto);

				java.sql.Date membirth = null;
				String memName =req.getParameter("memName");
				membirth = java.sql.Date.valueOf(req.getParameter("memBirth"));
				
				String memEmail =req.getParameter("memEmail");
				String memIntro =req.getParameter("memIntro");
				
				updatedMem = memSvc.updateMem(updatedMem.getMem_id(), memName, updatedMem.getMem_account(), updatedMem.getMem_password(),membirth, memPhoto, memEmail, memIntro);
				
				session.setAttribute("memVO", updatedMem);
				System.out.println("success");
				String url = "/front_end/mem/login/TestView.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 TestView.jsp
				successView.forward(req, res);
				
			}catch(NullPointerException npe) {
				errorMsgs.add("帳號密碼有誤" + npe.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			} catch (IllegalArgumentException pe) {
				pe.printStackTrace();
			}
		}
		
	}
	
	private static String returnAuthCode() {
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 8; i++) {
			int condition = (int) (Math.random() * 3) + 1;
			switch (condition) {
			case 1:
				char c1 = (char)((int)(Math.random() * 26) + 65);
				sb.append(c1);
				break;
			case 2:
				char c2 = (char)((int)(Math.random() * 26) + 97);
				sb.append(c2);
				break;
			case 3:
				sb.append((int)(Math.random() * 10));
			}
		}
		return sb.toString();
	}
	
}