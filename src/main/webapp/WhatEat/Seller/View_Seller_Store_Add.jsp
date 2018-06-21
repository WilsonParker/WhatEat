<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*" %>
<%@page import="WhatEat.Data_source.*" %>
<%
	USER user = (USER)session.getAttribute("user");
%>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>매장 추가</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
    <script>
    $(document).ready(function(){
		if((!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))})&&(!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))})){
			alt();
			location.href= "./Home/View_Main.jsp";
		}
	})
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
             var a = "<br/>메뉴 이름 : <input type='text' placeholder='주류, 메인메뉴, 디저트' name='" + Mname + "'/>";
             var b = "<span style='border:1px solid black;cursor:pointer;' onclick='Del("+MdvName+")'>메뉴 삭제</span>&nbsp;<span style='border:1px solid black;cursor:pointer;' onclick='addFood(" + MdvName + ")'>음식 추가</span>";
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
        var a = "&nbsp;음식 이름 : <input type='text' placeholder='카라멜마끼아또' name=" + Fname + "/> 가격 : <input type='text' name=" + Fname2 + " size='6'/> 원";
        var b = "&nbsp;<div onclick='Del("+FdvName+")' style='display:inline;background-color:#BCE55C;width:20px;cursor:pointer;'>X</div>";
        $("#" + FdvName + "").html("<li>"+a+b+"</li>");
        count2++;
    }
    function Del(name) {
        $("#" + name.id + "").remove();
        count2++;
    }
    </script>
</head>
<body>
    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>매장 추가</h2>

            <hr/>

            <form action="<%=request.getContextPath()%>/Seller_Store_AddAction.co" method="post" id="STOREform" enctype="multipart/form-data">
                <input type="hidden" name="STORE_INDEX" value="${sessionScope.user.getINFO_INDEX() }" />
                <input type="hidden" name="STORE_SUBSCRIBER" value="${sessionScope.user.getINFO_NAME() }" />
                <input type="hidden" name="STORE_PATH" value="<%=ReadXml.getKeys("upLoadPath2") %>" />
        
                <h5 class="title">상점명</h5> <!--###이름 title###-->
                <div class="input"><input type="text" name="STORE_NAME" /></div>
      			
                <h5 class="title" >카테고리</h5> <!--###카테고리 title###-->
                <div id="clist">
                </div>
                
      			<br/>
                <h5 class="title" style="display:inline">메뉴 추가</h5>
                <div id="addMenu" style="display:inline;background-color:#BCE55C;width:20px;"> + </div> <br>
				<div id="menus"></div>
				
                <h5 class="title">사장님 한마디</h5> <!--###사장님 한마디 title###-->
                <textarea name="STORE_CONTENT" style="resize:none;min-width:400px;min-height:400px;"></textarea>
                
                <h5 class="title">매장 오픈시간</h5> <!--###매장 오픈시간 title###-->
                <input type="text" maxlength=2 name="STORE_OPENTIME1" placeholder="09"/> 시 
                <input type="text" maxlength=2 name="STORE_OPENTIME2" placeholder="30"/> 분
				
                <h5 class="title">매장 클로즈시간</h5> <!--###매장 클로즈시간 title###-->
                <input type="text" maxlength=2 name="STORE_CLOSETIME1" placeholder="20"/> 시
                <input type="text" maxlength=2 name="STORE_CLOSETIME2" placeholder="25"/> 분
                
                <h5 class="title">배달, 포장 여부</h5> <!--###배달, 포장 여부 title###-->
                <select name="STORE_PACKDELIVERY" >
                <option>NO</option>
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
                	<input type="text" maxlength=3 name="STORE_PHONE1" style="border:1px solid #cccccc; width:100px;"/> -
                	<input type="text" maxlength=4 name="STORE_PHONE2" style="border:1px solid #cccccc; width:100px;"/> -
                	<input type="text" maxlength=4 name="STORE_PHONE3" style="border:1px solid #cccccc; width:100px;"/>

                
                <h5 class="title">매장 주소</h5> <!--###주소 title###-->
                <h5 class="title">시/도/군</h5> 
                <div class="input"><input type="text" name="STORE_LOCATION1"/></div>
                <h5 class="title">구</h5>
                <div class="input"><input type="text" name="STORE_LOCATION2"/></div>
                <h5 class="title">동/로</h5>
                <div class="input"><input type="text" name="STORE_LOCATION3"/></div>
                <h5 class="title">건물 번호</h5>
                <div class="input"><input type="text" name="STORE_LOCATION4"/></div>

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