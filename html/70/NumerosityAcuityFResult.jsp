<jsp:include page="../../../login/header_forTest.jsp" flush="true"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.action.NumerosityAcuity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@page import="com.lattice.util.Calculate"%>
<%@page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<title><fmt:message key="jsp.menu.head"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" type="text/css">
<script language="javascript" src="<%=request.getContextPath()%>/js/Calendar30.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/prototype.js"></script>


</head>


<%
String targetpagename=request.getParameter("targetpagename");
System.out.println(targetpagename+":in NumerosityAcuityFResult.jsp");
NumerosityAcuityTestResult dotr=(NumerosityAcuityTestResult)request.getSession().getAttribute("NumerosityAcuityResult");
if(dotr==null)
{
	System.out.println("test result is null!");
	return;
}

%>


<body onload="checkSubmitted();">


<div class="main">
<div class="co">
<div class="last">



<div class="leftdiv" style="width:800px;">
<div class="divhead">&nbsp;&nbsp;&nbsp;</div>
<div class="leftcon">

<table width=800px>
	<tr>
		<td colspan=4>
			<div id="info_div" style="border-top:0px solid #AFAFAF;display:block;height=20px;width=100%;text-align:center;font-size:18px;color:black;"><fmt:message key="jsp.eachtest.successfulsubmission"/></div>
		</td>
	</tr>
	<tr>
		<td width=15%><fmt:message key="jsp.eachtest.Numerosityoftrial"/>：</td><td width=35%>60</td><td width=15%><fmt:message key="jsp.eachtest.testdate"/>：</td><td width=35%><%=dotr.getTesttime() %></td>
	</tr>
	<tr id="result_row" style="display:none;">
		<td width=15%><fmt:message key="jsp.eachtest.errorrate"/>：</td><td width=35%><%=dotr.getFailedRatio() %></td><td width=15%><fmt:message key="jsp.eachtest.resultdescribe"/>：</td><td width=35%><%=dotr.getDescrip() %></td>
	</tr>
</table>


<input type=hidden value="<%=request.getParameter("sumitcoids") %>" name="sumitcoids" id="sumitcoids"/>
<input type=hidden value="<%=targetpagename %>" name="targetpagename4" id="targetpagename4"/>


<table width=800px>
	<tr>
		<td>
			<input type="button" name="Submit" value=" <fmt:message key="jsp.eachtest.home"/> " class="anniu" onclick="upload_submit()">&nbsp;&nbsp;
			
		</td>
	</tr>
</table>


</div>
</div>

</div>
</div>
</div>

</body>

<script type="text/javascript">

var all_coids=new Array();

function upload_submit()
{
	//alert(document.getElementById("targetpagename4").value);
	
	window.location.href="../../../"+document.getElementById("targetpagename4").value;
	//window.location.href="../../../login/home.jsp";
	//document.getElementById("uploadForm").submit();
}

function display_other_coids()
{
	document.getElementById("other_coids_div").style.display="block";
}

function contains(value)
{
	for(var i=0;i<all_coids.length;i++)
	{
		if(all_coids[i]==value)
		{
			return true;
		}
	}
}

function add_or_remove_coid(cb)
{
	if(cb.checked)
	{
		if(contains(cb.value))
		{
			cb.checked=false;
			alert("不能同时选择一个集体！");
			return;
		}else
		{
			all_coids.push(cb.value);
		}
	}else
	{
		all_coids=all_coids.without(cb.value);
	}
	
	//alert(all_coids);//prototype method
	//alert(cb.value+cb.checked);
	
	//all_coids=all_coids.uniq();
	document.getElementById("coids").value=all_coids.join(";");
	//alert(document.getElementById("coids").value);	
}

function GetRequest()
{
	var url = location.search; 
	var theRequest = new Object();
	if(url.indexOf("?") != -1)
	{ 
		var str = url.substr(1);
	    strs = str.split("&");
	  	for(var i = 0; i < strs.length; i ++)
	    { 
	    	theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
	    }
	}
	return theRequest;
}

function checkSubmitted()
{
   var Request=new Object();
   Request=GetRequest();
   var userExist=Request['showresult'];
  // alert(userExist);
   if(userExist!=null&&userExist=="1")
   {
   		//alert(document.getElementById("info_div").style.display);
   		document.getElementById("result_row").style.display="block";
   }
}
</script>

</html>
<jsp:include page="../../../login/footer_new.jsp" flush="true"/>