package WhatEat.Board;

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
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_AddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String realFolder = ReadXml.getKeys("upLoadRealPath")+ReadXml.getKeys("upLoadPath1");
		//String Folder = request.getSession().getServletContext().getRealPath("/").replace("\\","/")+ReadXml.getKeys("upLoadPath1");
		/*File dir = new File(ReadXml.getKeys("upLoadRealPath")+ReadXml.getKeys("upLoadPath1"));
		if (!dir.exists())
			dir.mkdir();
		realFolder = dir.toString();*/
		boolean result = false;
		PrintWriter out = response.getWriter();
		
		try {
			HttpSession session = request.getSession();
			USER user = (USER) session.getAttribute("user");
			if (user.getINFO_ADDBOARD_RG().equals("TRUE") || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))){
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, realFolder, Integer.parseInt(ReadXml.getKeys("FileSize")) * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
			result=Main_DAO.getDAO().InsertCommand(Method_Shorten.setterMethod(multi, new BOARD_Bean()));
			if (result == false) {
				out.println("<script>");
				out.println("alert('fail to add Board');");
				out.println("location.href='./Board_ListAction.co'");
				out.println("</script>");
				out.close();
				System.out.println("Fail to register the bulletin board");
				return null;
			}
			response.setContentType("text/html;charset=utf-8");
			out.println("<script>");
			out.println("alert('게시글 등록에 성공했습니다');");
			out.println("location.href='./Board_ListAction.co'");
			out.println("</script>");
			out.close();
			return null;
			}else{
				out.println("<script>");
				out.println("alert('권한이 제한 되었습니다');");
				out.println("location.href='./Board_ListAction.co';");
				out.println("</script>");
				out.close();
				return null;
			}
			} catch (Exception e) {
				out.println("<script>");
				out.println("alert('Board_AddAtion err :  "+ e.getMessage()+"');");
				out.println("location.href='./Board_ListAction.co';");
				out.println("</script>");
				out.close();
			System.out.println("Board_AddAtion err : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}