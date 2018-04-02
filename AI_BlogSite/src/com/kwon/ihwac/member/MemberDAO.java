package com.kwon.ihwac.member;

import java.io.File;
import java.io.UnsupportedEncodingException;
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
				// ihwacAutoLoginID�̶�� �̸��� ��Ű�� ������
				if (cookie.getName().equals("ihwacAutoLoginID")) {
					// ��Ű�� ����ִ� ���� ������
					if (cookie.getValue() != null) {

						Connection con = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						try {
							con = DBManager.connect();

							String im_id = cookie.getValue();

							String sql = "select * from member " + "where id=?";

							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, im_id);

							rs = pstmt.executeQuery();

							if (rs.next()) {
								String db_pw = rs.getString("pw");

								// ctrl + shift + f
								Cookie lastLoginID = new Cookie("lastLoginID", im_id);
								lastLoginID.setMaxAge(86400);
								response.addCookie(lastLoginID);

								Member m = new Member();
								m.setIm_id(im_id);
								m.setIm_pw(db_pw);
								m.setIm_name(rs.getString("name"));
								m.setIm_addr(rs.getString("sex"));
								m.setIm_birthday(rs.getDate("birthday"));
								m.setIm_img(rs.getString("img"));

								HttpSession hs = request.getSession();
								hs.setAttribute("loginMember", m);
								hs.setMaxInactiveInterval(15 * 60); //

								Cookie autoLoginID = new Cookie("ihwacAutoLoginID", im_id);
								autoLoginID.setMaxAge(86400);
								response.addCookie(autoLoginID);
								
							} else {
								request.setAttribute("r", "�׷� ���� ����");
							}

						} catch (Exception e) {
							e.printStackTrace();
							request.setAttribute("r", "DB ���� ����");
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

					request.setAttribute("r", "ȸ�� Ż�� ����");
				} else {
					request.setAttribute("r", "ȸ�� Ż�� ����");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "ȸ�� Ż�� ����");
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
			if(sex.equals("m")) {
				sex = "��";
			}else {
				sex = "��";
			}
			
			String im_y = mr.getParameter("im_y"); // "1982"
			String im_m = mr.getParameter("im_m"); // "1"
			int im_m2 = Integer.parseInt(im_m); // 1
			String im_d = mr.getParameter("im_d"); // "2"
			int im_d2 = Integer.parseInt(im_d); // 2

			String birthday = String.format("%s%02d%02d", im_y, im_m2, im_d2);
			// 19820102

			String img = mr.getFilesystemName("img");
//			im_img = URLEncoder.encode(im_img, "euc-kr");
//			im_img = im_img.replace("+", " ");

			String sql = "insert into member values(" + "?, ?, ?, ?," + "to_date(?, 'YYYYMMDD'), " + "?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, sex);
			pstmt.setString(5, birthday);
			pstmt.setString(6, img);

			if (pstmt.executeUpdate() == 1) {
				request.setAttribute("r", "ȸ�� ���� ����");
			} else {
				request.setAttribute("r", "ȸ�� ���� ����");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "ȸ�� ���� ����");
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

			String sql = "select * from member " + "where id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, im_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String pw = rs.getString("pw");

				if (im_pw.equals(pw)) {
					//���������� �α����� ������ ����
					
					Cookie lastLoginID = new Cookie("lastLoginID", im_id);
					lastLoginID.setMaxAge(86400);
					response.addCookie(lastLoginID);

					
					Member m = new Member();
					m.setIm_id(im_id);
					m.setIm_pw(im_pw);
					m.setIm_name(rs.getString("name"));
					m.setIm_addr(rs.getString("sex"));
					m.setIm_birthday(rs.getDate("birthday"));
					m.setIm_img(rs.getString("img"));
					
					String img = URLEncoder.encode(m.getIm_img(), "utf-8"); // %2A+%2A.png
					img = "etc/"+img;
					img = img.replace("+", " "); // %2A %2A.png
					Cookie lastLoginPicture = new Cookie("lastLoginPicture", img );
					lastLoginPicture.setMaxAge(86400);
					response.addCookie(lastLoginPicture);
					
					
					HttpSession hs = request.getSession();
					hs.setAttribute("loginMember", m);
					hs.setMaxInactiveInterval(15 * 60); //

					
					// �α��� ���� ���� üũ������
					if (request.getParameter("im_autologin") != null) {
						Cookie autoLoginID = new Cookie("ihwacAutoLoginID", im_id);
						autoLoginID.setMaxAge(86400);
						response.addCookie(autoLoginID);
					}
					return true;
				} else {
					request.setAttribute("r", "��й�ȣ ����");
					return false;
				}

			} else {
				request.setAttribute("r", "�׷� ���� ����");
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "DB ���� ����");
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
			request.setAttribute("member", m);
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
			// ���ʿ� �α����Ҷ� üũ�ؼ� �α��� �߾�����
			if (cookie.getName().equals("ihwacAutoLoginID")) {
				// �ű� ������� id �����
				cookie.setValue(null);
				response.addCookie(cookie);
			}
		}

	}
	// //ssl.gstatic.com/accounts/ui/avatar_2x.png
	// etc/jang.jpg
	public void defPicture(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		Cookie[] allCookie = request.getCookies();
		int count = 0;
		if (allCookie == null) {
			Cookie lastLoginPicture = new Cookie("lastLoginPicture", "//ssl.gstatic.com/accounts/ui/avatar_2x.png");
			lastLoginPicture.setMaxAge(86400);
			response.addCookie(lastLoginPicture);
			return;
		}
		for (Cookie cookie : allCookie) {
			// ���ʿ� �α����Ҷ� üũ�ؼ� �α��� �߾�����
			if (cookie.getName().equals("lastLoginPicture")) {
				// �ű� ������� id �����
				if (cookie.getValue() == null) {
					cookie.setValue("//ssl.gstatic.com/accounts/ui/avatar_2x.png");
					response.addCookie(cookie);
				}
			} else {
				// ��Ű�� lastLoginPicture�� ���� ��
				count++;
			}

			if (count == allCookie.length) {
				Cookie lastLoginPicture = new Cookie("lastLoginPicture", "//ssl.gstatic.com/accounts/ui/avatar_2x.png");
				lastLoginPicture.setMaxAge(86400);
				response.addCookie(lastLoginPicture);
			}

		}

	}

	public String update(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBManager.connect();

			String path = request.getServletContext().getRealPath("etc");

			MultipartRequest mr = new MultipartRequest(request, path, 31457280, "utf-8",
					new DefaultFileRenamePolicy());

			String im_pw = mr.getParameter("pw");
			// String im_pwChk = mr.getParameter("im_pwChk");
			String im_name = mr.getParameter("name");
			String sex = mr.getParameter("sex");
			String im_y = mr.getParameter("im_y"); // "1982"
			String im_m = mr.getParameter("im_m"); // "1"
			int im_m2 = Integer.parseInt(im_m); // 1
			String im_d = mr.getParameter("im_d"); // "2"
			int im_d2 = Integer.parseInt(im_d); // 2

			String im_birthday = String.format("%s%02d%02d", im_y, im_m2, im_d2);
			// 19820102

			HttpSession hs = request.getSession();
			Member m2 = (Member) hs.getAttribute("loginMember");

			String im_img = mr.getFilesystemName("img");
			if (im_img != null) {
//				im_img = URLEncoder.encode(im_img, "euc-kr");
//				im_img = im_img.replace("+", " ");

				// ���� ���� �����
				String oldImg = m2.getIm_img();
//				oldImg = URLDecoder.decode(oldImg, "euc-kr");
				File oldFile = new File(path + "/" + oldImg);
				oldFile.delete();

			} else {
				im_img = m2.getIm_img();
			}
			String sql = "update member " + "set pw=?, name=?, " + "sex=?, img=?, "
					+ "birthday=to_date(?, 'YYYYMMDD') " + "where id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(6, m2.getIm_id());
			pstmt.setString(1, im_pw);
			pstmt.setString(2, im_name);
			pstmt.setString(3, (sex.equals("m"))?"��":"��");
			pstmt.setString(5, im_birthday);
			pstmt.setString(4, im_img);

			if (pstmt.executeUpdate() == 1) {
				Member m = new Member();
				m.setIm_id(m2.getIm_id());
				m.setIm_pw(im_pw);
				m.setIm_name(im_name);
				m.setIm_addr((sex.equals("m"))?"��":"��");
				m.setIm_img(im_img);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				m.setIm_birthday(sdf.parse(im_birthday));

				// HttpSession hs = request.getSession();
				hs.setAttribute("loginMember", m);

				//����� �������� ���������� ������ ���̵��� ��Ű �� ����
				String img = URLEncoder.encode(im_img, "utf-8"); // %2A+%2A.png
				img = "etc/"+img;
				img = img.replace("+", " "); // %2A %2A.png
				Cookie lastLoginPicture = new Cookie("lastLoginPicture", img );
				lastLoginPicture.setMaxAge(86400);
				response.addCookie(lastLoginPicture);
				
				return "ȸ�� ���� ���� ����";
			} else {
				return "ȸ�� ���� ���� ����";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "ȸ�� ���� ���� ����";
		} finally {
			DBManager.close(con, pstmt, null);
		}
	}

	public String findID(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DBManager.connect();

			
			String name = request.getParameter("name");
			String y = request.getParameter("y"); // "1982"
			String m = request.getParameter("m"); // "1"
			int m2 = Integer.parseInt(m); // 1
			String d = request.getParameter("d"); // "2"
			int d2 = Integer.parseInt(d); // 2

			String birthday = String.format("%s%02d%02d", y, m2, d2);
			
			String sql = "select id from member " + "where name=? and birthday=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, birthday);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String id = rs.getString("id");
				return "ã�� ���̵�: "+id;
				

			} else {
				return "ã�� ���̵� ����";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "DB ����";
		} finally {
			DBManager.close(con, pstmt, null);
		}
		
	}
	
	public String findPW(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DBManager.connect();

			
			String id = request.getParameter("pw_id");
			String name = request.getParameter("pw_name"); // "1982"

			
			String sql = "select pw from member " + "where id=? and name=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String pw = rs.getString("pw");
				return "ã�� �н�����: "+pw;
				

			} else {
				return "�̸� �Ǵ� ���̵� �������� �ʽ��ϴ�.";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "DB ����";
		} finally {
			DBManager.close(con, pstmt, null);
		}
		
	}

}
