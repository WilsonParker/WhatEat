package WhatEat.Member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.Method_Shorten;

@Member_Path()
public class Member_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response){
		try{
		request.setCharacterEncoding("utf-8");
		boolean result = false;
		USER user = new MEMBER_Bean();
		user.setINFO_PHONENUM(request.getParameter("INFO_PHONENUM1")+"-"+request.getParameter("INFO_PHONENUM2")+"-"+request.getParameter("INFO_PHONENUM3"));
		result = Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(request, user));
		response.setContentType("application/json");
		response.getWriter().write(new Gson().toJson(result));
		}
		catch(Exception e){
			System.out.println("Member_AddAction err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}