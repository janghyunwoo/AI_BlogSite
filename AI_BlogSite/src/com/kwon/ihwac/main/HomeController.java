package com.kwon.ihwac.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kwon.ihwac.member.MemberDAO;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO.getMdao().defPicture(request, response);
		DateManager.getCurrentYear(request, response);
		MemberDAO.getMdao().autologin(request, response);
		boolean ok = MemberDAO.getMdao().loginCheck(request, response);
		//request.setAttribute("contentPage", "home.jsp");
		//request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
		
		if(ok) {
			request.setAttribute("contentPage", "../home.jsp");
			request.getRequestDispatcher("jsp/main/main.jsp").forward(request, response);
		}else {
			
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO.getMdao().defPicture(request, response);
		DateManager.getCurrentYear(request, response);
		MemberDAO.getMdao().autologin(request, response);
		boolean ok = MemberDAO.getMdao().loginCheck(request, response);
		//request.setAttribute("contentPage", "home.jsp");
		//request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
		
		if(ok) {
			request.setAttribute("contentPage", "../home.jsp");
			request.getRequestDispatcher("jsp/main/main.jsp").forward(request, response);
		}else {
			
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}
	}

}







