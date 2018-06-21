package WhatEat.Member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;

@Member_Path()
public class Member_SearchAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String[]> map = request.getParameterMap();
		String dat = request.getParameter("dat");
		String table = ReadXml.getKeys("usedTable11");
		try {
			request.setCharacterEncoding("utf-8");
			Map<String, Object> dats = new HashMap<String, Object>();
			for (String key : map.keySet()) {
				if(!map.get(key)[0].equals(dat))
					dats.put(key, map.get(key)[0]);
			}
			String value = "";
			value = Main_DAO.getDAO().SearchData(dats, table, dat);
			response.setContentType("application/json");
			response.getWriter().write(new Gson().toJson(value));
			return null;
		} catch (Exception e) {
			System.out.println("Member_SearchAction err : "+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}