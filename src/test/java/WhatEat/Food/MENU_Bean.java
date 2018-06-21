package WhatEat.Food;

import java.util.ArrayList;
import java.util.List;

@Food_Path()
public class MENU_Bean {
	
	private int MENU_INDEX;
	private int MENU_NUM;
	private String MENU_NAME;
	private ArrayList<Object> FOOD = new ArrayList<Object>();
	
	public int getMENU_INDEX() {
		return MENU_INDEX;
	}
	public void setMENU_INDEX(int mENU_INDEX) {
		MENU_INDEX = mENU_INDEX;
	}
	public int getMENU_NUM() {
		return MENU_NUM;
	}
	public void setMENU_NUM(int mENU_NUM) {
		MENU_NUM = mENU_NUM;
	}
	public String getMENU_NAME() {
		return MENU_NAME;
	}
	public void setMENU_NAME(String mENU_NAME) {
		MENU_NAME = mENU_NAME;
	}
	public List<Object> outFOOD() {
		return FOOD;
	}
	public void addFOOD(Object obj) {
		FOOD.add(obj);
	}
	
}
