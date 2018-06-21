package WhatEat.Food;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;


@Food_Path()
public class Food_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		Main_DAO dao = Main_DAO.getDAO();
		int index = Integer.parseInt(request.getParameter("index"));
		List<Object> food = new ArrayList<Object>();
		List<Object> mdata= new ArrayList<Object>();
		List<Object> menu= new ArrayList<Object>();
		
		HashMap<String,Object> whe = new HashMap<String, Object>();
		whe.put(ReadXml.getKeys("Food_Condition4"), index);
		HashMap<String,Object> whe2 = new HashMap<String, Object>();
		mdata = dao.ListCommand(ReadXml.getKeys("Bean3"),whe,null,0, 0);
		int Mnum=0;
		int Mindex=0;
		String Mname="";
		for(int c=0;c<mdata.size();c++){
			MENU_Bean bean = new MENU_Bean();
			Mnum = ((MENU_Bean) mdata.get(c)).getMENU_NUM();
			Mindex = ((MENU_Bean) mdata.get(c)).getMENU_INDEX();
			Mname = ((MENU_Bean) mdata.get(c)).getMENU_NAME();
			whe2.put(ReadXml.getKeys("Food_Condition3"), Mnum);
			//System.out.println("food whe2 : "+whe2.get(ReadXml.getKeys("Food_Condition3")));
			//System.out.println("Mnum " + Mnum + " @@ Mindex " + Mindex + " @@ Mname " + Mname);
			food = dao.ListCommand(ReadXml.getKeys("Bean4"),whe2,null,0, 0);
			bean.setMENU_INDEX(Mindex);
			bean.setMENU_NUM(Mnum);
			bean.setMENU_NAME(Mname);
			for(int a=0;a<food.size();a++){
				//System.out.println("Food " + ((FOOD_Bean) food.get(a)).getFOOD_NAME());
				bean.addFOOD((FOOD_Bean)food.get(a));
				//System.out.println(((FOOD_Bean) food.get(a)).getFOOD_NAME());
			}
			menu.add(bean);
		}
		request.setAttribute("flist", menu);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_FoodPath2") + "Table.jsp");
		return forward;
	}
}

