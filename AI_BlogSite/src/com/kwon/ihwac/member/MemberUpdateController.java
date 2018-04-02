package com.kwon.ihwac.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kwon.ihwac.main.DateManager;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("성공");
		} else {
			request.setAttribute("contentPage", "home.jsp");
		}
		//request.getRequestDispatcher("jsp/main/main.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		/*String path = request.getServletContext().getRealPath("etc");
		System.out.println(path);
		MultipartRequest mr = new MultipartRequest(request, path, 31457280, "utf-8",
				new DefaultFileRenamePolicy());
		
		System.out.println(mr.getFilesystemName("img"));
		System.out.println(mr.getParameter("name"));
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("성공111");*/
		
		if (MemberDAO.getMdao().loginCheck(request, response)) {
			response.setContentType("text/html;charset=UTF-8");
			
			response.getWriter().write(MemberDAO.getMdao().update(request, response));
		} else {
			request.getRequestDispatcher("jsp/login/login.jsp").forward(request, response);
		}

	}

}






