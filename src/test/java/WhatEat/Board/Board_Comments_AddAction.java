package WhatEat.Board;

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

@Board_Path()
public class Board_Comments_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		boolean result = false;
		String path="";
		try {
			response.setContentType("text/html;charset=utf-8");
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			if (user.getINFO_ADDCOMMENT_RG().equals("TRUE")){
				result=Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(request, new COMMENTS_Bean()));
			if (result == false) {
				out.println("<script>");
				out.println("location.href='javascript:history.go(-1)';");
				out.println("</script>");
				out.close();
				return null;
			}
			int kind = Integer.parseInt(request.getParameter("kind"));
			int score = request.getParameter("COMMENTS_SCORE") !=null?Integer.parseInt(request.getParameter("COMMENTS_SCORE")):-1;
			switch(kind){
			case 1:
				path="./Board_DetailAction.co";
				Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable5"),ReadXml.getKeys("Board_Condition4"),ReadXml.getKeys("Board_Condition3"),1,Integer.parseInt(request.getParameter(ReadXml.getKeys("Comments_Condition1"))));
				break;
			case 2:
				Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable6"),ReadXml.getKeys("Comments_Condition4"),ReadXml.getKeys("Comments_Condition3"),1,Integer.parseInt(request.getParameter(ReadXml.getKeys("Comments_Condition5"))));
				break;
			case 3:
				path="./Store_DetailAction.co";
				if(score>0)
					Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable2"),ReadXml.getKeys("Store_Condition6"),ReadXml.getKeys("Store_Condition2"),score,Integer.parseInt(request.getParameter(ReadXml.getKeys("Comments_Condition2"))));
				Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable2"),ReadXml.getKeys("Store_Condition5"),ReadXml.getKeys("Store_Condition2"),1,Integer.parseInt(request.getParameter(ReadXml.getKeys("Comments_Condition2"))));
				break;
			}
			out.println("<script>");
			out.println("alert('성공적으로 등록 하였습니다');");
			//out.println("location.href='javascript:history.go(-1)';");
			out.println("location.href='"+path+"';");
			out.println("</script>");
			out.close();
			return null;
			}else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
				out.println("location.href='javascript:history.go(-1)';");
				out.println("</script>");
				out.close();
				return null;
			}
			} catch (Exception e) {
			System.out.println("Board_Comments_AddAtion err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}