package WhatEat.Admin;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Food.CATEGORY_Bean;
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_Category_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			String realFolder = "";
			File dir = new File(ReadXml.getKeys("upLoadRealPath") + ReadXml.getKeys("upLoadPath3"));
			if (!dir.exists())
				dir.mkdir();
			realFolder = dir.toString();
			boolean result = false;
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			if(user != null){
			if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				MultipartRequest multi = null;
				multi = new MultipartRequest(request, realFolder,
						Integer.parseInt(ReadXml.getKeys("FileSize")) * 1024 * 1024, "utf-8",
						new DefaultFileRenamePolicy());
				result = Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(multi, new CATEGORY_Bean()));
				response.setContentType("text/html;charset=utf-8");
				if(result == true){
				out.println("<script>");
				out.println("alert('카테고리 추가 성공!!');");
				} else{
					out.println("<script>");
					out.println("alert('카테고리 추가 실패..');");
					return null;
				}
			}} else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
			}
			out.println("location.href='./Food_Category_ListAction.co?cond=adList&re=true'");
			out.println("</script>");
			out.close();
			return null;
		} catch (Exception e) {
			System.out.println("Admin_Category_AddAction err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}