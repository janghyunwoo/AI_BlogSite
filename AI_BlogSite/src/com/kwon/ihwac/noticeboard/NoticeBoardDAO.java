package com.kwon.ihwac.noticeboard;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kwon.ihwac.main.DBManager;
import com.kwon.ihwac.member.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NoticeBoardDAO {
	private static final NoticeBoardDAO MDAO = new NoticeBoardDAO();
	private ArrayList<NoticeBoard> NoticeBoards;
	
	public static NoticeBoardDAO getMdao() {
		return MDAO;
	}

	private NoticeBoardDAO() {
		// TODO Auto-generated constructor stub
	}


	public void insertWriteText(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBManager.connect();

			HttpSession hs = request.getSession();
			Member m = (Member) hs.getAttribute("loginMember");
			
			String id = m.getIm_id();
			String title = request.getParameter("titleArea");
			String txt = request.getParameter("textArea");
			txt = txt.replace("\n", "<br>");
			
			String sql = "insert into sns " + "values(sns_seq.nextval, " + "?, ?, ?, sysdate)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, title);
			pstmt.setString(3, txt);

			
			if (pstmt.executeUpdate() == 1) {
				System.out.println("등록성공");
				request.setAttribute("r", "게시글 등록 성공");
			} else {
				request.setAttribute("r", "게시글 등록 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("r", "게시글 등록 실패");
		} finally {
			DBManager.close(con, pstmt, null);
		}
	}

	public void getAllNoticeBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DBManager.connect();

			// 원하는것의 반대 순서로
			String sql = "select * from sns " + "order by write_date";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			NoticeBoards = new ArrayList<>();
			NoticeBoard c = null;
			
			while (rs.next()) {
				c = new NoticeBoard();
				c.setNum(rs.getInt("num"));
				c.setOwner(rs.getString("owner"));
				c.setTitle(rs.getString("title"));
				c.setTxt(rs.getString("txt"));
				String formetDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("write_date"));
				c.setWrite_date(formetDate);
				NoticeBoards.add(c);
			}
			
			
			if (NoticeBoards.size() == 0) {
				request.setAttribute("r", "아무 데이터 없음");

				NoticeBoards.clear();
				/*NoticeBoards.add(null);
				NoticeBoards.add(null);
				NoticeBoards.add(null);*/
			}
			
			ObjectMapper mapper = new ObjectMapper();
			
			 HashMap<String,Object> map=new HashMap<String,Object>();
			 map.put("NoticeBoards",NoticeBoards);
			 map.put("resert","등록 성공");

			 JSONObject jsonObject= new JSONObject();

			 jsonObject.putAll(map);
			

			 try {
					response.getWriter().print(mapper.writeValueAsString(jsonObject));
				} catch (Exception e) {
					// TODO: handle exception
				}

			// request.setAttribute("comments", comments);

		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("r", "DB서버오류");

			NoticeBoards.clear();
			
			/*NoticeBoards = new ArrayList<>();
			NoticeBoards.add(null);
			NoticeBoards.add(null);
			NoticeBoards.add(null);*/
			// request.setAttribute("comments", comments);

		} finally {
			DBManager.close(con, pstmt, rs);
		}
	}

	

}
