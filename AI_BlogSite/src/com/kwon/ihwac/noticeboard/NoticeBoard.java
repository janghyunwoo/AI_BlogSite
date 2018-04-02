package com.kwon.ihwac.noticeboard;

import java.util.Date;

public class NoticeBoard {
	private int num;
	private String owner;
	private String title;
	private String txt;
	private String write_date;

	public NoticeBoard() {
		// TODO Auto-generated constructor stub
	}
	
	public NoticeBoard(int num, String title, String owner, String txt, String write_date) {
		super();
		this.num = num;
		this.owner = owner;
		this.title = title;
		this.txt = txt;
		this.write_date = write_date;
	}


	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getTxt() {
		return txt;
	}

	public void setTxt(String txt) {
		this.txt = txt;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	
	
	
}
