package WhatEat.Utils;

import java.util.Set;

import org.reflections.Reflections;

import WhatEat.Admin.Admin_Path;
import WhatEat.Board.Board_Path;
import WhatEat.Food.Food_Path;
import WhatEat.Member.Member_Path;
import WhatEat.Mileage.Mileage_Path;
import WhatEat.Seller.Seller_Path;
import WhatEat.Star.Star_Path;
import WhatEat.Store.Store_Path;

	public class GetAnnObj {
		private static Reflections reflection = null;
		private static Set<Class<?>> list1 = null;
		private static Set<Class<?>> list2 = null;
		private static Set<Class<?>> list3 = null;
		private static Set<Class<?>> list4 = null;
		private static Set<Class<?>> list5 = null;
		private static Set<Class<?>> list6 = null;
		private static Set<Class<?>> list7 = null;
		private static Set<Class<?>> list8 = null;
		
		public static Object getObj(String command) { 
			if(command.contains("."))
				command = command.substring(0, command.lastIndexOf("."));
			makeRF(command.charAt(0)+(command.toLowerCase().substring(1)));
			try {
			//	System.out.println((command.substring(0,command.indexOf("_"))).toUpperCase());
			switch((command.substring(0,command.indexOf("_"))).toUpperCase()){
				case "BOARD" :
					if(list1 == null)
						list1 = reflection.getTypesAnnotatedWith(Board_Path.class);
					return makeObj(command,list1);
				case "COMMENTS" :
					if(list1 == null)
						list1 = reflection.getTypesAnnotatedWith(Board_Path.class);
					return makeObj(command,list1);
				case "MEMBER":
					if(list2 == null)
						list2 = reflection.getTypesAnnotatedWith(Member_Path.class);
					return makeObj(command,list2);
				case "STAR":
					if(list3 == null)
						list3 = reflection.getTypesAnnotatedWith(Star_Path.class);
					return makeObj(command,list3);
				case "FOOD":
					if(list4 == null)
						list4 = reflection.getTypesAnnotatedWith(Food_Path.class);
					return makeObj(command,list4);
				case "CATEGORY":
					if(list4 == null)
						list4 = reflection.getTypesAnnotatedWith(Food_Path.class);
					return makeObj(command,list4);
				case "MENU":
					if(list4 == null)
						list4 = reflection.getTypesAnnotatedWith(Food_Path.class);
					return makeObj(command,list4);
				case "SELLER":
					if(list5 == null)
						list5 = reflection.getTypesAnnotatedWith(Seller_Path.class);
					return makeObj(command,list5);
				case "MILEAGE":
					if(list6 == null)
						list6 = reflection.getTypesAnnotatedWith(Mileage_Path.class);
					return makeObj(command,list6);
				case "STORE":
					if(list7 == null)
						list7 = reflection.getTypesAnnotatedWith(Store_Path.class);
					return makeObj(command,list7);
				case "ADMIN":
					if(list8 == null)
						list8 = reflection.getTypesAnnotatedWith(Admin_Path.class);
					return makeObj(command,list8);
				case "INFO":
					if(list8 == null)
						list8 = reflection.getTypesAnnotatedWith(Admin_Path.class);
					return makeObj(command,list8);
				case "GRADE":
					if(list8 == null)
						list8 = reflection.getTypesAnnotatedWith(Admin_Path.class);
					return makeObj(command,list8);
				}
			} catch (Exception e) {
				System.out.println("GetAnnObj err : " + e.getMessage());
			}
			return null;
		}
		
		private static void makeRF(String command){ reflection = new Reflections("WhatEat."+command.substring(0,command.indexOf("_"))); }
		private static Object makeObj(String command,Set<Class<?>> list ){ String key = "";
			for (Class<?> cls : list) { key = cls.getCanonicalName(); if (command.equals(key.substring(key.lastIndexOf(".") + 1))) {
			try { return Class.forName(key).newInstance(); } catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) { e.printStackTrace(); } } } return null; }
	}