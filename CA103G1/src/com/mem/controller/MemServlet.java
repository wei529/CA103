package com.mem.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import com.mailservice.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.memsplike.model.MemSpLikeService;
import com.memsplike.model.MemSpLikeVO;

import redis.clients.jedis.Jedis;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("loginErrorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("password");
				String account = req.getParameter("email");
				if(account==null || (account.trim()).length()==0) {
					errorMsgs.add("請輸入帳號");
				}
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/******************************
				 * 2.登入-在資料庫查詢會員的帳號密碼
				 *****************************************/
				MemVO loggedMember = new MemVO();
				String email = req.getParameter("email");
				String psw = req.getParameter("password");
				loggedMember.setMem_account(email);
				loggedMember.setMem_password(psw);
				MemService memSvc = new MemService();
				loggedMember = memSvc.loginMem(loggedMember.getMem_account(), loggedMember.getMem_password());
				

				/*************************** 3.登入完成,準備轉交(Send the Success view) *************/
				if ("MS0".equals(loggedMember.getMem_status())) {
					HttpSession session = req.getSession();
					session.setAttribute("memVO", loggedMember);
					String url = "/front_end/mem/login/Verify.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 驗證未通過 轉交 Verify.jsp
					successView.forward(req, res);
				} else {
					MemSpLikeService memsplikeSvc = new MemSpLikeService();
					List<MemSpLikeVO> memSpLikeVOList = new ArrayList<MemSpLikeVO>();
					memSpLikeVOList = memsplikeSvc.findByMemId(loggedMember.getMem_id());
					HttpSession session = req.getSession();
					session.setAttribute("memSpLikeVOList",memSpLikeVOList);
					session.setAttribute("memVO", loggedMember);
					String location=(String)session.getAttribute("location");
					
					String url= req.getContextPath()+"/index.jsp";  //無來源網頁 重導至INDEX.Html
					if(location!=null&&!location.equals(req.getContextPath()+"/js/animate-in.js")&&
							!location.equals(req.getContextPath()+"/js/navbar_ontop.js")) { 							//確認有無來源網頁 有則導向來源網頁
						url=location;                        
					}	
					System.out.println(url);
					
					res.sendRedirect(url);
					return;
					

				}

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (NullPointerException npe) {
				errorMsgs.add("帳號密碼有誤,請重新輸入");
				RequestDispatcher failureView = req.getRequestDispatcher("/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
		}

		if ("loggedout".equals(action)) {
//			System.out.println("I am here");
//			System.out.println(req.getContextPath());
//			System.out.println(req.getAttribute(action));
//			System.out.println(req.getServletPath());
//			System.out.println(req.getPathTranslated());
//			System.out.println(req.getRequestURL());
//			System.out.println(req.getRequestURI());
//			System.out.println(req.getQueryString());

			HttpSession session = req.getSession();
			session.invalidate();

			String url = req.getContextPath()+"/index.jsp";  //登出重導至INDEX.Html
			res.sendRedirect(url);
			return;
		}
		
		if("resend".equals(action)) {
			String verifyCode = returnAuthCode();
			String regaccount = req.getParameter("regAccount");
			String regName = req.getParameter("regName");
			MailService verifyEMail = new MailService();
			verifyEMail.jedisVeriCode(regaccount, verifyCode);
			System.out.println("Auth code is: " + verifyCode);
			String subject = "[Work It Out] 會員認證信";
			String veriURL = req.getRequestURL()+"?action=verifyCode&verifyCode="+verifyCode;
			String veriAddr = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+ "/front_end/mem/login/Verify.jsp";
			String messageText =
					"<div style=\"font-size:20px\">*************************************************<br>"
					+ "注意！本信件由系統發出，請勿回覆此信件 <br>"
					+ "*************************************************<br></div>"
					+ "<div style=\"font-size:20px\"><br>親愛的會員　您好： <br>恭喜您已成為 WORK it OUT 的會員，以下是您的基本資料，請依說明完成帳號認證，日後 WORK it OUT 才能為您服務。<br>"
					+"<br>會員帳號："+regaccount+"&nbsp;<a href=\""+veriURL+"\">認證帳號</a>"
					+"<br>會員名稱："+regName	+"<br><br>"+"※提醒您，您必須先完成帳號認證，才能登入WORK it OUT。<br>"
					+"<br>"+"如果您無法點選以上連結，請直接複製以下網址貼到瀏覽器網址列：  <br>"
					+veriURL
					+"<br><br>或至<a href=\""+veriAddr+"\">驗證網頁</a>輸入以下驗證碼<br>"
					+verifyCode
					+"<br><br>如果此帳號非您所有，請直接刪除此信件。謝謝！"
					+"</div>";
			verifyEMail.sendMail(regaccount, subject, messageText);
			System.out.println("email has been sent");
			RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Verify.jsp");
			failureView.forward(req, res);
		}

		if ("mem_signUp".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String regEmail = req.getParameter("regEmail");
				String regPassword = req.getParameter("regPassword");
				String confirmedPsw = req.getParameter("confirmedPsw");
				String regName = req.getParameter("regName");
				
				
				if (regEmail == null || (regEmail.trim()).length() == 0) {
					errorMsgs.add("請輸入帳號");
				}
				
				if (regName == null || (regName.trim()).length() == 0) {
					errorMsgs.add("請輸入暱稱");
				}
				
				if (regPassword == null || (regPassword.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				}
				
				if (confirmedPsw == null || (confirmedPsw.trim()).length() == 0) {
					errorMsgs.add("請輸入確認密碼");
				}
				
				if (!(confirmedPsw.equals(regPassword))) {
					System.out.println("here");
					errorMsgs.add("密碼不一致");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal = true;
					req.setAttribute("openModal", openModal);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始註冊資料 *****************************************/

				MemVO memVO = new MemVO();
				String regaccount = req.getParameter("regEmail");
				regName = req.getParameter("regName");
				String regPsw = req.getParameter("regPassword");
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(regaccount, regName, regPsw);
				memVO.setMem_account(regaccount);
				memVO.setMem_name(regName);
				memVO.setMem_password(regPsw);
				memVO.setMem_email(regaccount);
				memVO.setMem_status("MS0");

				//產生驗證碼並存入redis
				String verifyCode = returnAuthCode();
				MailService verifyEMail = new MailService();
				verifyEMail.jedisVeriCode(regaccount, verifyCode);
				System.out.println("Auth code is: " + verifyCode);
				String subject = "[Work It Out] 會員認證信";
				String veriURL = req.getRequestURL()+"?action=verifyCode&verifyCode="+verifyCode;
				String veriAddr = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+ "/front_end/mem/login/Verify.jsp";
				String messageText = 
									"<div style=\"font-size:20px\">*************************************************<br>"
									+ "注意！本信件由系統發出，請勿回覆此信件 <br>"
									+ "*************************************************<br></div>"
									+ "<div style=\"font-size:20px\"><br>親愛的會員　您好： <br>恭喜您已成為 WORK it OUT 的會員，以下是您的基本資料，請依說明完成帳號認證，日後 WORK it OUT 才能為您服務。<br>"
									+"<br>會員帳號："+regaccount+"&nbsp;<a href=\""+veriURL+"\">認證帳號</a>"
									+"<br>會員名稱："+regName	+"<br><br>"+"※提醒您，您必須先完成帳號認證，才能登入WORK it OUT。<br>"
									+"<br>"+"如果您無法點選以上連結，請直接複製以下網址貼到瀏覽器網址列：  <br>"
									+veriURL
									+"<br><br>或至<a href=\""+veriAddr+"\">驗證網頁</a>輸入以下驗證碼<br>"
									+verifyCode
									+"<br><br>如果此帳號非您所有，請直接刪除此信件。謝謝！"
									+"</div>";
				verifyEMail.sendMail(regaccount, subject, messageText);
				System.out.println("email has been sent");


				MemVO loggedMember = memSvc.loginMem(regaccount, regPsw);
				HttpSession session = req.getSession();
				session.setAttribute("memVO", loggedMember); // 把帳號先存起來 為了之後去redis取驗證碼

				String url = "/front_end/mem/login/Verify.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("錯誤訊息: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}

		}

		if ("verifyCode".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String verifyCode = req.getParameter("verifyCode");
				if (verifyCode == null || (verifyCode.trim()).length() == 0) {
					errorMsgs.add("請輸入驗證碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Verify.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/***************************
				 * 2.與redis資料庫比對驗證碼是否正確
				 *****************************************/


				// 開啟redis取得驗證碼
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");
				HttpSession session = req.getSession();
				MemVO memVO = new MemVO();
				memVO = (MemVO) session.getAttribute("memVO");
				String tempAuth = jedis.get(memVO.getMem_account());

				if (tempAuth == null) {
					System.out.println("驗證碼已逾時，請重新申請");
					errorMsgs.add("驗證碼已逾時，請重新申請");
				} else if (verifyCode.equals(tempAuth)) {
					memVO.setMem_status("MS1");
					MemService memSev = new MemService();
					memSev.updateStatus(memVO.getMem_account(), memVO.getMem_status());
					System.out.println("驗證成功!");
				} else {
					System.out.println("驗證有誤，請確認驗證碼或重新申請");
					errorMsgs.add("驗證有誤，請確認驗證碼或重新申請");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Verify.jsp");
					failureView.forward(req, res);
					jedis.close();
					return;// 程式中斷
				}
				jedis.close();

				String url = req.getContextPath()+"/index.jsp";
				res.sendRedirect(url);
				return;


			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}

		}

		if ("mem_update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
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

				/******************************* 2-1.執行會員資料修改*****************************************/
				HttpSession session = req.getSession();
				MemVO loggedMember = (MemVO) session.getAttribute("memVO");
				MemService memSvc = new MemService();
				MemVO updatedMem = memSvc.getOneMem(loggedMember.getMem_id());
				
				Part part = req.getPart("memPhoto");
				byte[] memPhoto=loggedMember.getMem_photo();
				
				if(part.getSize() !=0) {
					InputStream is = part.getInputStream();
					memPhoto = new byte[is.available()];
					is.read(memPhoto);
					is.close();
					System.out.println("success");
				}

				java.sql.Date membirth = null;
				if(!(req.getParameter("memBirth").isEmpty())) {
					System.out.println(req.getParameter("memBirth"));
					System.out.println("here");
					membirth = java.sql.Date.valueOf(req.getParameter("memBirth"));					
				}
				String memName = req.getParameter("memName");
				String memEmail = req.getParameter("memEmail");
				String memIntro = req.getParameter("memIntro");

				updatedMem = memSvc.updateMem(updatedMem.getMem_id(), memName, updatedMem.getMem_account(),
						updatedMem.getMem_password(), membirth, memPhoto, memEmail, memIntro);

				MemSpLikeVO memSpLikeVO = new MemSpLikeVO();
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				
				String[] memSpLike = req.getParameterValues("memSpLike");
				/*******************************2-2.執行會員運動喜好修改************************************/
				if(memSpLike != null) {
					//會員有勾選運動喜好
					for(int i=1;i<9;i++) {
						memsplikeSvc.delete(updatedMem.getMem_id(), "SP00000"+i);		
					}
					for(int i=0;i<memSpLike.length;i++) {
						memSpLikeVO.setMem_id(loggedMember.getMem_id());
						memSpLikeVO.setSptype_id(memSpLike[i]);
						memSpLikeVO.setLike_status("LS1");
						memsplikeSvc.insert(memSpLikeVO);
					}		
				}else {
					//會員無勾選運動喜好
					for(int i=1;i<9;i++) {
						memsplikeSvc.delete(updatedMem.getMem_id(), "SP00000"+i);		
					}
				}
				
				List<MemSpLikeVO> memSpLikeVOList = new ArrayList<MemSpLikeVO>();
				memSpLikeVOList = memsplikeSvc.findByMemId(loggedMember.getMem_id());
				session.setAttribute("memSpLikeVOList",memSpLikeVOList);
				session.setAttribute("memVO", updatedMem);
//				memSvc.getMemberPhoto(updatedMem.getMem_id());
				String url= req.getContextPath()+"/index.jsp"; 
				res.sendRedirect(url);
				return;

			} catch (NullPointerException npe) {
				errorMsgs.add("錯誤訊息: " + npe.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			} catch (IllegalArgumentException pe) {
				pe.printStackTrace();
				errorMsgs.add("錯誤訊息: " + pe.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}
		}

	}


	private static String returnAuthCode() {
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 8; i++) {
			int condition = (int) (Math.random() * 3) + 1;
			switch (condition) {
			case 1:
				char c1 = (char) ((int) (Math.random() * 26) + 65);
				sb.append(c1);
				break;
			case 2:
				char c2 = (char) ((int) (Math.random() * 26) + 97);
				sb.append(c2);
				break;
			case 3:
				sb.append((int) (Math.random() * 10));
			}
		}
		return sb.toString();
	}

}