package WhatEat.Utils;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class ConnectDB {
	private String DBsource = ReadXml.getKeys(ReadXml.getKeys("DB-name"));
	private DataSource ds = null;
	private Connection conn = null;

	// Return Connection
	public Connection ConnectCon() throws ServletException {
		try {
			InitialContext initctx = new InitialContext();
			ds = (DataSource) initctx.lookup(DBsource);
			if (ds != null) {
				conn = ds.getConnection();
				if (conn == null)
					throw new Exception("DB Connector : Fail connect to the Data base");
				//System.out.println("Conntect to webdbpool is oK");
			}
		} catch (Exception e) {
			System.out.println("DB Connector err : " + e.getStackTrace() + " : " + e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}

	public void commit(Connection conn) {
		try {
			conn.commit();
			System.out.println("Commit Success");
		} catch (Exception e) {
			System.out.println("Commit Fail");
			e.printStackTrace();
		}
	}

	public void rollback(Connection conn) {
		try {
			conn.rollback();
			System.out.println("Rollback Success");
		} catch (Exception e) {
			System.out.println("Rollback Fail");
			e.printStackTrace();
		}
	}

}