<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>视觉追踪</title>
	<style>
		#box .hide{
			display: none;
		}
		.reward{
			position: fixed;
			top:0px;left: 0px;
			right: 0px;
			bottom: 0px;
			background: #000;
			color: #fff;
			z-index: 9999;display: flex;
			align-items:center;
			justify-content:center;font-size: 28px;
		}
		.btn {
			display: inline-block;
			padding: 6px 24px;
			margin-bottom: 0;
			font-size: 1.5em;
			/*letter-spacing:0.4em;*/
			font-weight: 400;
			line-height: 1.42857143;
			text-align: center;
			white-space: nowrap;
			vertical-align: middle;
			-ms-touch-action: manipulation;
			touch-action: manipulation;
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
			background-image: none;
			border: 1px solid transparent;
			border-radius: 4px;
			color: #000;
			background-color: #fff;
			border-color: #fff;
		}
	</style>
	<SCRIPT src="../../../js/wz_jsgraphics/wz_jsgraphics.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/utils.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/jquery-1.8.2.min.js" type="text/javascript" ></SCRIPT>
	<SCRIPT src="../../../js/jquery-ui-1.9.1.custom.min.js" type="text/javascript" ></SCRIPT>
	<SCRIPT src="../../../js/progress_bar.js" type=text/javascript></SCRIPT> 	

<script type="text/javascript" defer="defer">




var table,row,cell1,cell2,cell0;
var i,j,k;
var x,y,z;
//var track_num=new Array([2,4,6],[2,4,6],[2,4,6],[2,4,6],[2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,6,10],[2,6,10],[2,6,10],[2,6,10]);
var row_num=new Array(8,8,8,8,10,10,10,10,12,12,12,12);
var pos=0;
var time_record=new Array(8);
var used_time=new Array(8);
//var answer=new Array([4,7,2],[4,7,2],[4,7,2],[4,7,2],[4,7,2],[4,7,2],[6,7,4],[4,8,1],[7,8,3],[7,6,3],[3,12,10],[6,9,8]);

var result=new Array([0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]);
var track_num=new Array([2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,5,8],[2,6,10],[2,6,10],[2,6,10],[2,6,10]);
var answer=new Array([6,7,4],[4,8,1],[7,8,3],[7,6,3],[1,5,6],[1,6,10],[5,7,9],[1,6,7],[3,12,10],[6,9,8],[2,4,9],[2,4,12]);

var right_num=0;
var end=0;
var TrialNumber=answer.length;

var correct_result=new Array();
var user_result=new Array();
var user_time= new Array();
var stimidAll =new Array();
var type4All =new Array();
var start_time;
var TrialNumber=2;


var track_num=new Array([2,4,6] [2,5,8]);
var row_num=new Array(7,8);
var pos=0;
var time_record=new Array(8);
var used_time=new Array(8);
var answer=new Array([4,7,2],[6,7,4]);

var track_num=new Array([2,4,6],[2,5,8]);
var answer=new Array([4,7,2],[3,6,5]);
var result=new Array([0,0,0],[0,0,0]);



setTimeout("end=1;init_task();",4*60*1000);

function init()
{
	var mydate=new Date();
	start_time=getTimestamp();
	time_record[pos]=mydate.getTime();

	table=document.getElementById('options');
	//清除表格&&记录result
		
		//换张图片
		document.getElementById("img").src="exer"+(pos+1)+".gif";
		//画表格
		for(i=0;i<row_num[pos];i++)
		{
			row=table.insertRow(i);
			cell0=row.insertCell(0);
			cell0.innerHTML='<div style=" background-color:#E3E3E3"><label><input type="radio" name="1" value="'+i+'" />'+track_num[pos][0]+'</label>&nbsp;&nbsp;'+
			'<label><input type="radio" name="2" value="'+i+'" />'+track_num[pos][1]+'</label>&nbsp;&nbsp;'+
			'<label><input type="radio" name="3" value="'+i+'" />'+track_num[pos][2]+'</label></div>';
		}
		pos++;	

}


