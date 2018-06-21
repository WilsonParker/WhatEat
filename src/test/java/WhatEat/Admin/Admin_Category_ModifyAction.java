package WhatEat.Admin;

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

@Admin_Path()
public class Admin_Category_ModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		boolean result = false;
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		String path = "./Food_Category_ListAction.co?cond=adList&re=true";
		String table = ReadXml.getKeys("usedTable1");
		String realFolder = "";
		File dir = new File(ReadXml.getKeys("upLoadRealPath") + ReadXml.getKeys("upLoadPath3"));
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
		String file = ReadXml.getKeys("Category_Condition2");
		cols.put(file,multi.getFilesystemName(file));
		out.println("<script>");
		if (user != null) {
			if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				result = Main_DAO.getDAO().ModifyCommand(cols, table, ReadXml.getKeys("Category_Condition1"));
				if (result == false) {
					out.println("alert('Modification failure');");
				} else {
					out.println("alert('성공적으로 수정 하였습니다');");
				}
			} else {
				out.println("alert('권한이 제한 되었습니다');");
			}
		} else {
			out.println("alert('권한이 제한 되었습니다');");
		}
		out.println("location.href='" + path + "';");
		out.println("</script>");
		out.close();
		return null;
	}
}