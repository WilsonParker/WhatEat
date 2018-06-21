package WhatEat.Store;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;

@Store_Path()
public class Store_LocationAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String location1 = request.getParameter("LOCATION1")!=null?request.getParameter("LOCATION1"):"";
		String location2 = request.getParameter("LOCATION2")!=null?request.getParameter("LOCATION2"):"";
		String location3 = request.getParameter("LOCATION3")!=null?request.getParameter("LOCATION3"):"";
		location1 = location1.trim().equals("")?"":location1;
		location2 = location2.trim().equals("")?"":location2;
		location3 = location3.trim().equals("")?"":location3;
		session.setAttribute("LOCATION1", location1);
		session.setAttribute("LOCATION2", location2);
		session.setAttribute("LOCATION3", location3);
		response.setContentType("application/json");
		if(session.getAttribute("LOCATION3")!=null)
			response.getWriter().write(new Gson().toJson(true));
		else
			response.getWriter().write(new Gson().toJson(false));
		return null;
	}
}