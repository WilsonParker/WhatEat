package WhatEat.Board;

import java.sql.Date;

@Board_Path()
public class BOARD_Bean {

	private int BOARD_INDEX;
	private int BOARD_NUM;
	private int BOARD_SEQUENCE;
	private int BOARD_KIND;
	private int BOARD_COMMENTTOTAL;
	//private int BOARD_REVIEWER;
	//private int BOARD_SCORE;
	private String BOARD_WRITER;
	private String BOARD_SUBJECT;
	private String BOARD_CONTENT;
	private String BOARD_FILE;
	private String BOARD_PATH;
	private int BOARD_READCOUNT;
	private Date BOARD_DATE;
	public int getBOARD_INDEX() {
		return BOARD_INDEX;
	}
	public void setBOARD_INDEX(int bOARD_INDEX) {
		BOARD_INDEX = bOARD_INDEX;
	}
	public int getBOARD_NUM() {
		return BOARD_NUM;
	}
	public void setBOARD_NUM(int bOARD_NUM) {
		BOARD_NUM = bOARD_NUM;
	}
	public int getBOARD_SEQUENCE() {
		return BOARD_SEQUENCE;
	}
	public void setBOARD_SEQUENCE(int bOARD_SEQUENCE) {
		BOARD_SEQUENCE = bOARD_SEQUENCE;
	}
	public int getBOARD_KIND() {
		return BOARD_KIND;
	}
	public void setBOARD_KIND(int bOARD_KIND) {
		BOARD_KIND = bOARD_KIND;
	}
	public int getBOARD_COMMENTTOTAL() {
		return BOARD_COMMENTTOTAL;
	}
	public void setBOARD_COMMENTTOTAL(int bOARD_COMMENTTOTAL) {
		BOARD_COMMENTTOTAL = bOARD_COMMENTTOTAL;
	}
	public String getBOARD_WRITER() {
		return BOARD_WRITER;
	}
	public void setBOARD_WRITER(String bOARD_WRITER) {
		BOARD_WRITER = bOARD_WRITER;
	}
	public String getBOARD_SUBJECT() {
		return BOARD_SUBJECT;
	}
	public void setBOARD_SUBJECT(String bOARD_SUBJECT) {
		BOARD_SUBJECT = bOARD_SUBJECT;
	}
	public String getBOARD_CONTENT() {
		return BOARD_CONTENT;
	}
	public void setBOARD_CONTENT(String bOARD_CONTENT) {
		BOARD_CONTENT = bOARD_CONTENT;
	}
	public String getBOARD_FILE() {
		return BOARD_FILE;
	}
	public void setBOARD_FILE(String bOARD_FILE) {
		BOARD_FILE = bOARD_FILE;
	}
	public String getBOARD_PATH() {
		return BOARD_PATH;
	}
	public void setBOARD_PATH(String bOARD_PATH) {
		BOARD_PATH = bOARD_PATH;
	}
	public int getBOARD_READCOUNT() {
		return BOARD_READCOUNT;
	}
	public void setBOARD_READCOUNT(int bOARD_READCOUNT) {
		BOARD_READCOUNT = bOARD_READCOUNT;
	}
	public Date getBOARD_DATE() {
		return BOARD_DATE;
	}
	public void setBOARD_DATE(Date bOARD_DATE) {
		BOARD_DATE = bOARD_DATE;
	}

	
}
