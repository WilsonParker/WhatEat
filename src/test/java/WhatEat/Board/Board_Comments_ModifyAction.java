package WhatEat.Board;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_Comments_ModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		boolean result = false;
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String kind = session.getAttribute("ModPath")!=null?(String) session.getAttribute("ModPath"):"";
		String path = "./Board_DetailAction.co";
		if(kind.equals("store"))
			path = "./Store_DetailAction.co";
		try {
			session.removeAttribute("ModPath");
			USER user = (USER) session.getAttribute("user");
			String table = ReadXml.getKeys("usedTable6");
			Map<String, String[]> map = request.getParameterMap();
			Map<String, Object> cols = new HashMap<String, Object>();
			for (String key : map.keySet()) {
				cols.put(key, map.get(key)[0]);
			}
			if ((user.getINFO_INDEX() == Integer.parseInt(map.get("COMMENTS_INDEX")[0]) && user.getINFO_MODCOMMENT_RG().equals("TRUE"))
					|| user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {

			result = Main_DAO.getDAO().ModifyCommand(cols, table,ReadXml.getKeys("Comments_Condition3"));
			if (result == false) {
				out.println("<script>");
				out.println("alert('Modification failure');");
				out.println("location.href='"+path+"';");
				out.println("</script>");
				out.close();
				return null;
			}
			forward.setRedirect(false);
			forward.setPath(""+path+".co");
			}else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
				out.println("location.href='"+path+"';");
				out.println("</script>");
				out.close();
				return null;
			}
			out.println("<script>");
			out.println("alert('성공적으로 수정 하였습니다');");
			out.println("location.href='"+path+"';");
			out.println("</script>");
			out.close();
		} catch (Exception e) {
			System.out.println("Board_Comments_ModifyAction err : "+e.getMessage());
			e.printStackTrace();
		}
		return forward;
	}
}