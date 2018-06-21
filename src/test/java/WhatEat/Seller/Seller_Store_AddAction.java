package WhatEat.Seller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Food.FOOD_Bean;
import WhatEat.Food.MENU_Bean;
import WhatEat.Store.STORE_Bean;
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

@Seller_Path()
public class Seller_Store_AddAction implements Action {
	private ArrayList<String> mlist = null;
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = null;
		MultipartRequest multi = null;
		try {
			out = response.getWriter();
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			Main_DAO dao = Main_DAO.getDAO();
			if(user != null){
			if ((user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller")) && user.getINFO_ADDSTORE_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				String realFolder = "";
				File dir = new File(ReadXml.getKeys("upLoadRealPath") + ReadXml.getKeys("upLoadPath2"));
				if (!dir.exists())
					dir.mkdir();
				realFolder = dir.toString();
				boolean result = false;
				STORE_Bean bean = new STORE_Bean();
				multi = new MultipartRequest(request, realFolder, Integer.parseInt(ReadXml.getKeys("FileSize")) * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
				bean.setSTORE_PHONE(multi.getParameter("STORE_PHONE1") + "-" + multi.getParameter("STORE_PHONE2") + "-" + multi.getParameter("STORE_PHONE3"));
				bean.setSTORE_OPENTIME( multi.getParameter("STORE_OPENTIME1") + " : " + multi.getParameter("STORE_OPENTIME2"));
				bean.setSTORE_CLOSETIME( multi.getParameter("STORE_CLOSETIME1") + " : " + multi.getParameter("STORE_CLOSETIME2"));
				result = dao.InsertCommand(Method_Shorten.setterMethod(multi, bean));
				int storeNum = dao.getLastInsert();
				mlist = new ArrayList<String>();
				int max = getMaxNum(multi.getParameterNames(),ReadXml.getKeys("Food_Condition5"));
				int max2 = getMaxNum(multi.getParameterNames(),ReadXml.getKeys("Food_Condition6"));
				for(int c=mlist.size()-1;c>=0;c--){
					insertMenu(multi, dao, mlist.get(c),storeNum,max,max2);
				}
				if (result == false) {
					System.out.println("Fail to register the store");
					return null;
				}
				out.println("<script>");
				out.println("alert('가게 등록에 성공했습니다');");
				out.println("location.href='./Seller_Store_ListAction.co'");
				out.println("</script>");
				out.close();
				return null;
			} }else {
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
				out.println("location.href='./Home/View_Main.jsp'");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			System.out.println("Seller_Store_AddAction err : " + e.getMessage());
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('Seller_Store_AddAction err : '" + e.getMessage()+"');");
			out.println("location.href='./Home/View_Main.jsp'");
			out.println("</script>");
			out.close();
		}
		return null;
	}

	private void insertMenu(MultipartRequest multi, Main_DAO dao, String condition, int storeNum, int max,int max2) {
		String condition2 = "MDV_";
		String eleName = "";
		String mname = "";
		int menuNum = 0;
		boolean result = false;
		MENU_Bean menu = new MENU_Bean();
		Enumeration<?> en = multi.getParameterNames();
		while (en.hasMoreElements()) {
			eleName = (String) en.nextElement();
			//System.out.println("****************************** element : " + eleName);
			if (eleName.contains(condition)) {
				menu.setMENU_NAME(multi.getParameter(eleName));
				menu.setMENU_INDEX(storeNum);
				result = dao.InsertCommand(menu);
				mname = condition2+eleName.substring(eleName.lastIndexOf("_")+1);
				System.out.println("mname : " + mname);
				if (result == false) {
					System.out.println("Fail to register the menu");
				} else {
					System.out.println("Sucessfully register the menu");
					menuNum = dao.getLastInsert();
					insertFood(multi, dao, menuNum, mname,max2);
				}
			}
		}
	}

	private void insertFood(MultipartRequest multi, Main_DAO dao, int menuNum, String mname,int max2) {
		String eleName = "";
		String con1 =ReadXml.getKeys("Food_Condition6");
		String con2 =ReadXml.getKeys("Food_Condition7");
		String condition = "";
		String condition2 = "";
		int stat = 0;
		boolean result = false;
		FOOD_Bean food = new FOOD_Bean();
		for(int num=1;num<=max2;num++){
			Enumeration<?> en = multi.getParameterNames();
			condition= con1+"_"+num; // name
			condition2 = con2+"_"+num; // price
			food.setFOOD_INDEX(menuNum);
			while (en.hasMoreElements()) {
				eleName = (String) en.nextElement();
				System.out.println("****************************** element2 : " + eleName + " @@@@@ mname : " + mname+" // condition : "+condition+" // "+condition2);
				if (eleName.contains(condition) && eleName.contains(mname)) {
					if(multi.getParameter(eleName) != null){
						food.setFOOD_NAME(multi.getParameter(eleName));
						stat++;
					}
					//System.out.println("setFOOD_NAME : " + eleName);
				}
				if (eleName.contains(condition2) && eleName.contains(mname)) {
					if(multi.getParameter(eleName) != null){
					food.setFOOD_PRICE(Integer.parseInt(multi.getParameter(eleName)));
					stat++;
					}
					//System.out.println("setFOOD_PRICE : " + eleName);
				}
				if(stat == 2){
					result = dao.InsertCommand(food);
					stat=0;
					break;
				}
			}
			if (result == false) {
				stat=0;
				System.out.println("Fail to register the food");
		} else {
			System.out.println("Sucessfully register the food");
			}
		}
	}
	private int getMaxNum(Enumeration<?> en,String foodcond){
		String ele = "";
		int ind = 0;
		int max = 0;
		boolean isfood = foodcond.contains("FOOD");
		boolean ismenu = foodcond.contains("MENU");
		while(en.hasMoreElements()){
			ele = (String) en.nextElement();
			if(isfood){
				if(ele.contains(foodcond)){
					ind = ele.indexOf("@");
					max = Math.max(Integer.parseInt(ele.substring(ind-1,ind)),max);
				}
			}else if(ismenu){
				if(ele.contains(foodcond)){
					mlist.add(ele);
					ind = ele.lastIndexOf("_");
					max = Math.max(Integer.parseInt(ele.substring(ind+1)),max);
				}
			}
		}
		return max;
	}
}
