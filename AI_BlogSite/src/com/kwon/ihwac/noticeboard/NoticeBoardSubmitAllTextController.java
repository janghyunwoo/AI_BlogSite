package com.kwon.ihwac.noticeboard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kwon.ihwac.main.DateManager;
import com.kwon.ihwac.member.MemberDAO;

/**
 * Servlet implementation class MemberByeController
 */
@WebServlet("/NoticeBoardSubmitAllTextController")
public class NoticeBoardSubmitAllTextController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoticeBoardSubmitAllTextController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if (MemberDAO.getMdao().loginCheck(request, response)) {
			response.setContentType("text/html;charset=UTF-8");
			
			NoticeBoardDAO.getMdao().getAllNoticeBoard(request, response);
			NoticeBoardDAO.getMdao().paging(1, request, response);
			
		} else {
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
		
	}

}
