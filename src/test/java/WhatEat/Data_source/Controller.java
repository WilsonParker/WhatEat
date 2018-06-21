package WhatEat.Data_source;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import WhatEat.Utils.GetAnnObj;

@WebServlet("*.co") 
public class Controller extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); response.setContentType("text/html;charset=utf-8");
		String command = request.getRequestURI().substring(request.getContextPath().length()); command = command.substring(command.lastIndexOf("/")+1);
		ActionForward forward = null; Action action = (Action) GetAnnObj.getObj(command);
		try { forward = action.execute(request, response); } catch (Exception e) { System.out.println("Controller err : " + e.getMessage()); e.printStackTrace(); }
		if (forward != null && forward.getPath() != null) { if (forward.isRedirect()) { response.sendRedirect(forward.getPath()); }
		else { RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath()); dispatcher.forward(request, response); } } }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { doProcess(request, response); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { doProcess(request, response); }
}