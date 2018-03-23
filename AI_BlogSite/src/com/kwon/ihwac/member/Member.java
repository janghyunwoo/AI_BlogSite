package com.kwon.ihwac.member;

import java.util.Date;

public class Member {
	private String im_id;
	private String im_pw;
	private String im_name;
	private String im_addr;
	private Date im_birthday;
	private String im_img;

	public Member() {
		// TODO Auto-generated constructor stub
	}

	public Member(String im_id, String im_pw, String im_name, String im_addr, Date im_birthday, String im_img) {
		super();
		this.im_id = im_id;
		this.im_pw = im_pw;
		this.im_name = im_name;
		this.im_addr = im_addr;
		this.im_birthday = im_birthday;
		this.im_img = im_img;
	}

	public String getIm_id() {
		return im_id;
	}

	public void setIm_id(String im_id) {
		this.im_id = im_id;
	}

	public String getIm_pw() {
		return im_pw;
	}

	public void setIm_pw(String im_pw) {
		this.im_pw = im_pw;
	}

	public String getIm_name() {
		return im_name;
	}

	public void setIm_name(String im_name) {
		this.im_name = im_name;
	}

	public String getIm_addr() {
		return im_addr;
	}

	public void setIm_addr(String im_addr) {
		this.im_addr = im_addr;
	}

	public Date getIm_birthday() {
		return im_birthday;
	}

	public void setIm_birthday(Date im_birthday) {
		this.im_birthday = im_birthday;
	}

	public String getIm_img() {
		return im_img;
	}

	public void setIm_img(String im_img) {
		this.im_img = im_img;
	}

}
