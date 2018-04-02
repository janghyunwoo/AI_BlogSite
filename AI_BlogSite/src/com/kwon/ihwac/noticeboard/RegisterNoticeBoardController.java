package com.kwon.ihwac.noticeboard;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.kwon.ihwac.main.DateManager;
import com.kwon.ihwac.member.MemberDAO;

/**
 * Servlet implementation class MemberByeController
 */
@WebServlet("/RegisterNoticeBoardController")
public class RegisterNoticeBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterNoticeBoardController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println("RegisterNoticeBoardController_get_새로고침");
		MemberDAO.getMdao().defPicture(request, response);
		DateManager.getCurrentYear(request, response);
		MemberDAO.getMdao().autologin(request, response);
		boolean ok = MemberDAO.getMdao().loginCheck(request, response);
		//request.setAttribute("contentPage", "home.jsp");
		//request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
		
		if(ok) {
			request.setAttribute("contentPage", "notice_board.jsp");
			request.getRequestDispatcher("jsp/main/main.jsp").forward(request, response);
		}else {
			
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("RegisterNoticeBoardController_post_새로고침");

		if (MemberDAO.getMdao().loginCheck(request, response)) {
			response.setContentType("text/html;charset=UTF-8");

			NoticeBoardDAO.getMdao().insertWriteText(request, response);
			
			NoticeBoardDAO.getMdao().getAllNoticeBoard(request, response);


			
		} else {
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
	}

}
