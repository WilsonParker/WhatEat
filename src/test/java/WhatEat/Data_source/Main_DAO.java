package WhatEat.Data_source;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import WhatEat.Seller.SELLER_Bean;
import WhatEat.Utils.ConnectDB;
import WhatEat.Utils.GetAnnObj;
import WhatEat.Utils.Method_Shorten;
import WhatEat.Utils.ReadXml;

public class Main_DAO {
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	private final String info2 = ReadXml.getKeys("MS_Condition2"); // NUM
	private final String info3 = ReadXml.getKeys("MS_Condition3"); // SEQUENCE
	private final String info5 = ReadXml.getKeys("MS_Condition1"); // INDEX

	private void discon() {
		try {
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException se) {
		}
	}

	private void Connect() {
		try {
			conn = new ConnectDB().ConnectCon();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public static Main_DAO getDAO() {
		return new Main_DAO();
	}

	public int ListCountCommand(String table, HashMap<String, Object> whe) {
		Connect();
		int x = 0;
		try {
			Set<String> wh = whe != null ? whe.keySet() : null;
			String[] whes = wh != null ? wh.toArray(new String[wh.size()]) : null;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Method_Shorten.ListCountData(whes, whe, table));
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("ListCountCommand error : " + e.getMessage());
			e.printStackTrace();
			;
		} finally {
			discon();
		}
		return x;
	}

	public int ListSequenceCommand(String table, int kind) {
		Connect();
		int x = 0;
		try {
			stmt = conn.createStatement();
			String condition = "";
			String condition2 = "";
			if (table.equals(ReadXml.getKeys("usedTable5"))) {
				condition = ReadXml.getKeys("Board_Condition2");
				condition2 = ReadXml.getKeys("Board_Condition1");
			} else {
				condition = table + "_" + info3;
				condition2 = table + "_" + info5;
			}
			rs = stmt.executeQuery(
					(String.format(ReadXml.getKeys("ListSequenceCommand"), condition, table, condition2, kind)));
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("ListSequenceCommand error : " + e.getMessage());
			e.printStackTrace();
			;
		} finally {
			discon();
		}
		return x + 1;
	}

	// 목록 보기
	public List<Object> ListCommand(String obj, HashMap<String, Object> whe, HashMap<String, Object> ord, int page, int limit) {
		Connect();
		List<Object> list = new ArrayList<Object>();
		try {
			Set<String> wh = whe != null ? whe.keySet() : null;
			String[] whes = wh != null ? wh.toArray(new String[wh.size()]) : null;
			Set<String> or = ord != null ? ord.keySet() : null;
			String[] ords = or != null ? or.toArray(new String[or.size()]) : null;
			stmt = conn.createStatement();
			String table = ReadXml.getKeys("MS_Condition8").contains(obj.substring(0, obj.lastIndexOf("_")))
					? ReadXml.getKeys("usedTable11") : obj.substring(0, obj.lastIndexOf("_"));
			if (page ==0 && limit == 0) {
				rs = stmt.executeQuery(Method_Shorten.ListData(whes, whe, ords, ord, table));
			} else {
				rs = stmt.executeQuery(Method_Shorten.ListData(whes, whe, ords, ord, table)
						+ String.format(" limit %d, %d", page, limit));
			}
			while (rs.next()) {
				list.add(Method_Shorten.setterMethod(rs, GetAnnObj.getObj(obj)));
			}
		} catch (Exception e) {
			System.out.println("ListCommand error : " + e.getMessage());
			e.printStackTrace();
		} finally {
			discon();
		}
		return list;
	}

	// 내용 보기
	public Object DetailCommand(Object obj, int num) {
		Connect();
		try {
			String name = obj.getClass().getName();
			String table = name.substring(name.lastIndexOf(".") + 1, name.lastIndexOf("_"));
			String condition = "";
			if (ReadXml.getKeys("MS_Condition8").contains(table)) {
				condition = ReadXml.getKeys("User_Condition1");
				table = ReadXml.getKeys("usedTable11");
			} else if(ReadXml.getKeys("MS_Condition11").contains(table)){
				condition = table + "_" +info5;
			}else
				condition = table + "_" + info2;
			stmt = conn.createStatement();
			rs = stmt.executeQuery((String.format(ReadXml.getKeys("DetailCommand"), table, condition, num)));
			if (rs.next()) {
				Method_Shorten.setterMethod(rs, obj);
			}
		} catch (Exception e) {
			System.out.println("DetailCommand error : " + e.getMessage() + " : " + e.getStackTrace());
		} finally {
			discon();
		}
		return obj;
	}

	public boolean InsertCommand(Object obj) {
		Connect();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(Method_Shorten.insertData(obj));
			return true;
		} catch (Exception e) {
			System.out.println("InsertCommand error : " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			discon();
		}
	}

	// 수정
	public boolean ModifyCommand(Map<String, Object> map, String table,String condition) {
		Connect();
		int result = 0;
		try {
			Set<String> keys = map.keySet();
			String[] cols = keys.toArray(new String[keys.size()]);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(Method_Shorten.modifyData(cols, map, condition, table));
			if (result == 0)
				return false;
			return true;
		} catch (Exception e) {
			System.out.println("ModifyCommand error : " + e.getMessage());
			e.printStackTrace();
		} finally {
			discon();
		}
		return false;
	}

	// 삭제
	public boolean DeleteCommand(String table, int num,String condition) {
		Connect();
		int result = 0;
		try {
			stmt = conn.createStatement();
			result = stmt.executeUpdate(String.format(ReadXml.getKeys("DeleteCommand"), table, condition, num));
			if (result == 0)
				return false;
			return true;
		} catch (Exception e) {
			System.out.println("DeleteCommand error : " + e.getMessage() + " : " + e.getStackTrace());
		} finally {
			discon();
		}
		return false;
	}

	public void CountUpdateCommand(String table, String condition,String condition2, int val, int num) {
		Connect();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(String.format(ReadXml.getKeys("CountUpdateCommand"), table, condition, condition, val, condition2, num));
		} catch (Exception e) {
			System.out.println("CountUpdateCommand error : " + e.getMessage() + " : " + e.getStackTrace());
		} finally {
			discon();
		}
	}

