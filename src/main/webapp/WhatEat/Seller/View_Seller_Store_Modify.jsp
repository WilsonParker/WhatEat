<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Store.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	STORE_Bean bean = (STORE_Bean) Main_DAO.getDAO().DetailCommand(new STORE_Bean(),Integer.parseInt(request.getParameter("index")));
	USER user = (USER) session.getAttribute("user");
	String[] open = bean.getSTORE_OPENTIME().split(":");
	String[] close = bean.getSTORE_CLOSETIME().split(":");
	String phone[] = {"0","0","0"};
	if(bean.getSTORE_PHONE() != null){
		String p[] = bean.getSTORE_PHONE().split("-");
		for(int c=0;c<phone.length;c++){
		phone[c] = p[c];		
		}
	}
	boolean cP = user != null?user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")): false;
%>

<html>
<head>
<title>매장 수정</title>
<link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
<script>
$(document).ready(function(){
	if((!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))})&&(!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))})){
		alt();
		location.href= "./Home/View_Main.jsp";
	}
	$(function(){
    	mk();
    	 var count = 1;
         $("#addMenu").on("click", function () {
        	  var dv = document.createElement("div");
              var Mname = "<%=ReadXml.getKeys("Food_Condition5")%>_" + count;
              var MdvName = "MDV_" + count;
             dv.setAttribute("id", MdvName);
             dv.setAttribute("style", "border:1px solid black");
             $("#menus").append(dv);
             var a = "<br/>메뉴 이름 : <input type='text' isN='1' placeholder='주류, 메인메뉴, 디저트' name='" + Mname + "'/>";
             var b = "<span style='border:1px solid black' onclick='Del("+MdvName+")'>메뉴 삭제</span>&nbsp;<span style='border:1px solid black' onclick='addFood(" + MdvName + ")'>음식 추가</span>";
             $("#" + MdvName + "").html(a + b);
             count++;
         })
    });
    function mk(){
		$.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/Food_Category_ListAction.co",
			data : {"isSelect" : 1},
			success : function(data) {
				$("#clist").html(data);
			}
		});
	}
    var count2 = 1;
    function addFood(name) {
    	var dv = document.createElement("div");
        var FdvName = "Fdv" + count2;
        var a = "<%=ReadXml.getKeys("Food_Condition6")%>";
        var a2 = "<%=ReadXml.getKeys("Food_Condition7")%>";
        var Fname = a+"_"+count2+"@"+name.id;
        var Fname2 = a2+"_"+count2+"@"+name.id;
        dv.setAttribute("id", FdvName);
        $("#" + name.id + "").append(dv);
        var a = "&nbsp;음식 이름 : <input type='text' isN='1' placeholder='카라멜마끼아또' name=" + Fname + "/> 가격 : <input type='text' name=" + Fname2 + " size='6'/> 원";
        var b = "&nbsp;<div onclick='Del("+FdvName+")' style='display:inline;background-color:#BCE55C;width:20px;'>X</div>";
        $("#" + FdvName + "").html("<li>"+a+b+"</li>");
        count2++;
    }
    function Del(name) {
        $("#" + name.id + "").remove();
        count2++;
    }
})
</script>
</head>
<body>

    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>매장 수정</h2>

            <hr/>

            <form action="<%=request.getContextPath()%>/Seller_Store_AddAction.co" method="post" id="STOREform" enctype="multipart/form-data">
        		<input type="hidden" name="STORE_NUM" value="<%=bean.getSTORE_NUM()%>" />
        		<input type="hidden" name="MENU_DELLIST" value="" />
        		<input type="hidden" name="MENU_MODLIST" value="" />
        		<input type="hidden" name="FOOD_DELLIIT" value="" />
        		<input type="hidden" name="FOOD_MODLIST" value="" />
        		
                <h5 class="title">상점명</h5> <!--###이름 title###-->
                <div class="input"><input type="text" name="STORE_NAME" value="<%=bean.getSTORE_NAME()%>"/></div>
      			
                <h5 class="title" >카테고리</h5> <!--###카테고리 title###-->
                <div id="clist">
                </div>
                
      			<br/>
                <h5 class="title" style="display:inline">메뉴 추가</h5>
                <div id="addMenu" style="display:inline;background-color:#BCE55C;width:20px;"> + </div> <br>
				<div id="menus"></div>
				
                <h5 class="title">사장님 한마디</h5> <!--###사장님 한마디 title###-->
                <textarea name="STORE_CONTENT" style="resize:none;min-width:400px;min-height:400px"><%=bean.getSTORE_CONTENT()%></textarea>
                
                <h5 class="title">매장 오픈시간</h5> <!--###매장 오픈시간 title###-->
                <input type="text" maxlength=2 name="STORE_OPENTIME1" placeholder="09" value="<%=open[0]%>"/> 시 
                <input type="text" maxlength=2 name="STORE_OPENTIME2" placeholder="30" value="<%=open[1]%>"/> 분
				
                <h5 class="title">매장 클로즈시간</h5> <!--###매장 클로즈시간 title###-->
                <input type="text" maxlength=2 name="STORE_CLOSETIME1" placeholder="20" value="<%=close[0]%>"/> 시
                <input type="text" maxlength=2 name="STORE_CLOSETIME2" placeholder="25" value="<%=close[1]%>"/> 분
                
                <h5 class="title">배달, 포장 여부</h5> <!--###배달, 포장 여부 title###-->
                <select name="STORE_PACKDELIVERY" >
                <option><%=bean.getSTORE_PACKDELIVERY()%></option>
                <option>배달 가능</option>
                <option>포장 가능</option>
                <option>배달,포장 가능</option>
                </select>
                <br/>
                <br/>
				
				<div style="font-family: 돋움; font-size: 12">
					<h5 class="title">프로필 이미지 첨부</h5>
					<input name="STORE_PROFILE" type="file" />
				</div>
				
				<div style="font-family: 돋움; font-size: 12">
					<h5 class="title">매장소개 이미지 첨부</h5>
					<input name="STORE_FILE" type="file" />
				</div>
				
                <h5 class="title">매장 연락처</h5> <!--###매장 연락처 title###-->
                	<input type="text" maxlength=3 name="STORE_PHONE1" style="border:1px solid #cccccc; width:100px;" value="<%=phone[0]%>"/> -
                	<input type="text" maxlength=4 name="STORE_PHONE2" style="border:1px solid #cccccc; width:100px;" value="<%=phone[0]%>"/> -
                	<input type="text" maxlength=4 name="STORE_PHONE3" style="border:1px solid #cccccc; width:100px;" value="<%=phone[0]%>"/>
                <!--매장 연락처 input-->

                <h5 class="title">매장 주소</h5> <!--###주소 title###-->
                <h5 class="title">시/도/군</h5> <!--###주소 title###-->
                <div class="input"><input type="text" name="STORE_LOCATION1" value="<%=bean.getSTORE_LOCATION1()%>"/></div><!--주소 input-->
                <h5 class="title">구</h5> <!--###주소 title###-->
                <div class="input"><input type="text" name="STORE_LOCATION2" value="<%=bean.getSTORE_LOCATION2()%>"/></div><!--주소 input-->
                <h5 class="title">동</h5> <!--###주소 title###-->
                <div class="input"><input type="text" name="STORE_LOCATION3" value="<%=bean.getSTORE_LOCATION3()%>"/></div><!--주소 input-->
                <h5 class="title">건물번호</h5> <!--###주소 title###-->
                <div class="input"><input type="text" name="STORE_LOCATION4" value="<%=bean.getSTORE_LOCATION4()%>"/></div><!--주소 input-->

                <!--###완료 title###-->
                <%if((user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller")) && user.getINFO_ADDSTORE_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))){%>
                <div class="submit_Button" onclick="javascript:STOREform.submit()" style="cursor:pointer">완료</div>
                <%} else{%>
                <div class="submit_Button" onclick="alt()" style="cursor:pointer">완료</div>
                <%} %>
            </form> 
                <div class="submit_Button" onclick="javascript:location.href='./Seller_Store_ListAction.co'" style="cursor:pointer">목록으로</div>
        </div>
        <div class="bottomPadding"></div>
    </div>
</body>
</html>