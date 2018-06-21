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
public class Member_Search_SetAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		Map<String,String[]> map = request.getParameterMap();
		String dat = request.getParameter("dat");
		String table = ReadXml.getKeys("usedTable11");
		try {
			Map<String, Object> dats = new HashMap<String, Object>();
			for (String key : map.keySet()) {
				if(!map.get(key)[0].equals(dat))
					dats.put(key, map.get(key)[0]);
			}
			String value = "";
			boolean result = false;
			value = Main_DAO.getDAO().SearchData(dats, table, dat);
			if(!value.equals("none")){
				Map<String, Object> dats2 = new HashMap<String, Object>();
				dats2.put(ReadXml.getKeys("User_Condition3"), "0000");
				dats2.put(ReadXml.getKeys("User_Condition4"), dats.get(ReadXml.getKeys("User_Condition4")));
				result = Main_DAO.getDAO().ModifyCommand(dats2, table,ReadXml.getKeys("User_Condition4"));
			}
			response.setContentType("application/json");
			response.getWriter().write(new Gson().toJson(result));
			return null;
		} catch (Exception e) {
			System.out.println("Member_SearchAction err : "+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}