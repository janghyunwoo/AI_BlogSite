package com.kwon.ihwac.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kwon.ihwac.main.DateManager;

/**
 * Servlet implementation class MemberJoinController
 */
@WebServlet("/MemberJoinController")
public class MemberJoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberJoinController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*DateManager.getCurrentYear(request, response);
		MemberDAO.getMdao().loginCheck(request, response);
		request.setAttribute("contentPage", "member/join.jsp");
		request.getRequestDispatcher("jsp/index.jsp").forward(request, response);*/
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO.getMdao().join(request, response);
		MemberDAO.getMdao().loginCheck(request, response);
		request.setAttribute("contentPage", "home.jsp");
		request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
	}

}







