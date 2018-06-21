package WhatEat.Admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_LoginHelper implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String position = "";
		HttpSession session = request.getSession();
		switch(request.getParameter("Gposition")){
			case "member" :
				position = ReadXml.getKeys("position_member");
				break;
			case "seller" :
				position = ReadXml.getKeys("position_seller");
				break;
			case "admin" :
				position = ReadXml.getKeys("position_admin");
				break;
		}
		String result = Main_DAO.getDAO().getGInfo(position, session); 
		response.setContentType("application/json");
		response.getWriter().write(new Gson().toJson(result));
		return null;
	}
	
}