	// 로그인
	public int LoginCommand(String id, String pass, HttpSession session) {
		Connect();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(String.format(ReadXml.getKeys("LoginCommand"), id, id));
			boolean log = rs.next();
			if (!log) {
				return 1;
				/* 아이디가 없습니다 */ } else if (log && !pass.equals(rs.getString(1))) {
				return 2;
				/* 입력한 아이디의 비밀번호가 일치하지 않음 */ } else if (log && pass.equals(rs.getString(1))) {
				getInfo(id, session);
				return 0;
				/* 로그인 */ }
		} catch (Exception e) {
			System.out.println("LoginCommand error : " + e.getMessage());
			e.printStackTrace();
		} finally {
			discon();
		}
		return 0;
	}

	public void getInfo(String id, HttpSession session) {
		Connect();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(String.format(ReadXml.getKeys("getInfo"), ReadXml.getKeys("usedTable11"), id));
			USER user;
			if (rs.next()) {
				user = (USER) Method_Shorten.setterMethod(rs, new SELLER_Bean());
				session.setAttribute("user", user);
			}
		} catch (Exception e) {
			System.out.println("getInfo error : " + e.getMessage());
			e.printStackTrace();
		} finally {
			discon();
		}
	}

	public int getMax(String table) {
		ResultSet rs = null;
		Statement stmt = null;
		int maxnum = 0;
		try {
			stmt = new ConnectDB().ConnectCon().createStatement();
			String condition = "";
			if (ReadXml.getKeys("usedTable11").equals(table)) {
				condition = ReadXml.getKeys("User_Condition1");
			} else {
				condition = table + "_" + info2;
			}
			rs = stmt.executeQuery(String.format(ReadXml.getKeys("MaxNum"), condition, table));
			if (rs.next()) {
				maxnum = rs.getInt(1) + 1;
			} else {
				maxnum = 1;
			}
		} catch (Exception e) {
			System.out.println("getMax err : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				discon();
			} catch (Exception e) {
			}
		}
		return maxnum;
	}

	public ArrayList<String> getColumns(String table) {
		Connect();
		ArrayList<String> cols = null;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(String.format(ReadXml.getKeys("getColumns"), table));
			int clc = rs.getMetaData().getColumnCount();
			cols = new ArrayList<String>();
			for (int a = 1; a < clc + 1; a++) {
				cols.add(rs.getMetaData().getColumnName(a));
			}
		} catch (Exception e) {
			System.out.println("getColumns err : " + e.getMessage());
			e.printStackTrace();
		}
		return cols;
	}

	public int getLastInsert() {
		Connect();
		int val = 0;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(ReadXml.getKeys("getLastInsert"));
			if (rs.next())
				val = rs.getInt(1);
			System.out.println("getLastInsert is : " + val);
			return val;
		} catch (Exception e) {
			System.out.println("getLastInsert err : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				discon();
			} catch (Exception e) {
			}
		}
		return val;
	}
	
	public String SearchData(Map<String,Object> map,String table,String dat) {
		Connect();
		String data = "none";
		Set<String> keys = map.keySet();
		String[] cols = keys.toArray(new String[keys.size()]);		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Method_Shorten.SearchData(cols, map,table, dat));
			if (rs.next())
				data = rs.getString(1);
		} catch (Exception e) {
			System.out.println("SearchData err : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				discon();
			} catch (Exception e) {
			}
		}
		return data;
	}
	
	public String getGInfo(String position,HttpSession session) {
		Connect();
		String result = "";
		try {
			Statement stmt = conn.createStatement();
			System.out.println( String.format(ReadXml.getKeys("getGinfo"), ReadXml.getKeys("usedTable11"), position));
			ResultSet rs = stmt.executeQuery(String.format(ReadXml.getKeys("getGinfo"),ReadXml.getKeys("usedTable11"),position));
			USER user;
			if (rs.next()) {
				user = (USER) Method_Shorten.setterMethod(rs, new SELLER_Bean());
				session.setAttribute("user", user);
				result = "로그인 성공";
			}else{
				result = "로그인 실패";
			}
		} catch (Exception e) {
			System.out.println("getGInfo err : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				discon();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	private boolean createGuestData(String position){
		Connect();
		try{
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(String.format(ReadXml.getKeys("getGinfo"), ReadXml.getKeys("usedTable11"), position));
		}catch(Exception e){
			System.out.println("createGuestData err : " + e.getMessage());
			e.printStackTrace();
		}
		return false;
	}
}
