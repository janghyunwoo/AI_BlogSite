package com.kwon.ihwac.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kwon.ihwac.main.DateManager;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/MemberUpdateController")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberUpdateController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (MemberDAO.getMdao().loginCheck(request, response)) {
			DateManager.getCurrentYear(request, response);
			request.setAttribute("contentPage", "member/updateMember.jsp");
		} else {
			request.setAttribute("contentPage", "home.jsp");
		}
		request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (MemberDAO.getMdao().loginCheck(request, response)) {
			MemberDAO.getMdao().update(request, response);
			DateManager.getCurrentYear(request, response);
			request.setAttribute("contentPage", "member/updateMember.jsp");
		} else {
			request.setAttribute("contentPage", "home.jsp");
		}
		request.getRequestDispatcher("jsp/index.jsp").forward(request, response);

	}

}