function init_task()
{

	var mydate=new Date();
	time_record[pos]=mydate.getTime();
	table=document.getElementById('options');
	//清除表格&&记录result
	if(pos!=0)
	{
		x=document.getElementsByName("1");
		y=document.getElementsByName("2");
		z=document.getElementsByName("3");
		for(i=0;i<row_num[pos-1];i++)
		{

			if(x[i].checked==true)
				result[pos-1][0]=i+1;
			if(y[i].checked==true)
				result[pos-1][1]=i+1;
			if(z[i].checked==true)
				result[pos-1][2]=i+1;
		}
		//alert(result[pos-1][0]+" "+result[pos-1][1]+" "+result[pos-1][2]);

	}
	if ( (result[pos-1][0]>0 && result[pos-1][1]>0 && result[pos-1][2]>0) || (end==1) )
	{
		var cont=0;
		if(result[pos-1][0] === answer[pos-1][0]){
			cont++
		}
		if(result[pos-1][1] === answer[pos-1][1]){
			cont++
		}
		if(result[pos-1][2] === answer[pos-1][2]){
			cont++
		}
		if(cont === 1){
			$("#reward").text("做对1个");
			$("#reward").removeClass("hide");
			setTimeout("fkFun()",2000);
		}else if(cont === 2){
			$("#reward").text("做对2个");
			$("#reward").removeClass("hide");
			setTimeout("fkFun()",2000);
		}else if(cont === 2){
			$("#reward").text("3个全对");
			$("#reward").removeClass("hide");
			setTimeout("fkFun()",2000);
		}else {
			$("#reward").text("做对0个");
			$("#reward").removeClass("hide");
			setTimeout("fkFun()",2000);
		}
	}
}
function fkFun() {
	$("#reward").addClass("hide");
	if(pos==TrialNumber||end==1){
		$("#reward").text(" ");
		$("#reward").removeClass("hide");
		finish();
	}else {
		for(i=0;i<row_num[pos-1];i++){
			table.deleteRow(0);
		}
		//换张图片
		document.getElementById("img").src=""+(pos+1)+".gif";
		//画表格
		for(i=0;i<row_num[pos];i++)
		{
			row=table.insertRow(i);
			cell0=row.insertCell(0);
			cell0.innerHTML='<div style=" background-color:#E3E3E3"><label><input type="radio" name="1" value="'+i+'" />'+track_num[pos][0]+'</label>&nbsp;&nbsp;'+
					'<label><input type="radio" name="2" value="'+i+'" />'+track_num[pos][1]+'</label>&nbsp;&nbsp;'+
					'<label><input type="radio" name="3" value="'+i+'" />'+track_num[pos][2]+'</label></div>';
		}
		pos++;
	}
}
function finish()
{
	for(i=0;i<TrialNumber;i++)
	{	used_time[i]=time_record[i+1]-time_record[i];
		for(j=0;j<3;j++)
		{
			if(answer[i][j]==result[i][j])
			{	right_num++;}
			
			correct_result.push(result[i][j]);
			user_result.push(answer[i][j]);
			user_time.push(used_time[i]);
			type4All.push(0);
			stimidAll.push(i+1);			
		}
		//user_time.push(used_time[i]);
		//type4All.push(0);
		//stimidAll.push(i+1);
	}
	post_result();
}

/*
function finish()
{
	for(i=0;i<TrialNumber;i++)
	{	used_time[i]=time_record[i+1]-time_record[i];
		for(j=0;j<3;j++)
		{
			if(answer[i][j]==result[i][j])
			{	right_num++;}
			
			correct_result.push(result[i][j]);
			user_result.push(answer[i][j]);
		}
		user_time.push(used_time[i]);
		type4All.push(0);
		stimidAll.push(i+1);
	}
	post_result();
}
*/

