package WhatEat.Board;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_ModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		boolean result = false;
		ActionForward forward = new ActionForward();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		try {
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			String table = ReadXml.getKeys("usedTable5");
			String realFolder = "";
			File dir = new File(ReadXml.getKeys("upLoadRealPath") + ReadXml.getKeys("upLoadPath1"));
			if (!dir.exists())
				dir.mkdir();
			realFolder = dir.toString();
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, realFolder, Integer.parseInt(ReadXml.getKeys("FileSize")) * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
			Map<String, Object> cols = new HashMap<String, Object>();
			Enumeration en = multi.getParameterNames();
			while(en.hasMoreElements()){
				String val = (String) en.nextElement();
				cols.put(val, multi.getParameter(val));
			}
			String file = ReadXml.getKeys("Board_Condition6");
			cols.put(file,multi.getFilesystemName(file));
			if ((user.getINFO_INDEX() == Integer.parseInt(multi.getParameter("BOARD_INDEX")) && user.getINFO_MODBOARD_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
			result = Main_DAO.getDAO().ModifyCommand(cols, table,ReadXml.getKeys("Board_Condition3"));
			if (result == false) {
				out.println("<script>");
				out.println("alert('Modification failure');");
				out.println("location.href='./Board_DetailAction.co';");
				out.println("</script>");
				out.close();
				return null;
			}
			forward.setRedirect(false);
			//forward.setPath("./Board_DetailAction.co?num=" + cols.get("BOARD_NUM"));
			forward.setPath("./Board_DetailAction.co");
			}else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
				out.println("location.href='./Board_DetailAction.co';");
				out.println("</script>");
				out.close();
				return null;
			}
		} catch (Exception e) {
			System.out.println("Board_ModifyAction err : "+e.getMessage());
			e.printStackTrace();
		}
		return forward;
	}
}