package WhatEat.Admin;

@Admin_Path()
public class THEME_Bean {
	private int THEME_KIND;
	private String THEME_NAME;
	private String THEME_CHILDREN;
	
	public int getTHEME_KIND() {
		return THEME_KIND;
	}
	public void setTHEME_KIND(int tHEME_KIND) {
		THEME_KIND = tHEME_KIND;
	}
	public String getTHEME_NAME() {
		return THEME_NAME;
	}
	public void setTHEME_NAME(String tHEME_NAME) {
		THEME_NAME = tHEME_NAME;
	}
	public String getTHEME_CHILDREN() {
		return THEME_CHILDREN;
	}
	public void setTHEME_CHILDREN(String tHEME_CHILDREN) {
		THEME_CHILDREN = tHEME_CHILDREN;
	}
}
