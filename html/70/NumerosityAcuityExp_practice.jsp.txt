
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<title><fmt:message key="jsp.menu.head"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" type="text/css">

</head>


<%
Users u=(Users)request.getSession().getAttribute("cu");
String targetpagename=request.getParameter("targetpagename");
System.out.println(session.getAttribute("localeCfg"));
String lan=(String)session.getAttribute("localeCfg");
System.out.println(lan);
if(u==null)
{
	request.getSession().setAttribute("msg","<span style='color:red;'>请使用个人帐号！</span>");
	response.sendRedirect("/lattice/login/"+targetpagename);
	return;
}
Vector<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
if (ots.size()==0)
{
	response.sendRedirect("/lattice/"+targetpagename);
	return;	
}
Users cu=(Users)request.getSession().getAttribute("cu");
Collective cc=(Collective)request.getSession().getAttribute("cc");
//Judgment the money. 
// if ((cc.getAllmoney() - ots.get(0).getRateforcollective())<0){
// 	if ((cu.getAllmoney() - ots.get(0).getRateforindividual())<0){
// 		if (cc.getCotype().trim().equals("DefaultGroup")) {   
// 			response.sendRedirect("../../../lattice/couser/individualMoneyinformation.jsp?targetpagename="+targetpagename);
// 		}else{
// 			response.sendRedirect("../../../lattice/couser/CollectiveMoneyinformation.jsp?targetpagename="+targetpagename);
// 		}
// 		return;
// 	}
// }
cu.setCotype(cc.getCotype());
cu.setCoid(cc.getCoid());
request.getSession().setAttribute("cu",cu);
ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
	request.getSession().setAttribute("ot",ots.get(0));
%>

<jsp:include page="../../../login/header_forTest.jsp" flush="true"/>
<body>


<div class="main">
<div class="co">
<div class="last">



<div class="leftdiv" style="width:800px;">
<div class="divhead">&nbsp;&nbsp;&nbsp;</div>
<div class="leftcon">
<table width=800px>
	<tr>
		<td width=15%><fmt:message key="jsp.eachtest.testname"/>：</td><td width=35%><%=ots.get(0).getTaskname() %></td><td width=15%><fmt:message key="jsp.eachtest.testNumerosity"/>：</td><td width=35%><%=ots.get(0).getTasknumber()%></td>
	</tr>
	<tr>
		<td align=center colspan=4><fmt:message key="jsp.eachtest.testdescribe"/>：</td>
	</tr>
	<tr>
		<td  colspan=4><%=ots.get(0).getInstruction() %></td>
	</tr>
</table>

<table width=800px>
<tr>
	<td>
	<%
		if(cu==null||!cu.getRoleid().equals("0"))
		{%>
			
				<input type="button" name="Submit" value="<fmt:message key="jsp.eachtest.practise"/>" class="exp_anniu" onclick="check_time()">
		<%
		}else
		{
		%>
			
			
			<input type="button" name="Submit" value="<fmt:message key="jsp.eachtest.practise"/>" class="exp_anniu" onclick="check_time()">
		<%}
	%>
		
		
<!-- 		<input type="button" name="Submit" value=" 正式测验 " class="exp_anniu" onclick="alert('必须先进行<fmt:message key="jsp.eachtest.practise"/>才能进行正式测验！');return false;" >
	 --></td>
</tr>
</table>

<form id="checkForm" name="checkForm" method="post" action="/lattice/CheckTimeHandler">
<input type=hidden value="" name="coids" id="coids"/>
<input type=hidden value="<%=request.getParameter("taskid") %>" name="taskid" id="taskid"/>
<input type=hidden value="experiments/NumerosityAcuity/NumerosityAcuityTest.jsp" name="redirect" id="redirect"/>
<input type=hidden value="<%=request.getParameter("targetpagename") %>" name="targetpagename" id="targetpagename"/>
<input type=hidden value="<%=lan %>" name="lan" id="lan"/>

<form name="dotexp" method="post">
<input type=hidden value="" name="coids" id="coids"/>

<div id="other_coids_div" style="display:block;">
	<table width=800px>
	
	
<!-- 	
		<tr>
		<td><span class="message"><fmt:message
			key="jsp.MulDiv.codematerial" />：</span> 
			<input style="FONT-SIZE: 20px" value="1" id="codematerial" name="codematerial" type="text"
			/></td>
		</tr>	
 -->	
	
	
	
		<tr>
			<td colspan=8>
				<div id="list_div" style="border-top:0px solid #AFAFAF;height=20px;width=100%;text-align:center;font-size:15px;color:black;"><fmt:message key="jsp.eachtest.submit"/>：</div>
			</td>
		</tr>
		

		
		<tr>
			<td>
				<input onclick="get_all_coid();" checked type="checkbox" name="subtask" value="<%=cc.getCoid() %>" /><%=cc.getCoName() %>
			</td>
		</tr>


  

	
		
	</table>
</div>
</form>

</div>
</div>






</div>
</div>
</div>

</body>
<script type="text/javascript">

function check_role()
{
	alert("您不是普通用户，不可以做测验");
	
	
}

get_all_coid();//set all ids to the href
function get_all_coid()
{
	var temp=new Array();
	var sts=document.getElementsByName("subtask");
	
	for(var l=0;l<sts.length;l++)
	{
		if(sts[l].checked)
		{
			temp.push(sts[l].value);
		}
	}
	document.getElementById("test_href").setAttribute("href","NumerosityAcuityTest.jsp?sumitcoids="+temp.join(";"));
	//alert("dotTest.jsp?coids="+temp.join(";"));
	
}

function check_time()
{
	var temp=new Array();
	var sts=document.getElementsByName("subtask");
	
	for(var l=0;l<sts.length;l++)
	{
		if(sts[l].checked)
		{
			temp.push(sts[l].value);
		}
	}
	document.getElementById("coids").value=temp.join(";");
	//alert(document.getElementById("coids").value);
	document.getElementById("checkForm").submit();
	
	
}
</script>
</html>
