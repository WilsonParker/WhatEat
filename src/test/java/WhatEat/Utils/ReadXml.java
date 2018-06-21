package WhatEat.Utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.XMLOutputter;

@WebListener
public class ReadXml implements ServletContextListener {
	private static String path = "WhatEat/Xml/Mysource.xml";
	
	public void contextDestroyed(ServletContextEvent sce) { }

	public void contextInitialized(ServletContextEvent sce) { path = (sce.getServletContext().getRealPath("") +"/"+ path).replace("\\", "/"); /*setDB();*/}

	public static String getKeys(String key) { Element rss = null;
		try { rss = new SAXBuilder().build(path).getRootElement(); } catch (JDOMException | IOException e) { System.out.println("ReadXml err : " + e.getMessage()); e.printStackTrace(); }
		List<Element> rssList = rss.getChildren(); for (Element ele : rssList) { if (ele.getName().equals(key)) { return ele.getText(); } } return null; }
	
	public static  void setDB() { String key; String DBsource = getKeys(getKeys("DB-name"));
		try { Element rss = new SAXBuilder().build(getKeys("web-path")).getRootElement(); List<Element> rssList = rss.getChildren();
		for (Element ele : rssList) { if (ele.getName().equals("resource-ref")) { List<Element> rssList3 = ele.getChildren();
		for (Element el : rssList3) { key = getKeys("DB-name").concat(DBsource.substring(DBsource.lastIndexOf(("/")))); if (el.getName().equals("res-ref-name") && (!el.getText().equals(key))) el.setText(key);
		key = getKeys("DB-type"); if (el.getName().equals("res-type") && (!el.getText().equals(key))) el.setText(key);
		key = getKeys("DB-auth"); if (el.getName().equals("res-auth") && (!el.getText().equals(key))) el.setText(key); } } }
		new XMLOutputter().output(rss, new FileOutputStream(getKeys("web-path"))); rss = new SAXBuilder().build(getKeys("context-path")).getRootElement(); rssList = rss.getChildren();
		for (Element ele : rssList) { if (ele.getName().equals("Resource")) { 
		key = getKeys("DB-name").concat(DBsource.substring(DBsource.lastIndexOf(("/")))); if(!ele.getAttribute("name").equals(key)) ele.setAttribute("name",key);
		key = getKeys("DB-auth"); if(!ele.getAttribute("auth").equals(key)) ele.setAttribute("auth",key);
		key = getKeys("DB-type"); if(!ele.getAttribute("type").equals(key)) ele.setAttribute("type",key);
		key = getKeys("DB-url").concat("/" + getKeys("useDB")); if(!ele.getAttribute("url").equals(key)) ele.setAttribute("url",key);
		key = getKeys("userName"); if(!ele.getAttribute("username").equals(key)) ele.setAttribute("username",key); 
		key = getKeys("userPW"); if(!ele.getAttribute("password").equals(key)) ele.setAttribute("password",key);
		key = getKeys("DB-driverClassName"); if(!ele.getAttribute("driverClassName").equals(key)) ele.setAttribute("driverClassName",key); } }
		new XMLOutputter().output(rss, new FileOutputStream(getKeys("context-path"))); } catch (JDOMException | IOException e) { System.out.println("setDB err : " + e.getMessage()); e.printStackTrace(); } }
}
