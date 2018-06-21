package WhatEat.Board;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_Comments_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		PrintWriter out = response.getWriter();;
		int index = Integer.parseInt(request.getParameter("cindex"));
		String path = "./Board_DetailAction.co";
		if(request.getParameter("path")!=null){
			if(((String) request.getParameter("path")).equals("store")){
				path = "./Store_DetailAction.co";
			}
		}
		COMMENTS_Bean com = new COMMENTS_Bean();
		boolean result = false;
		int num = Integer.parseInt(request.getParameter("cnum"));
		if ((user.getINFO_INDEX() == index && user.getINFO_DELCOMMENT_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				String table = ReadXml.getKeys("usedTable6");
				com = (COMMENTS_Bean) Main_DAO.getDAO().DetailCommand(com, num);
				result = Main_DAO.getDAO().DeleteCommand(table, num,ReadXml.getKeys("Comments_Condition3"));
				if (result == false) {
					out.println("<script>");
					out.println("alert('Fail to delete to the comments');");
					out.println("location.href='"+path+"';");
					out.println("</script>");
					out.close();
					return null;
				}
		} else {
			out.println("<script>");
			out.println("alert('권한이 제한 되었습니다');");
			out.println("location.href='"+path+"';");
			out.println("</script>");
			out.close();
			return null;
		}
		int kind = Integer.parseInt(request.getParameter("kind"));
		if(kind == 1)
			Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable5"),ReadXml.getKeys("Board_Condition4"),ReadXml.getKeys("Board_Condition3"),-1,com.getCOMMENTS_KIND_BOARD());
		if(kind == 2)
			Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable6"),ReadXml.getKeys("Comments_Condition4"),ReadXml.getKeys("Comments_Condition3"),-1,com.getCOMMENTS_SUBNUM());
		if(kind == 3)
			Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable2"),ReadXml.getKeys("Store_Condition6"),ReadXml.getKeys("Store_Condition2"),(-1*com.getCOMMENTS_SCORE()),num);
			Main_DAO.getDAO().CountUpdateCommand(ReadXml.getKeys("usedTable2"),ReadXml.getKeys("Store_Condition5"),ReadXml.getKeys("Store_Condition2"),-1,com.getCOMMENTS_KIND_STORE());
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}}