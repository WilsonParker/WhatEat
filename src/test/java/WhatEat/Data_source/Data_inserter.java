package WhatEat.Data_source;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Data_inserter {
	private static Statement stmt;
	private static Connection conn;

	public static void main(String[] args) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TeamAh", "Team_Ah", "dk1234");
			stmt = conn.createStatement();
			stmt.executeUpdate("DELETE FROM GRADE;"); 
			stmt.executeUpdate("DELETE FROM BOARD;");
			stmt.executeUpdate("DELETE FROM USER;");
			stmt.executeUpdate("DELETE FROM STORE;");
			stmt.executeUpdate("DELETE FROM MENU;");
			stmt.executeUpdate("DELETE FROM FOOD;");
			stmt.executeUpdate("DELETE FROM CATEGORY;"); 
			stmt.executeUpdate("DELETE FROM COMMENTS;"); 
			stmt.executeUpdate("DELETE FROM THEME;"); 
			stmt.executeUpdate("DELETE FROM INFO_POSITION;"); 
			
			stmt.executeUpdate("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('BRONSE',5);");
			stmt.executeUpdate("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('SILVER',7);"); 
			stmt.executeUpdate("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('GOLD',9);"); 
			stmt.executeUpdate("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('PLATINUM',12);"); 
			stmt.executeUpdate("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('DIAMOND',15);");
			String p = "WhatEat/images/Category/"; 
			stmt.executeUpdate("insert into CATEGORY VALUE(1,'전체보기','all.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(2,'치킨','pizza.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(3,'피자/양식','chicken.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(4,'중국집','chiness.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(5,'한식','korean.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(6,'일식/돈가스','japaness.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(7,'족발/보쌈','jockbal.jpg','"+p+"');");
			stmt.executeUpdate("insert into CATEGORY VALUE(8,'분식','bunsik.jpg','"+p+"');");
			stmt.executeUpdate("insert into INFO_POSITION VALUE('ADMIN','10101101');");
			stmt.executeUpdate("insert into INFO_POSITION VALUE('MEMBER','10111110');");
			stmt.executeUpdate("insert into INFO_POSITION VALUE('SELLER','11001110');");
			
			stmt.executeUpdate("insert into THEME(THEME_KIND,THEME_NAME) value(1,'미분류');");
			
			String p2 = "WhatEat/images/StoreIMG/"; 
			String f = "1304094820121.jpg"; 
			String g = "qjrj1.jpg"; 
			
			int prn = 1;
			int bn= 1;
			int mn = 1;
			int fn = 1;
			int bd=1;
			int id = 1; 
			stmt.executeUpdate("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION) VALUE('ADMIN','Admin','123','000000','10101101');");
			for(int x=1;x<10;x++){
					prn++;
					stmt.executeUpdate("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION,INFO_ADDSTORE_RG,INFO_MODSTORE_RG,INFO_DELSTORE_RG,INFO_EMAIL,INFO_PHONENUM) VALUE('사용자_"+prn+"','user"+prn+"','123','930506','10111110','FALSE','FALSE','FALSE','abc@asdf.com','010-1234-7890');");
					prn++;
					stmt.executeUpdate("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION,INFO_EMAIL,INFO_PERMIT,INFO_PHONENUM) VALUE('사용자_"+prn+"','seller"+prn+"','123','930506','11001110','abc@asdf.com','ADS95VG4','010-1234-7890');");
					for(int c=1;c<8;c++){
						stmt.executeUpdate("insert into STORE value("+prn+",null,1,'맛난거 파는 가게_"+id+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구','서방로','4','09:00','20:00','010-123-1234','배달가능',default);");
						id = getID(stmt);
						for(int a=1;a<3;a++){
							stmt.executeUpdate("INSERT INTO MENU VALUE("+id+","+mn+",'메뉴 이름_"+mn+"');");
							for(int b=1;b<3;b++){
								stmt.executeUpdate("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
								fn++;
							}
							mn++;
							}
						stmt.executeUpdate("insert into STORE value("+prn+",null,1,'맛난거 파는 가게2_"+id+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구 ','용봉로','77','09:25','20:30','010-123-1234','포장가능',default);");
						id = getID(stmt);
						for(int a=1;a<3;a++){
							stmt.executeUpdate("INSERT INTO MENU VALUE("+id+","+mn+",'메뉴 이름_"+mn+"');");
							for(int b=1;b<3;b++){
								stmt.executeUpdate("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
								fn++;
							}
							mn++;
							}
						stmt.executeUpdate("insert into STORE value("+prn+",null,1,'맛난거 파는 가게3_"+id+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구','우치로','80','10:00','22:00','010-123-1234','NO',default);");
						id = getID(stmt);
						for(int a=1;a<3;a++){
							stmt.executeUpdate("INSERT INTO MENU VALUE("+id+","+mn+",'메뉴 이름_"+mn+"');");
							for(int b=1;b<3;b++){
								stmt.executeUpdate("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
								fn++;
							}
							mn++;
							}
					}
					for(int d=1;d<5;d++){
						for(int a = 1;a<6;a++){
							stmt.executeUpdate("insert into BOARD(BOARD_INDEX,BOARD_SEQUENCE,BOARD_KIND,BOARD_WRITER,BOARD_SUBJECT,BOARD_CONTENT) VALUE("+prn+","+bd+","+a+",'테스트유저_"+prn+"','테스트 중입니다_"+bn+"','@@ Insert by Data_inserter');");
							bn++;
						}
						bd++;
					}
					System.out.println("Insert Test Data Sucess ** "+prn);
			}
			stmt.executeUpdate("insert into COMMENTS(COMMENTS_INDEX,COMMENTS_NUM,COMMENTS_WRITER,COMMENTS_SUBNUM) VALUE(1,1,'ADMIN',1);");
			System.out.println("Insert Test Data finished");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	private static int getID(Statement stmt){
		int id = 0;
		try {
			ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID();");
		if(rs.next())
			id = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
		
	}
}
