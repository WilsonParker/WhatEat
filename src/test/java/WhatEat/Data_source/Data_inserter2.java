package WhatEat.Data_source;

public class Data_inserter2 {

	public static void main(String[] args) {
		System.out.println("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('BRONSE',5);");
		System.out.println("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('SILVER',7);"); 
		System.out.println("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('GOLD',9);"); 
		System.out.println("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('PLATINUM',12);"); 
		System.out.println("INSERT INTO GRADE(GRADE_VAL,GRADE_ACM) VALUE('DIAMOND',15);");
		String p = "WhatEat/images/Category/"; 
		System.out.println("insert into CATEGORY VALUE(1,'전체보기','all.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(2,'치킨','pizza.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(3,'피자/양식','chicken.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(4,'중국집','chiness.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(5,'한식','korean.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(6,'일식/돈가스','japaness.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(7,'족발/보쌈','jockbal.jpg','"+p+"');");
		System.out.println("insert into CATEGORY VALUE(8,'분식','bunsik.jpg','"+p+"');");
		System.out.println("insert into INFO_POSITION VALUE('ADMIN','10101101');");
		System.out.println("insert into INFO_POSITION VALUE('MEMBER','10111110');");
		System.out.println("insert into INFO_POSITION VALUE('SELLER','11001110');");
		
		System.out.println("insert into THEME(THEME_KIND,THEME_NAME) value(1,'미분류');");
		
		String p2 = "WhatEat/images/StoreIMG/"; 
		String f = "1304094820121.jpg"; 
		String g = "qjrj1.jpg"; 
		
		int prn = 1;
		int sn= 1;
		int bn= 1;
		int mn = 1;
		int fn = 1;
		int bd=1;
		System.out.println("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION,INFO_JOINDATE) VALUE('ADMIN','Admin','123','000000','10101101',now());");
		for(int x=1;x<15;x++){
				prn++;
				System.out.println("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION,INFO_ADDSTORE_RG,INFO_MODSTORE_RG,INFO_DELSTORE_RG,INFO_EMAIL,INFO_JOINDATE,INFO_PHONENUM) VALUE('사용자_"+prn+"','user"+prn+"','123','930506','10111110','FALSE','FALSE','FALSE','abc@asdf.com',now(),'010-1234-7890');");
				prn++;
				System.out.println("INSERT INTO USER(INFO_NAME,INFO_ID,INFO_PASSWORD,INFO_BIRTH,INFO_POSITION,INFO_EMAIL,INFO_PERMIT,INFO_JOINDATE,INFO_PHONENUM) VALUE('사용자_"+prn+"','seller"+prn+"','123','930506','11001110','abc@asdf.com','ADS95VG4',now(),'010-1234-7890');");
				for(int c=1;c<8;c++){
					System.out.println("insert into STORE value("+prn+",null,1,'맛난거 파는 가게_"+sn+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구','서방로','4','09:00','20:00','010-123-1234','배달가능',now());");
					for(int a=1;a<4;a++){
						System.out.println("INSERT INTO MENU VALUE("+sn+","+mn+",'메뉴 이름_"+mn+"');");
						for(int b=1;b<3;b++){
							System.out.println("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
							fn++;
						}
						mn++;
					}
					sn++;
					System.out.println("insert into STORE value("+prn+",null,1,'맛난거 파는 가게2_"+sn+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구 ','용봉로','77','09:25','20:30','010-123-1234','포장가능',now());");
					for(int a=1;a<4;a++){
						System.out.println("INSERT INTO MENU VALUE("+sn+","+mn+",'메뉴 이름_"+mn+"');");
						for(int b=1;b<3;b++){
							System.out.println("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
							fn++;
						}
						mn++;
					}
					sn++;
					System.out.println("insert into STORE value("+prn+",null,1,'맛난거 파는 가게3_"+sn+"번지','사용자_"+prn+"',"+c+",'어서오세요 고객님',default,default,default,default,default,'"+g+"','"+f+"','"+p2+"','광주광역시','북구','우치로','80','10:00','22:00','010-123-1234','NO',now());");
					for(int a=1;a<4;a++){
						System.out.println("INSERT INTO MENU VALUE("+sn+","+mn+",'메뉴 이름_"+mn+"');");
						for(int b=1;b<3;b++){
							System.out.println("INSERT INTO FOOD VALUE("+mn+","+fn+",'음식 이름_"+fn+"',"+b+1000+");");
							fn++;
						}
						mn++;
					}
				sn++;
				}
				for(int d=1;d<5;d++){
					for(int a = 1;a<6;a++){
						System.out.println("insert into BOARD(BOARD_INDEX,BOARD_SEQUENCE,BOARD_KIND,BOARD_WRITER,BOARD_SUBJECT,BOARD_CONTENT,BOARD_DATE) VALUE("+prn+","+bd+","+a+",'테스트유저_"+prn+"','테스트 중입니다_"+bn+"','@@ Insert by Data_inserter',now());");
						bn++;
					}
					bd++;
				}
		}
		System.out.println("insert into COMMENTS(COMMENTS_INDEX,COMMENTS_NUM,COMMENTS_WRITER,COMMENTS_SUBNUM) VALUE(1,1,'ADMIN',1);");
	} 
}
