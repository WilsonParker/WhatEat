package WhatEat.Board;

import java.sql.Date;

@Board_Path()
public class COMMENTS_Bean {
	private int COMMENTS_INDEX;
	private int COMMENTS_NUM;
	private int COMMENTS_KIND_BOARD;
	private int COMMENTS_KIND_STORE;
	private String COMMENTS_CONTENT;
	private String COMMENTS_WRITER;
	private int COMMENTS_SCORE;
	private Date COMMENTS_DATE;
	private int COMMENTS_SUBNUM;
	private int COMMENTS_SUBTOTAL;
	
	public int getCOMMENTS_INDEX() {
		return COMMENTS_INDEX;
	}
	public void setCOMMENTS_INDEX(int cOMMENTS_INDEX) {
		COMMENTS_INDEX = cOMMENTS_INDEX;
	}
	public int getCOMMENTS_NUM() {
		return COMMENTS_NUM;
	}
	public void setCOMMENTS_NUM(int cOMMENTS_NUM) {
		COMMENTS_NUM = cOMMENTS_NUM;
	}
	public int getCOMMENTS_KIND_BOARD() {
		return COMMENTS_KIND_BOARD;
	}
	public void setCOMMENTS_KIND_BOARD(int cOMMENTS_KIND_BOARD) {
		COMMENTS_KIND_BOARD = cOMMENTS_KIND_BOARD;
	}
	public int getCOMMENTS_KIND_STORE() {
		return COMMENTS_KIND_STORE;
	}
	public void setCOMMENTS_KIND_STORE(int cOMMENTS_KIND_STORE) {
		COMMENTS_KIND_STORE = cOMMENTS_KIND_STORE;
	}
	public String getCOMMENTS_CONTENT() {
		return COMMENTS_CONTENT;
	}
	public void setCOMMENTS_CONTENT(String cOMMENTS_CONTENT) {
		COMMENTS_CONTENT = cOMMENTS_CONTENT;
	}
	public String getCOMMENTS_WRITER() {
		return COMMENTS_WRITER;
	}
	public void setCOMMENTS_WRITER(String cOMMENTS_WRITER) {
		COMMENTS_WRITER = cOMMENTS_WRITER;
	}
	public int getCOMMENTS_SCORE() {
		return COMMENTS_SCORE;
	}
	public void setCOMMENTS_SCORE(int cOMMENTS_SCORE) {
		COMMENTS_SCORE = cOMMENTS_SCORE;
	}
	public Date getCOMMENTS_DATE() {
		return COMMENTS_DATE;
	}
	public void setCOMMENTS_DATE(Date cOMMENTS_DATE) {
		COMMENTS_DATE = cOMMENTS_DATE;
	}
	public int getCOMMENTS_SUBNUM() {
		return COMMENTS_SUBNUM;
	}
	public void setCOMMENTS_SUBNUM(int cOMMENTS_SUBNUM) {
		COMMENTS_SUBNUM = cOMMENTS_SUBNUM;
	}
	public int getCOMMENTS_SUBTOTAL() {
		return COMMENTS_SUBTOTAL;
	}
	public void setCOMMENTS_SUBTOTAL(int cOMMENTS_SUBTOTAL) {
		COMMENTS_SUBTOTAL = cOMMENTS_SUBTOTAL;
	}
		
	
}