function post_result()
{
	add_result("right_num",right_num);
	add_result("user_result", user_result.join(";"));
	add_result("user_time",user_time.join(";") );
	add_result("correct_result", correct_result.join(";"));
	
	var corrects=get_related_result(correct_result,user_result.length);
	///////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////
	var type4set=type4All.join(";");
	var stimidset=stimidAll.join(";");
	var correctanswerset= corrects.join(";")
	var radioset=user_result.join(";");
	var timeset=user_time.join(";");
	var timeaverage=getTimestamp()-start_time;
	add_result("type4set", type4set);
	add_result("stimidset",stimidset);
	add_result("correctanswerset",correctanswerset);
	add_result("radioset", radioset);
	add_result("timeset", timeset);
	add_result("timeaverage",timeaverage);
	var buttonset=""; 
	var numset="";
	var radiolist1set="";
	var radiolist2set="";
	var radiolist3set="";
	var radiolist4set="";
	var radiolist5set="";
	var radiolist6set="";
	var radiolist7set="";
	var radiolist8set="";
	var radiolist9set="";
	var radiolist10set="";
	if (corrects.length>1)
	{
		for (var i=0;i<corrects.length-1;i++)
		{
			buttonset=buttonset+";"+"";
			numset=numset+";"+"";
			radiolist1set=radiolist1set+";"+"";
			radiolist2set=radiolist2set+";"+"";
			radiolist3set=radiolist3set+";"+"";
			radiolist4set=radiolist4set+";"+"";
			radiolist5set=radiolist5set+";"+"";
			radiolist6set=radiolist6set+";"+"";
			radiolist7set=radiolist7set+";"+"";
			radiolist8set=radiolist8set+";"+"";
			radiolist9set=radiolist9set+";"+"";
			radiolist10set=radiolist10set+";"+"";
		}
	}	
	var countOfCorrectNumber_ByType=getCorrectCountSortByType(numset,correctanswerset,type4set);
	var countOfCorrectButton_ByType=getCorrectCountSortByType(buttonset,correctanswerset,type4set);
	var countOfCorrectRadio_ByType=getCorrectCountSortByType(radioset,correctanswerset,type4set);
	var countOfCorrectButton_ByType_Corrected=getCorrectCountSortByType_Corrected(buttonset,correctanswerset,type4set);
	var percentageCorrectNumber_ByType=getPercentageCorreceSortByType(numset,correctanswerset,type4set);
	var percentageCorrectButton_ByType=getPercentageCorreceSortByType(buttonset,correctanswerset,type4set);
	var percentageCorrectRadio_ByType=getPercentageCorreceSortByType(radioset,correctanswerset,type4set);
	var meanNumber_ByType=getMeanSortByType(numset,type4set);
	var sumNumber_ByType=getSumSortByType(numset,type4set);
	var meanRT_ByType=getMeanSortByType(timeset,type4set);
	var meanDeviationNumber_ByType=getMeanDeviationSortByType(numset,correctanswerset,type4set);
	var sumWeightedRadio_ByType=getWeightedScoreSortByType(radioset,type4set,radiolist1set,radiolist2set,radiolist3set,radiolist4set,radiolist5set,radiolist6set,radiolist7set,radiolist8set,radiolist9set,radiolist10set);
	var type4_Unique=getType(type4set);
	add_result("countOfCorrectNumber_ByType", countOfCorrectNumber_ByType);
	add_result("countOfCorrectButton_ByType", countOfCorrectButton_ByType);
	add_result("countOfCorrectRadio_ByType", countOfCorrectRadio_ByType);
	add_result("countOfCorrectButton_ByType_Corrected", countOfCorrectButton_ByType_Corrected);
	add_result("percentageCorrectNumber_ByType", percentageCorrectNumber_ByType);
	add_result("percentageCorrectButton_ByType", percentageCorrectButton_ByType);
	add_result("percentageCorrectRadio_ByType", percentageCorrectRadio_ByType);
	add_result("meanNumber_ByType", meanNumber_ByType);
	add_result("sumNumber_ByType", sumNumber_ByType);
	add_result("meanRT_ByType", meanRT_ByType);
	add_result("meanDeviationNumber_ByType", meanDeviationNumber_ByType);
	add_result("sumWeightedRadio_ByType", sumWeightedRadio_ByType);
	add_result("type4_Unique", type4_Unique);
	add_result("buttonset", buttonset);
	add_result("numset", numset);
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	document.getElementById("result").submit();	
}

function add_result(id, value)
{
   var elem = document.createElement("input");
   elem.setAttribute("type", "text");
   elem.setAttribute("id", id);
   elem.setAttribute("name", id);
   elem.setAttribute("value", value);
   document.getElementById("result").appendChild(elem);
}


function mvms(event)
{

	if(document.getElementById("img").offsetLeft<event.clientX&&document.getElementById("img").offsetTop<event.clientY&&event.clientX<document.getElementById("img").offsetLeft+500&&document.getElementById("img").offsetTop+432>event.clientY)
	{
		document.getElementById("img").style.visibility="hidden";
	}
	else 
		document.getElementById("img").style.visibility="visible";
}


</script>
</head>

<body id="box" bgcolor="#000000" onload="init()" >
<div id="reward" class="hide reward" style=""></div>
<form id="result" name="result" method="post" action="/lattice/OPESHandler?type=formal">
<input type=hidden value="4236" name="taskid" id="taskid"/>
<input type=hidden value="<%=request.getParameter("sumitcoids") %>" name="sumitcoids" id="sumitcoids"/>
<input type=hidden value="<%=request.getParameter("targetpagename") %>" name="targetpagename" id="targetpagename"/>
<input type=hidden value="VisualTracing" name="taskIdentifier" id="taskIdentifier"/>
<input type=hidden value="<%=request.getParameter("projectid") %>" name="projectid" id="projectid"/>
	
	</form>
 
<div align="center" onmousemove="mvms(event)">
<table  bgcolor="#FFFFFF"> 
	<tr>
		<td colspan="0"><img src="1.jpg" id="img" style=" position:relative"/></td>
		<td>
        	<table id="options" align="center" height="432" border="0">
            </table>
        </td>
	</tr>
</table>
<input class="btn" type="button" value="确定" onclick="init_task()" />
</div>
</body>


</html>
