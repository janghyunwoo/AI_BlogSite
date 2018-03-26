package com.kwon.ihwac.member;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kwon.ihwac.main.DBManager;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberDAO {
	private static final MemberDAO MDAO = new MemberDAO();

	public static MemberDAO getMdao() {
		return MDAO;
	}

	private MemberDAO() {
		// TODO Auto-generated constructor stub
	}

	public void autologin(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] allCookies = request.getCookies();

		if (allCookies != null) {
			for (Cookie cookie : allCookies) {
				// ihwacAutoLoginID이라는 이름의 쿠키가 있으면
				if (cookie.getName().equals("ihwacAutoLoginID")) {
					// 쿠키에 들어있는 값이 있으면
					if (cookie.getValue() != null) {

						Connection con = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						try {
							con = DBManager.connect();

							String im_id = cookie.getValue();

							String sql = "select * from ihwac_member " + "where im_id=?";

							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, im_id);

							rs = pstmt.executeQuery();

							if (rs.next()) {
								String db_pw = rs.getString("im_pw");

								// ctrl + shift + f
								Cookie lastLoginID = new Cookie("lastLoginID", im_id);
								lastLoginID.setMaxAge(86400);
								response.addCookie(lastLoginID);

								Member m = new Member();
								m.setIm_id(im_id);
								m.setIm_pw(db_pw);
								m.setIm_name(rs.getString("im_name"));
								m.setIm_addr(rs.getString("im_addr"));
								m.setIm_birthday(rs.getDate("im_birthday"));
								m.setIm_img(rs.getString("im_img"));

								HttpSession hs = request.getSession();
								hs.setAttribute("loginMember", m);
								hs.setMaxInactiveInterval(15 * 60); //

								Cookie autoLoginID = new Cookie("ihwacAutoLoginID", im_id);
								autoLoginID.setMaxAge(86400);
								response.addCookie(autoLoginID);

							} else {
								request.setAttribute("r", "그런 계정 없음");
							}

						} catch (Exception e) {
							e.printStackTrace();
							request.setAttribute("r", "DB 서버 문제");
						} finally {
							DBManager.close(con, pstmt, rs);
						}

					}
				}
			}
		}
	}

	public void bye(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBManager.connect();

			HttpSession hs = request.getSession();
			Member m2 = (Member) hs.getAttribute("loginMember");

			String im_id = m2.getIm_id();
			String im_pw = request.getParameter("im_pw");

			if (im_pw.equals(m2.getIm_pw())) {
				String sql = "delete from ihwac_member where im_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, im_id);
				if (pstmt.executeUpdate() == 1) {
					String path = request.getServletContext().getRealPath("etc");
					String oldImg = m2.getIm_img();
					oldImg = URLDecoder.decode(oldImg, "euc-kr");
					File oldFile = new File(path + "/" + oldImg);
					oldFile.delete();

					logout(request, response);

					request.setAttribute("r", "회원 탈퇴 성공");
				} else {
					request.setAttribute("r", "회원 탈퇴 실패");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "회원 탈퇴 실패");
		} finally {
			DBManager.close(con, pstmt, null);
		}
	}

	public void join(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBManager.connect();

			String path = request.getServletContext().getRealPath("etc");
			System.out.println(path);
			MultipartRequest mr = new MultipartRequest(request, path, 31457280, "utf-8",
					new DefaultFileRenamePolicy());

			String id = mr.getParameter("id");
			String pw = mr.getParameter("pw");
			// String im_pwChk = mr.getParameter("im_pwChk");
			String name = mr.getParameter("name");
			String sex = mr.getParameter("sex");
			String im_y = mr.getParameter("im_y"); // "1982"
			String im_m = mr.getParameter("im_m"); // "1"
			int im_m2 = Integer.parseInt(im_m); // 1
			String im_d = mr.getParameter("im_d"); // "2"
			int im_d2 = Integer.parseInt(im_d); // 2

			String im_birthday = String.format("%s%02d%02d", im_y, im_m2, im_d2);
			// 19820102

			String img = mr.getFilesystemName("img");
//			im_img = URLEncoder.encode(im_img, "euc-kr");
//			im_img = im_img.replace("+", " ");

			String sql = "insert into ihwac_member values(" + "?, ?, ?, ?," + "to_date(?, 'YYYYMMDD'), " + "?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, sex);
			pstmt.setString(5, im_birthday);
			pstmt.setString(6, img);

			if (pstmt.executeUpdate() == 1) {
				request.setAttribute("r", "회원 가입 성공");
			} else {
				request.setAttribute("r", "회원 가입 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "회원 가입 실패");
		} finally {
			DBManager.close(con, pstmt, null);
		}
	}

	public boolean login(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DBManager.connect();

			String im_id = request.getParameter("im_id");
			String im_pw = request.getParameter("im_pw");

			String sql = "select * from ihwac_member " + "where im_id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, im_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String db_pw = rs.getString("im_pw");

				if (im_pw.equals(db_pw)) {
					Cookie lastLoginID = new Cookie("lastLoginID", im_id);
					lastLoginID.setMaxAge(86400);
					response.addCookie(lastLoginID);

					Member m = new Member();
					m.setIm_id(im_id);
					m.setIm_pw(im_pw);
					m.setIm_name(rs.getString("im_name"));
					m.setIm_addr(rs.getString("im_addr"));
					m.setIm_birthday(rs.getDate("im_birthday"));
					m.setIm_img(rs.getString("im_img"));

					HttpSession hs = request.getSession();
					hs.setAttribute("loginMember", m);
					hs.setMaxInactiveInterval(15 * 60); //

					// 로그인 상태 유지 체크했으면
					if (request.getParameter("im_autologin") != null) {
						Cookie autoLoginID = new Cookie("ihwacAutoLoginID", im_id);
						autoLoginID.setMaxAge(86400);
						response.addCookie(autoLoginID);
					}
					return true;
				} else {
					request.setAttribute("r", "비밀번호 오류");
					return false;
				}

			} else {
				request.setAttribute("r", "그런 계정 없음");
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "DB 서버 문제");
			return false;
		} finally {
			DBManager.close(con, pstmt, rs);
			
		}

	}

	public boolean loginCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession hs = request.getSession();
		Member m = (Member) hs.getAttribute("loginMember");

		if (m != null) {
			//request.setAttribute("loginPage", "member/loginOK.jsp");

			return true;
		}
		//request.setAttribute("loginPage", "member/login.jsp");
		return false;

	}

	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession hs = request.getSession();
		// hs.invalidate();
		hs.setAttribute("loginMember", null);

		Cookie[] allCookie = request.getCookies();

		for (Cookie cookie : allCookie) {
			// 애초에 로그인할때 체크해서 로그인 했었으면
			if (cookie.getName().equals("ihwacAutoLoginID")) {
				// 거기 들어있을 id 지우기
				cookie.setValue(null);
				response.addCookie(cookie);
			}
		}

	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBManager.connect();

			String path = request.getServletContext().getRealPath("etc");

			MultipartRequest mr = new MultipartRequest(request, path, 31457280, "euc-kr",
					new DefaultFileRenamePolicy());

			String im_id = mr.getParameter("im_id");
			String im_pw = mr.getParameter("im_pw");
			// String im_pwChk = mr.getParameter("im_pwChk");
			String im_name = mr.getParameter("im_name");
			String im_addr = mr.getParameter("im_addr");
			String im_y = mr.getParameter("im_y"); // "1982"
			String im_m = mr.getParameter("im_m"); // "1"
			int im_m2 = Integer.parseInt(im_m); // 1
			String im_d = mr.getParameter("im_d"); // "2"
			int im_d2 = Integer.parseInt(im_d); // 2

			String im_birthday = String.format("%s%02d%02d", im_y, im_m2, im_d2);
			// 19820102

			HttpSession hs = request.getSession();
			Member m2 = (Member) hs.getAttribute("loginMember");

			String im_img = mr.getFilesystemName("im_img");
			if (im_img != null) {
//				im_img = URLEncoder.encode(im_img, "euc-kr");
//				im_img = im_img.replace("+", " ");

				// 이전 파일 지우기
				String oldImg = m2.getIm_img();
//				oldImg = URLDecoder.decode(oldImg, "euc-kr");
				File oldFile = new File(path + "/" + oldImg);
				oldFile.delete();

			} else {
				im_img = m2.getIm_img();
			}
			String sql = "update ihwac_member " + "set im_pw=?, im_name=?, " + "im_addr=?, im_img=?, "
					+ "im_birthday=to_date(?, 'YYYYMMDD') " + "where im_id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(6, im_id);
			pstmt.setString(1, im_pw);
			pstmt.setString(2, im_name);
			pstmt.setString(3, im_addr);
			pstmt.setString(5, im_birthday);
			pstmt.setString(4, im_img);

			if (pstmt.executeUpdate() == 1) {
				Member m = new Member();
				m.setIm_id(im_id);
				m.setIm_pw(im_pw);
				m.setIm_name(im_name);
				m.setIm_addr(im_addr);
				m.setIm_img(im_img);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				m.setIm_birthday(sdf.parse(im_birthday));

				// HttpSession hs = request.getSession();
				hs.setAttribute("loginMember", m);

				request.setAttribute("r", "회원 정보 수정 성공");
			} else {
				request.setAttribute("r", "회원 정보 수정 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "회원 정보 수정 실패");
		} finally {
			DBManager.close(con, pstmt, null);
		}
	}

}
