package com.kwon.ihwac.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberLoginController
 */
@WebServlet("/MemberLoginController")
public class MemberLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean ok = MemberDAO.getMdao().login(request, response);
		//MemberDAO.getMdao().loginCheck(request, response);
		//request.setAttribute("contentPage", "home.jsp");
		if(ok) {
			request.getRequestDispatcher("jsp/main/main.jsp").forward(request, response);
			
		}else {
			
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
		

	}

}













