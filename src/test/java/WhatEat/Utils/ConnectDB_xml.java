package WhatEat.Utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.XMLOutputter;

public class ConnectDB_xml {
	private static String path = "src/main/webapp/WhatEat/Xml/Mysource.xml";
	
	public static void main(String[] args) { setDB(); System.out.println("Update Success");}

	private static String readSource(String key) { Element rss = null;
		try {rss = new SAXBuilder().build(path).getRootElement(); } catch (JDOMException | IOException e) {
		System.out.println("ConnectDB_xml err : " + e.getMessage()); e.printStackTrace(); } List<Element> rssList = rss.getChildren();
		for (Element ele : rssList) { if (ele.getName().equals(key)) { return ele.getText(); } } return null; }
	
	private static  void setDB() { String key; String DBsource = readSource(readSource("DB-name"));
	try { Element rss = new SAXBuilder().build(readSource("web-path")).getRootElement(); List<Element> rssList = rss.getChildren();
	for (Element ele : rssList) { if (ele.getName().equals("resource-ref")) { List<Element> rssList3 = ele.getChildren();
	for (Element el : rssList3) { key = readSource("DB-name").concat(DBsource.substring(DBsource.lastIndexOf(("/")))); if (el.getName().equals("res-ref-name") && (!el.getText().equals(key))) el.setText(key);
	key = readSource("DB-type"); if (el.getName().equals("res-type") && (!el.getText().equals(key))) el.setText(key);
	key = readSource("DB-auth"); if (el.getName().equals("res-auth") && (!el.getText().equals(key))) el.setText(key); } } }
	new XMLOutputter().output(rss, new FileOutputStream(readSource("web-path"))); rss = new SAXBuilder().build(readSource("context-path")).getRootElement(); rssList = rss.getChildren();
	for (Element ele : rssList) { if (ele.getName().equals("Resource")) { 
	key = readSource("DB-name").concat(DBsource.substring(DBsource.lastIndexOf(("/")))); if(!ele.getAttribute("name").equals(key)) ele.setAttribute("name",key);
	key = readSource("DB-auth"); if(!ele.getAttribute("auth").equals(key)) ele.setAttribute("auth",key);
	key = readSource("DB-type"); if(!ele.getAttribute("type").equals(key)) ele.setAttribute("type",key);
	key = readSource("DB-url").concat("/" + readSource("useDB")); if(!ele.getAttribute("url").equals(key)) ele.setAttribute("url",key);
	key = readSource("userName"); if(!ele.getAttribute("username").equals(key)) ele.setAttribute("username",key); 
	key = readSource("userPW"); if(!ele.getAttribute("password").equals(key)) ele.setAttribute("password",key);
	key = readSource("DB-driverClassName"); if(!ele.getAttribute("driverClassName").equals(key)) ele.setAttribute("driverClassName",key); } }
	new XMLOutputter().output(rss, new FileOutputStream(readSource("context-path"))); } catch (JDOMException | IOException e) { System.out.println("setDB err : " + e.getMessage()); e.printStackTrace(); } }

}
