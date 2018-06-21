package WhatEat.Utils;

import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class Method_Shorten_Backup {

	public static Object setterMethod(ResultSet rs, Object obj) {
		Class<?> type;
		List<Method> methods = gsMethod(obj, "set");
		Method method;
		String Mname;
		try {
			for (int cnt = 0; cnt < methods.size(); cnt++) {
				method = (Method) methods.get(cnt);
				Mname = method.getName().replace("set", "");
				type = method.getParameterTypes()[0];
				if ((type.getName().equals("int") || type == Integer.class)
						|| (type.getName().equals("float") || type == Float.class)
						|| (type.getName().equals("long") || type == Long.class)) {
					method.invoke(obj, rs.getInt(Mname));
				} else if ((type.getName().equals("string") || type == java.lang.String.class)&&rs.getString(Mname)!=null) {
					method.invoke(obj, rs.getString(Mname));
				} else if ((type.getName().equals("date") || type == java.sql.Date.class)&&rs.getDate(Mname)!=null) {
					method.invoke(obj, rs.getDate(Mname));
				} else if (type.getName().equals("boolean") || type == Boolean.class) {
					method.invoke(obj, rs.getBoolean(Mname));
				}
			}
		} catch (Exception e) {
			System.out.println("setterMethod RS err : " + e.getMessage());
			e.printStackTrace();
		}
		return obj;

	}

	public static Object setterMethod(MultipartRequest multi, Object obj) {
		List<Method> methods = gsMethod(obj, "set");
		String Mname;
		Method method;
		Class<?> type;
		try {
			String files = "";
			Enumeration<?> en = multi.getFileNames();
			while (en.hasMoreElements()) {
				files += multi.getFilesystemName((String) en.nextElement()) + ",";
			}
			files = files.substring(0, files.length() - 1);
			//System.out.println(files);
			for (int cnt = 0; cnt < methods.size(); cnt++) {
				method = methods.get(cnt);
				Mname = method.getName().replace("set", "");
				type = method.getParameterTypes()[0];
				//System.out.println("setterMethod : type = " + type + " @@ Mname = " + Mname);
				if (Mname.contains(ReadXml.getKeys("MS_Condition6"))) {
					method.invoke(obj, files);
				} else if (multi.getParameter(Mname) != null) {
					if ((type.getName().equals("int") || type == Integer.class)
							|| (type.getName().equals("float") || type == Float.class)
							|| (type.getName().equals("long") || type == Long.class)) {
						method.invoke(obj, Integer.parseInt(multi.getParameter(Mname)));
					} else if (type.getName().equals("string") || type == java.lang.String.class) {
						method.invoke(obj, multi.getParameter(Mname));
					}
				}
			}
		} catch (Exception e) {
			System.out.println("setterMethod Multi err : " + e.getMessage());
			e.printStackTrace();
		}
		return obj;
	}

	public static Object setterMethod(HttpServletRequest request, Object obj) {
		List<Method> methods = gsMethod(obj, "set");
		String Mname;
		Method method;
		Class<?> type;
		try {
			for (int cnt = 0; cnt < methods.size(); cnt++) {
				method = methods.get(cnt);
				Mname = method.getName().replace("set", "");
				type = method.getParameterTypes()[0];
				if (request.getParameter(Mname) != null) {
					if ((type.getName().equals("int") || type == Integer.class)
							|| (type.getName().equals("float") || type == Float.class)
							|| (type.getName().equals("long") || type == Long.class)) {
						method.invoke(obj, Integer.parseInt(request.getParameter(Mname)));
					} else if (type.getName().equals("string") || type == java.lang.String.class) {
						method.invoke(obj, request.getParameter(Mname));
					}
				}
			}
		} catch (Exception e) {
			System.out.println("setterMethod request err : " + e.getMessage());
			e.printStackTrace();
		}
		return obj;
	}

	private static List<Method> gsMethod(Object obj, String me) {
		Method[] method = obj.getClass().getDeclaredMethods();
		List<Method> methods = new ArrayList<Method>();
		for (int cnt = 0; cnt < method.length; cnt++) {
			if (method[cnt].getName().startsWith(me)) {
				methods.add(method[cnt]);
			}
		}
		return methods;
	}

	public static String insertData(Object obj) {
		String name = obj.getClass().getName();
		String table = name.substring(name.indexOf(".") + 1, name.lastIndexOf("_"));
		if (ReadXml.getKeys("MS_Condition8").contains(table))
			table = ReadXml.getKeys("usedTable11");
		List<Method> methods = gsMethod(obj, "get");
		String query = "insert into " + table + "(";
		String data = "";
		try {
			for (Method method : methods) {
				if (method.invoke(obj) != null){
					if ((!(method.invoke(obj) + "").equals("0"))&&(!method.invoke(obj).equals("null")))
						data += (method.getName().replace("get", "")) + ",";
				}
			}
			if(data.contains(","))
				data = data.substring(0, data.lastIndexOf(","));
			query += data + ") value(";
			for (Method method : methods) {
				if (data.contains(method.getName().replace("get", "")))
					query += getType(method.invoke(obj)) + ",";
			}
			if(query.contains(","))
				query = query.substring(0, query.lastIndexOf(","));
			query = query + ")";
			System.out.println(query);
		} catch (Exception e) {
			System.out.println("Method_Shorten insertData err : " + e.getMessage());
			e.printStackTrace();
		}
		return query;
	}

	private static Object getType(Object obj) {
		if (obj == null)
			return null;
		Object ob = null;
		switch (obj.getClass().getTypeName()) {
		case "java.lang.Integer":
			ob = reInt(obj);
			break;
		case "java.lang.Float":
			ob = reFloat(obj);
			break;
		case "java.lang.String":
			ob = reString(obj);
			break;
		default:
			return ob;
		}
		return ob;
	}

	private static int reInt(Object obj) {
		return (int) obj;
	}

	private static Float reFloat(Object obj) {
		return (Float) obj;
	}

	private static String reString(Object obj) {
		return "'" + obj + "'";
	}

	public static String modifyData(String[] cols, Map<String, Object> map, String condition, String table) {
		String query = "update " + table + " set ";
		String cond = "";
		try {
			for (int c = 0; c < cols.length; c++) {
				if (cols[c].contains(condition)) {
					cond = "where " + cols[c] + " = " + getType(map.get(cols[c]));
				} else {
					query += cols[c] + " = " + getType(map.get(cols[c])) + ",";
				}
			}
			query = query.substring(0, query.length() - 1) + " " + cond;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(query);
		return query;
	}

	public static String ListData(String[] whes, HashMap<String,Object> whe, String[] ords, HashMap<String, Object> ord,
			String table) {
		String query = "select * from " + table;
		String wcond = "";
		String ocond = "";
		String Operator = " and ";
		try {
			if (whe != null) {
				if(whe.get("Operator") != null){
					Operator = " "+(String) whe.get("Operator")+" ";
				}
				wcond = " where ";
				if(Operator.contains("in")){
					String wcond2="";
					String wcond3="";
					for (int c = 0; c < whes.length; c++) {
						if(!(whes[c].equals("Operator")||whes[c].equals("Condition")))
							wcond3 += getType(whe.get(whes[c])) + ",";
						wcond2 = whe.get("Condition") + " in(";
					}
					if(wcond3.contains(","))
						wcond3 = wcond3.substring(0,wcond3.lastIndexOf(","));
					wcond += wcond2+wcond3+")";
				}else{
				for (int c = 0; c < whes.length; c++) {
					if(!whes[c].equals("Operator"))
						wcond += whes[c] + " = " + getType(whe.get(whes[c])) + Operator;
				}
				if(wcond.contains(Operator))
				wcond = wcond.substring(0, wcond.lastIndexOf(Operator));
				}
			}
			if (ord != null) {
				ocond = " order by ";
				for (int c = 0; c < ords.length; c++) {
					if(!(ords[c] == null || ords[c].equals("") || ords[c].equals("null"))){
						ocond += ords[c] + " " + ord.get(ords[c]) + ", ";
					}
				}
				ocond = ocond.substring(0, ocond.lastIndexOf(","));
			}
			query = query + wcond + ocond;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(query);
		return query;
	}
	
	public static String ListCountData(String[] whes, HashMap<String,Object> whe, String table) {
		String query = "select count(*) from " + table;
		String wcond = "";
		String Operator = " and ";
		try {
			if (whe != null) {
				if(whe.get("Operator") != null){
					Operator = " "+(String) whe.get("Operator")+" ";
				}
				wcond = " where ";
				if(Operator.contains("in")){
					String wcond2="";
					String wcond3="";
					for (int c = 0; c < whes.length; c++) {
						if(!(whes[c].equals("Operator")||whes[c].equals("Condition")))
							wcond3 += getType(whe.get(whes[c])) + ",";
					}
					wcond2 = whe.get("Condition") + " in(";
					wcond3 = wcond3.substring(0,wcond3.lastIndexOf(","));
					wcond += wcond2+wcond3+")";
				}else{
				for (int c = 0; c < whes.length; c++) {
					if(!whes[c].equals("Operator"))
						wcond += whes[c] + " = " + getType(whe.get(whes[c])) + Operator;
				}
				if(wcond.contains(Operator))
				wcond = wcond.substring(0, wcond.lastIndexOf(Operator));
				}
			}
			query = query + wcond;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//System.out.println(query);
		return query;
	}
	
	public static String SearchData(String[] cols, Map<String, Object> map, String table,String dat) {
		String query = "select (" + dat + ") from " + table;
		String cond = "where ";
		try {
			for (int c = 0; c < cols.length; c++) {
					cond += cols[c] + " = " + getType(map.get(cols[c])) + " and ";
			}
			query = query + " " + cond.substring(0, cond.lastIndexOf(" and ")) ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(query);
		return query;
	}
	
	/*private static Object setIndex(Object obj, int maxnum) {
	String condition = "";
	try {
		String name = obj.getClass().getName();
		String table = name.substring(name.indexOf(".") + 1, name.lastIndexOf("_"));
		if (ReadXml.getKeys("MS_Condition8").contains(table))
			condition = ReadXml.getKeys("MS_Condition1");
		else
			condition = ReadXml.getKeys("MS_Condition2");
		System.out.println("setIndex : " + condition);
		for (Method met : gsMethod(obj, "set")) {
			if (met.getName().contains(condition)) {
				met.invoke(obj, maxnum);
			}
		}
	} catch (Exception e) {
		System.out.println("Method_Shorten setIndex err : " + e.getMessage());
		e.printStackTrace();
	}
	return obj;
}*/
}
