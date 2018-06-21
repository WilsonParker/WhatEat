package WhatEat.Member;

import java.sql.Date;

import WhatEat.Data_source.USER;

@Member_Path()
public class MEMBER_Bean implements USER{
	private int INFO_INDEX;
	private String INFO_PHONENUM;
	private String INFO_ID;
	private String INFO_PASSWORD;
	private String INFO_BIRTH;
	private String INFO_NAME;
	private int INFO_MILEAGE;
	private String INFO_EMAIL;
	private int INFO_GRADE;
	private Date INFO_JOINDATE;
	private String INFO_POSITION;
	private String INFO_ADDBOARD_RG;
	private String INFO_DELBOARD_RG;
	private String INFO_MODBOARD_RG;
	private String INFO_ADDCOMMENT_RG;
	private String INFO_DELCOMMENT_RG;
	private String INFO_MODCOMMENT_RG;
	private String INFO_MODINFO_RG;
	
	public int getINFO_INDEX() {
		return INFO_INDEX;
	}
	public void setINFO_INDEX(int iNFO_INDEX) {
		INFO_INDEX = iNFO_INDEX;
	}
	public String getINFO_PHONENUM() {
		return INFO_PHONENUM;
	}
	public void setINFO_PHONENUM(String iNFO_PHONENUM) {
		INFO_PHONENUM = iNFO_PHONENUM;
	}
	public String getINFO_ID() {
		return INFO_ID;
	}
	public void setINFO_ID(String iNFO_ID) {
		INFO_ID = iNFO_ID;
	}
	public String getINFO_PASSWORD() {
		return INFO_PASSWORD;
	}
	public void setINFO_PASSWORD(String iNFO_PASSWORD) {
		INFO_PASSWORD = iNFO_PASSWORD;
	}
	public String getINFO_BIRTH() {
		return INFO_BIRTH;
	}
	public void setINFO_BIRTH(String iNFO_BIRTH) {
		INFO_BIRTH = iNFO_BIRTH;
	}
	public String getINFO_NAME() {
		return INFO_NAME;
	}
	public void setINFO_NAME(String iNFO_NAME) {
		INFO_NAME = iNFO_NAME;
	}
	public int getINFO_MILEAGE() {
		return INFO_MILEAGE;
	}
	public void setINFO_MILEAGE(int iNFO_MILEAGE) {
		INFO_MILEAGE = iNFO_MILEAGE;
	}
	public String getINFO_EMAIL() {
		return INFO_EMAIL;
	}
	public void setINFO_EMAIL(String iNFO_EMAIL) {
		INFO_EMAIL = iNFO_EMAIL;
	}
	public int getINFO_GRADE() {
		return INFO_GRADE;
	}
	public void setINFO_GRADE(int iNFO_GRADE) {
		INFO_GRADE = iNFO_GRADE;
	}
	public Date getINFO_JOINDATE() {
		return INFO_JOINDATE;
	}
	public void setINFO_JOINDATE(Date iNFO_JOINDATE) {
		INFO_JOINDATE = iNFO_JOINDATE;
	}
	public String getINFO_POSITION() {
		return INFO_POSITION;
	}
	public void setINFO_POSITION(String iNFO_POSITION) {
		INFO_POSITION = iNFO_POSITION;
	}
	public String getINFO_ADDBOARD_RG() {
		return INFO_ADDBOARD_RG;
	}
	public void setINFO_ADDBOARD_RG(String iNFO_ADDBOARD_RG) {
		INFO_ADDBOARD_RG = iNFO_ADDBOARD_RG;
	}
	public String getINFO_DELBOARD_RG() {
		return INFO_DELBOARD_RG;
	}
	public void setINFO_DELBOARD_RG(String iNFO_DELBOARD_RG) {
		INFO_DELBOARD_RG = iNFO_DELBOARD_RG;
	}
	public String getINFO_MODBOARD_RG() {
		return INFO_MODBOARD_RG;
	}
	public void setINFO_MODBOARD_RG(String iNFO_MODBOARD_RG) {
		INFO_MODBOARD_RG = iNFO_MODBOARD_RG;
	}
	public String getINFO_ADDCOMMENT_RG() {
		return INFO_ADDCOMMENT_RG;
	}
	public void setINFO_ADDCOMMENT_RG(String iNFO_ADDCOMMENT_RG) {
		INFO_ADDCOMMENT_RG = iNFO_ADDCOMMENT_RG;
	}
	public String getINFO_DELCOMMENT_RG() {
		return INFO_DELCOMMENT_RG;
	}
	public void setINFO_DELCOMMENT_RG(String iNFO_DELCOMMENT_RG) {
		INFO_DELCOMMENT_RG = iNFO_DELCOMMENT_RG;
	}
	public String getINFO_MODCOMMENT_RG() {
		return INFO_MODCOMMENT_RG;
	}
	public void setINFO_MODCOMMENT_RG(String iNFO_MODCOMMENT_RG) {
		INFO_MODCOMMENT_RG = iNFO_MODCOMMENT_RG;
	}
	public String getINFO_MODINFO_RG() {
		return INFO_MODINFO_RG;
	}
	public void setINFO_MODINFO_RG(String iNFO_MODINFO_RG) {
		INFO_MODINFO_RG = iNFO_MODINFO_RG;
	}
	@Override
	public void setINFO_DONATION(int s) {
	}
	@Override
	public void setINFO_PERMIT(String s) {
	}
	@Override
	public void setINFO_ADDSTORE_RG(String s) {
	}
	@Override
	public void setINFO_DELSTORE_RG(String s) {
	}
	@Override
	public void setINFO_MODSTORE_RG(String s) {
	}
	@Override
	public int getINFO_DONATION() {
		return 0;
	}
	@Override
	public String getINFO_PERMIT() {
		return null;
	}
	@Override
	public String getINFO_ADDSTORE_RG() {
		return null;
	}
	@Override
	public String getINFO_DELSTORE_RG() {
		return null;
	}
	@Override
	public String getINFO_MODSTORE_RG() {
		return null;
	}	
}
