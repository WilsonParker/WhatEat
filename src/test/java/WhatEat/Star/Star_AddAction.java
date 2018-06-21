package WhatEat.Star;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

@Star_Path()
public class Star_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			int stat = 0;
			boolean result = false;
			if (user != null) {
				int snum = Integer.parseInt(request.getParameter("snum"));
				HashMap<String, Object> whe = new HashMap<String, Object>();
				whe.put(ReadXml.getKeys("Star_Condition3"), snum);
				List<Object> list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean10"), whe, null, 0, 0);
				if (list.size() <= 0) {
					stat = 1;
					result = Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(request, new STAR_Bean()));
					if (result == false) {
						stat = 3;
					}
				} else {
					stat = 2;
				}
			} else {
				stat = 4;
			}
			response.setContentType("application/json");
			response.getWriter().write(new Gson().toJson(stat));
		} catch (Exception e) {
			System.out.println("Star_AddAction err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
