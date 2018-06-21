package WhatEat.Admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_Grade_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			boolean result = false;
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			if(user != null){
			if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				result = Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(request, new GRADE_Bean()));
				if(result == true){
				out.println("<script>");
				out.println("alert('등급 추가 성공!!');");
				} else{
					out.println("<script>");
					out.println("alert('등급 추가 실패..');");
					return null;
				}
			}} else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
			}
			out.println("location.href='./Admin_Grade_ListAction.co?cond=adList&re=true'");
			out.println("</script>");
			out.close();
			return null;
		} catch (Exception e) {
			System.out.println("Admin_Grade_AddAction err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}