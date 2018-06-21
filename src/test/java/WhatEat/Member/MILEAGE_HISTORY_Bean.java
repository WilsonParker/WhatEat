package WhatEat.Member;

import java.sql.Date;


@Member_Path
public class MILEAGE_HISTORY_Bean {

	private int MILEAGE_INDEX;
	private int MILEAGE_NUM;
	private int MILEAGE_STAT;
	private int MILEAGE_AMOUNT;
	private Date MILEAGE_DATE;
	public int getMILEAGE_INDEX() {
		return MILEAGE_INDEX;
	}
	public void setMILEAGE_INDEX(int mILEAGE_INDEX) {
		MILEAGE_INDEX = mILEAGE_INDEX;
	}
	public int getMILEAGE_NUM() {
		return MILEAGE_NUM;
	}
	public void setMILEAGE_NUM(int mILEAGE_NUM) {
		MILEAGE_NUM = mILEAGE_NUM;
	}
	public int getMILEAGE_AMOUNT() {
		return MILEAGE_AMOUNT;
	}
	public void setMILEAGE_AMOUNT(int mILEAGE_AMOUNT) {
		MILEAGE_AMOUNT = mILEAGE_AMOUNT;
	}
	public Date getMILEAGE_DATE() {
		return MILEAGE_DATE;
	}
	public void setMILEAGE_DATE(Date mILEAGE_DATE) {
		MILEAGE_DATE = mILEAGE_DATE;
	}
	public int getMILEAGE_STAT() {
		return MILEAGE_STAT;
	}
	public void setMILEAGE_STAT(int mILEAGE_STAT) {
		MILEAGE_STAT = mILEAGE_STAT;
	}
	
	

	
	
}
