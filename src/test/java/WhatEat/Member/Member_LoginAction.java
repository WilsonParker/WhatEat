package WhatEat.Member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;

@Member_Path()
public class Member_LoginAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		int result = Main_DAO.getDAO().LoginCommand(request.getParameter("INFO_ID"), request.getParameter("INFO_PASSWORD"), session);
		response.setContentType("application/json");
		response.getWriter().write(new Gson().toJson(result));
		return null;
	}
}