package WhatEat.Data_source;

import java.sql.Date;

public interface USER {
	public void setINFO_INDEX(int n); 
	public void setINFO_ID(String s); 
	public void setINFO_PASSWORD(String s); 
	public void setINFO_PHONENUM(String s); 
	public void setINFO_NAME(String s); 
	public void setINFO_MILEAGE(int n); 
	public void setINFO_DONATION(int s); 
	public void setINFO_EMAIL(String s); 
	public void setINFO_JOINDATE(Date d); 
	public void setINFO_PERMIT(String s); 
	public void setINFO_BIRTH(String s); 
	public void setINFO_GRADE(int i); 
	public void setINFO_POSITION(String s); 
	public void setINFO_ADDBOARD_RG(String s);
	public void setINFO_DELBOARD_RG(String s);
	public void setINFO_MODBOARD_RG(String s);
	public void setINFO_ADDSTORE_RG(String s);
	public void setINFO_DELSTORE_RG(String s);
	public void setINFO_MODSTORE_RG(String s);
	public void setINFO_ADDCOMMENT_RG(String s);
	public void setINFO_DELCOMMENT_RG(String s);
	public void setINFO_MODCOMMENT_RG(String s);
	public void setINFO_MODINFO_RG(String s);
	public int getINFO_INDEX(); 
	public String getINFO_ID(); 
	public String getINFO_PASSWORD(); 
	public String getINFO_PHONENUM(); 
	public String getINFO_NAME(); 
	public int getINFO_MILEAGE(); 
	public int getINFO_DONATION(); 
	public String getINFO_EMAIL(); 
	public Date getINFO_JOINDATE(); 
	public String getINFO_PERMIT(); 
	public String getINFO_BIRTH(); 
	public int getINFO_GRADE(); 
	public String getINFO_POSITION(); 
	public String getINFO_ADDBOARD_RG();
	public String getINFO_DELBOARD_RG();
	public String getINFO_MODBOARD_RG();
	public String getINFO_ADDSTORE_RG();
	public String getINFO_DELSTORE_RG();
	public String getINFO_MODSTORE_RG();
	public String getINFO_ADDCOMMENT_RG();
	public String getINFO_DELCOMMENT_RG();
	public String getINFO_MODCOMMENT_RG();
	public String getINFO_MODINFO_RG();
}
		

