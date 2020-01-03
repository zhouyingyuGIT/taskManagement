<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><fmt:message key="jsp.menu.head"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<SCRIPT src="../../../js/wz_jsgraphics/wz_jsgraphics.js" type=text/javascript></SCRIPT>
<SCRIPT src="../../../js/utils.js" type=text/javascript></SCRIPT>

	<SCRIPT src="../../../js/wz_jsgraphics/wz_jsgraphics.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/utils.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
	<SCRIPT src="../../../js/jquery-1.8.2.min.js" type="text/javascript" ></SCRIPT>
	<SCRIPT src="../../../js/jquery-ui-1.9.1.custom.min.js" type="text/javascript" ></SCRIPT>
	<SCRIPT src="../../../js/progress_bar.js" type=text/javascript></SCRIPT> 

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/layout.css" type="text/css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" type="text/css"/>
<style type="text/css"> 

body {margin: 0px; background-color: #000000;cursor: url(../../images/empty.cur), auto;           }
 
span { font-family: Arial, Helvetica, sans-serif; font-size: 80pt; color: #ffffff; }
span.loading { font-family: Arial, Helvetica, sans-serif; font-size: 20pt; color: #ffffff; }
span.fixation { font-family: Arial, Helvetica, sans-serif; font-size: 80pt; color: #ffffff; }
span.message { top:35%; font-family: Arial, Helvetica, sans-serif; font-size: 25pt; color: #ffffff; }
span.addsubmildiv{ font-family: Arial, Helvetica, sans-serif; font-size: 80pt; color: #ffffff; }
span.asmdresult{ font-family: Arial, Helvetica, sans-serif; font-size: 50pt; color: #ffffff; }
.stroopnum_tip_div{	margin:0 auto;	background-color: #000000;	clear: both; 	align: center;	height: 30%;	width: 60%;	position: absolute;	left:20%;	top:35%;line-height:50px;		text-align: center;	font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 40px;	color: #FFFFFF;}
.stroopnum_relax_tips_div{		background-color: #000000;	clear: both; 	align: center;	height: 200px;	width: 40%;	position: absolute;	left:35%;	right:35%;	top:50%;	text-align: left;	font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 27px;	color: #FFFFFF;}

</style>
</head>
<body oncontextmenu="return false;" style="cursor: none" >
<form id="result" name="result" method="post" action="/lattice/OPESHandler?type=formal">
<input type=hidden value="70" name="taskid" id="taskid"/>
<input type=hidden value="<%=request.getParameter("sumitcoids") %>" name="sumitcoids" id="sumitcoids"/>
<input type=hidden value="<%=request.getParameter("targetpagename") %>" name="targetpagename" id="targetpagename"/>
<input type=hidden value="Numerosity40trials" name="taskIdentifier" id="taskIdentifier"/>
</form>

    <table height="85%" border=0px width="70%" border="0" align="center" >
            <tr>
                <td align="center" valign="middle">
                    <table cellspacing="0" border=0px cellpadding="0"  width="80%" align="center" border="0">
                        <tr>
							<td align=center height=100px colspan=2>
								<span id="loading" class="loading">
									<img name="imageObj" id="imageObj" src="../../../images/black_toosmall.jpg"/>
									<br/>
								</span>
								<span id="up_span" class="addsubmildiv">
								<img name="up_image" id="up_image" src="../../../images/black_toosmall.jpg"/>
								</span>
								<span id="message" class="message"></span>														
							</td>
						</tr>
						<tr>
							<td align=center height=80px>
								<span id="left_span" class="asmdresult"> 
								<img name="left_image" id="left_image" src="../../../images/black_toosmall.jpg"/>
								</span>
							</td>
							<td align=center height=80px>
								<span id="right_span" class="asmdresult"> 
									<img name="right_image" id="right_image" src="../../../images/black_toosmall.jpg"/>
								</span>
							</td>
						</tr>
                    </table>
                </td>
            </tr>
    </table>

 
<!-- 
<div class="left_test_tips_div" style="height=35px;bottom:0px;font-size: 20px;">
<br/>
左边包含结果，就用左手食指按Q/q键
</div>

<div class="right_test_tips_div" style="height=35px;bottom:0px;font-size: 20px;">
<br/>
右边包含结果，就用右手食指按P/p键
</div>
 -->

<div id="stroopnum_tip" style="display:none;" class="stroopnum_tip_div">
</div>
<div id="myCanvas" style="display:none;" class="stroopnum_relax_tips_div">
<br/>
  <fmt:message key="jsp.eachtest.rest"/>
</div>
    
  
<div id="feed_back_div" style="display:none;" class="stroopnum_relax_tips_div">

<span><img name="messageimageObj" id="messageimageObj" src="../../../images/black_toosmall.jpg"/></span>
</div> 

<!--张静远：增加了一个table-->
<table id="button_pq" height="15%" border=0px width="100%" border="0" cellspacing="60%" style="display:none;">
	<tr>
		<td align=left width="45%">
			<img name="button_q" id="img_Q" onclick="left_click()" src="../../../images/button_Q.png"/>
		</td>
		<td align=right width="45%">
			<img name="button_p" id="img_P" onclick="right_click()" src="../../../images/button_P.png"/>
		</td>
	</tr>
</table>
</body>
<script type="text/javascript">

var stroopnum_tips=document.getElementById("stroopnum_tip");
var pic_path="../../../testpics/NumerosityAcuity/";
var black_image="../../../images/black_toosmall.jpg";
var pleased_image="../../../images/pleased.JPG";
var depressed_image="../../../images/depressed.JPG";
var loading_image="../../../images/ajax-loader(2).gif";

/*
var simple_up=new Array("15a","30b","15dr","300ar","30d");
var simple_left=new Array("ar","br","dr","ar","dr");
var simple_right=new Array("a","b","d","a","d");
var simple_result=new Array("p","p","q","q","p");
*/
var stimidAll =new Array();
var type4All =new Array();
var simple_up=new Array("5_2500_d_1","10_5000_d_3","16_5000_d_1","10_5000_s_1","7_5000_s_6","12_5000_d_4","14_5000_s_2","6_2500_d_1","5_5000_s_4","6_5000_s_5","8_5000_s_6","16_5000_s_2","14_5000_d_1","8_2500_d_1","7_2500_d_2","12_5000_s_1","6_3000_d_1","10_5000_d_4","20_5000_s_7","10_5000_s_4","15_5000_s_6","25_5000_s_1","6_5000_s_8","9_5000_s_3","12_3000_d_2","9_3000_d_1","15_5000_s_1","15_3000_d_2","15_5000_d_2","25_5000_d_1","20_5000_d_1","12_5000_s_3","5_3571_d_1","7_5000_d_2","20_5000_s_1","14_5000_s_4","17_5000_s_1","14_3500_d_2","7_3500_d_1","10_5000_s_2","7_5000_s_7","12_5000_s_8","17_5000_d_1","12_3529_d_2","5_5000_s_5","20_5000_d_2","7_5000_s_4","10_5000_d_7","6_3750_d_1","8_5000_d_2","12_5000_s_11","12_3750_d_2","9_5000_s_2","6_5000_s_2","15_5000_s_3","15_3750_d_2","16_5000_d_2","8_5000_s_5","20_5000_d_3","9_3750_d_1","12_5000_s_10","16_5000_s_1","12_5000_d_5","20_5000_s_8","24_5000_d_1","10_5000_s_3","24_5000_s_3","20_5000_s_2","6_5000_d_2","12_5000_d_6","20_4167_d_2","5_4167_d_1","18_5000_s_2","10_4167_d_1","15_4167_d_2","12_5000_s_12","6_5000_s_7","5_5000_s_3","15_5000_s_4","18_5000_d_1","7_4375_d_1","8_5000_d_7","21_4375_d_2","24_5000_d_2","17_5000_s_1","19_5000_s_2","8_5000_s_4","19_5000_d_1","7_5000_s_1","21_5000_s_1","14_4375_d_1","16_5000_d_6","14_5000_s_4","24_5000_s_4","16_5000_s_6","17_4375_d_2");
var simple_result=new Array("p","q","q","q","p","q","q","p","p","p","p","q","q","p","p","q","p","q","q","q","p","q","p","p","p","p","q","p","q","q","q","p","p","q","q","p","q","p","p","q","p","p","q","p","p","q","q","q","p","q","q","p","p","p","p","p","q","q","q","p","p","q","q","q","q","p","q","p","q","q","p","p","q","p","p","q","q","p","p","q","p","q","p","q","p","q","q","q","p","p","p","q","p","q","q","p"); 
var simple_left=new Array("5_2500_d_1","10_5000_d_3","16_5000_d_1","10_5000_s_1","7_5000_s_6","12_5000_d_4","14_5000_s_2","6_2500_d_1","5_5000_s_4","6_5000_s_5","8_5000_s_6","16_5000_s_2","14_5000_d_1","8_2500_d_2","7_2500_d_2","12_5000_s_1","6_3000_d_1","10_5000_d_4","20_5000_s_7","10_5000_s_4","15_5000_s_6","25_5000_s_1","6_5000_s_8","9_5000_s_3","12_3000_d_2","9_3000_d_1","15_5000_s_1","15_3000_d_2","15_5000_d_2","25_5000_d_1","20_5000_d_1","12_5000_s_3","5_3571_d_1","7_5000_d_2","20_5000_s_1","14_5000_s_4","17_5000_s_1","14_3500_d_2","7_3500_d_1","10_5000_s_2","7_5000_s_7","12_5000_s_8","17_5000_d_1","12_3529_d_2","5_5000_s_5","20_5000_d_2","7_5000_s_4","10_5000_d_7","6_3750_d_1","8_5000_d_2","12_5000_s_11","12_3750_d_2","9_5000_s_2","6_5000_s_2","15_5000_s_3","15_3750_d_2","16_5000_d_2","8_5000_s_5","20_5000_d_3","9_3750_d_1","12_5000_s_10","16_5000_s_1","12_5000_d_5","20_5000_s_8","24_5000_d_1","10_5000_s_3","24_5000_s_3","20_5000_s_2","6_5000_d_2","12_5000_d_6","20_4167_d_2","5_4167_d_1","18_5000_s_2","10_4167_d_1","15_4167_d_2","12_5000_s_12","6_5000_s_7","5_5000_s_3","15_5000_s_4","18_5000_d_1","7_4375_d_1","8_5000_d_7","21_4375_d_2","24_5000_d_2","17_5000_s_1","19_5000_s_2","8_5000_s_4","19_5000_d_1","7_5000_s_1","21_5000_s_1","14_4375_d_1","16_5000_d_6","14_5000_s_4","24_5000_s_4","16_5000_s_6","17_4375_d_2");
var simple_right=new Array("10_5000_d_1","5_2500_d_2","8_2500_d_1","5_5000_s_1","14_5000_s_5","6_2500_d_2","7_5000_s_2","12_5000_d_1","10_5000_s_5","12_5000_s_7","16_5000_s_5","8_5000_s_3","7_2500_d_1","16_5000_d_4","14_5000_d_2","6_5000_s_1","10_5000_d_2","6_3000_d_2","12_5000_s_9","6_5000_s_4","25_5000_s_2","15_5000_s_2","10_5000_s_8","15_5000_s_5","20_5000_d_4","15_5000_d_1","9_5000_s_1","25_5000_d_2","9_3000_d_2","15_3000_d_1","12_3000_d_1","20_5000_s_3","7_5000_d_1","5_3571_d_2","14_5000_s_1","20_5000_s_5","12_5000_s_2","20_5000_d_5","10_5000_d_6","7_5000_s_3","10_5000_s_6","17_5000_s_3","12_3529_d_1","17_5000_d_2","7_5000_s_8","14_3500_d_1","5_5000_s_2","7_3500_d_2","8_5000_d_1","6_3750_d_2","9_5000_s_4","16_5000_d_5","12_5000_s_5","8_5000_s_2","20_5000_s_4","20_5000_d_6","12_3750_d_1","6_5000_s_6","15_3750_d_1","12_5000_d_2","16_5000_s_4","12_5000_s_4","9_3750_d_2","15_5000_s_7","20_4167_d_1","12_5000_s_6","20_5000_s_6","24_5000_s_1","5_4167_d_2","10_4167_d_2","24_5000_d_3","6_5000_d_1","15_5000_s_8","12_5000_d_3","18_5000_d_2","10_5000_s_7","5_5000_s_6","6_5000_s_3","18_5000_s_1","15_4167_d_1","8_5000_d_6","7_4375_d_2","24_5000_d_4","21_4375_d_1","19_5000_s_1","17_5000_s_4","7_5000_s_5","17_4375_d_1","8_5000_s_1","24_5000_s_2","16_5000_d_3","14_4375_d_2","16_5000_s_3","21_5000_s_2","14_5000_s_6","19_5000_d_2"); 

var simple_result=new Array("p","q","q","p","q","p","q","p","q","q","p","p","p","q","p","q","p","q","q","p","q","p","q","q","p","q","p","q","p","p","p","q","p","p","q","p","q","p","q","q","p","p","q","q","p","q","p","p","p","q","q","p","q","p","p","q","q","q","p","q","q","q","p","q","q","p","p","p","p","p","q","q","p","p","q","q","q","p","q","p","q","q","q","q","p","p","p","q","p","q","p","p","p","q","p","q","p","q","q","p","p","q","q","q","p","p","p","q","p","q","q","q","p","q","p","p","p","p","q","q"); 
var simple_up=new Array("5_5000_s_4","14_5000_d_1","14_5000_s_2","8_2500_d_2","10_5000_s_1","6_2500_d_1","18_5000_s_11","5_2500_d_1","16_5000_d_1","18_5000_d_11","9_5000_s_10","7_2500_d_2","7_5000_s_6","16_5000_s_2","6_5000_s_5","10_5000_d_3","8_5000_s_6","12_5000_d_4","12_5000_s_1","9_2500_d_10","15_5000_s_1","6_3000_d_1","20_5000_s_7","20_5000_d_1","12_5000_s_3","10_5000_d_4","18_3000_d_10","30_5000_d_11","9_3000_d_1","15_5000_s_6","6_5000_s_8","30_5000_s_11","15_3000_d_2","12_3000_d_2","25_5000_d_1","18_5000_s_12","25_5000_s_1","9_5000_s_3","10_5000_s_4","15_5000_d_2","5_3571_d_1","14_3500_d_2","7_5000_s_4","17_5000_d_1","16_5000_s_10","23_5000_d_11","7_5000_s_7","16_3478_d_10","12_3529_d_2","10_5000_d_7","17_5000_s_1","7_3500_d_1","20_5000_d_2","14_5000_s_4","12_5000_s_8","7_5000_d_2","10_5000_s_2","23_5000_s_11","5_5000_s_5","20_5000_s_1","12_5000_d_5","24_5000_s_11","6_5000_s_2","20_5000_s_8","8_5000_s_5","6_3750_d_1","9_3750_d_1","18_5000_s_14","12_5000_s_10","12_3750_d_2","16_5000_d_2","16_5000_s_1","18_3750_d_10","9_5000_s_2","8_5000_d_2","20_5000_d_3","24_5000_d_11","15_5000_s_3","12_5000_s_11","15_3750_d_2","6_5000_s_7","18_5000_s_2","24_5000_d_1","12_5000_s_12","10_5000_s_3","25_4167_d_10","20_4167_d_2","18_5000_d_1","10_4167_d_1","30_5000_s_13","15_4157_d_2","15_5000_s_4","20_5000_s_2","12_5000_d_6","5_4167_d_1","6_5000_d_2","5_5000_s_3","24_5000_s_3","30_5000_d_13","25_5000_s_10","7_4375_d_1","8_5000_d_7","24_5000_d_2","19_5000_s_2","17_4375_d_2","28_4375_d_10","21_5000_s_1","16_5000_d_6","28_5000_s_10","8_5000_s_4","32_5000_s_11","19_5000_d_1","14_5000_s_4","16_5000_s_6","14_4375_d_1","21_4375_d_2","17_5000_s_1","7_5000_s_1","24_5000_s_4","32_5000_d_11");
var simple_left=new Array("5_5000_s_4","14_5000_d_1","14_5000_s_2","8_2500_d_2","10_5000_s_1","6_2500_d_1","18_5000_s_11","5_2500_d_1","16_5000_d_1","18_5000_d_11","9_5000_s_10","7_2500_d_2","7_5000_s_6","16_5000_s_2","6_5000_s_5","10_5000_d_3","8_5000_s_6","12_5000_d_4","12_5000_s_1","9_2500_d_10","15_5000_s_1","6_3000_d_1","20_5000_s_7","20_5000_d_1","12_5000_s_3","10_5000_d_4","18_3000_d_10","30_5000_d_11","9_3000_d_1","15_5000_s_6","6_5000_s_8","30_5000_s_11","15_3000_d_2","12_3000_d_2","25_5000_d_1","18_5000_s_12","25_5000_s_1","9_5000_s_3","10_5000_s_4","15_5000_d_2","5_3571_d_1","14_3500_d_2","7_5000_s_4","17_5000_d_1","16_5000_s_10","23_5000_d_11","7_5000_s_7","16_3478_d_10","12_3529_d_2","10_5000_d_7","17_5000_s_1","7_3500_d_1","20_5000_d_2","14_5000_s_4","12_5000_s_8","7_5000_d_2","10_5000_s_2","23_5000_s_11","5_5000_s_5","20_5000_s_1","12_5000_d_5","24_5000_s_11","6_5000_s_2","20_5000_s_8","8_5000_s_5","6_3750_d_1","9_3750_d_1","18_5000_s_14","12_5000_s_10","12_3750_d_2","16_5000_d_2","16_5000_s_1","18_3750_d_10","9_5000_s_2","8_5000_d_2","20_5000_d_3","24_5000_d_11","15_5000_s_3","12_5000_s_11","15_3750_d_2","6_5000_s_7","18_5000_s_2","24_5000_d_1","12_5000_s_12","10_5000_s_3","25_4167_d_10","20_4167_d_2","18_5000_d_1","10_4167_d_1","30_5000_s_13","15_4157_d_2","15_5000_s_4","20_5000_s_2","12_5000_d_6","5_4167_d_1","6_5000_d_2","5_5000_s_3","24_5000_s_3","30_5000_d_13","25_5000_s_10","7_4375_d_1","8_5000_d_7","24_5000_d_2","19_5000_s_2","17_4375_d_2","28_4375_d_10","21_5000_s_1","16_5000_d_6","28_5000_s_10","8_5000_s_4","32_5000_s_11","19_5000_d_1","14_5000_s_4","16_5000_s_6","14_4375_d_1","21_4375_d_2","17_5000_s_1","7_5000_s_1","24_5000_s_4","32_5000_d_11");
var simple_right=new Array("10_5000_s_5","7_2500_d_1","7_5000_s_2","16_5000_d_4","5_5000_s_1","12_5000_d_1","9_5000_s_11","10_5000_d_1","8_2500_d_1","9_2500_d_11","18_5000_s_10","14_5000_d_2","14_5000_s_5","8_5000_s_3","12_5000_s_7","5_2500_d_2","16_5000_s_5","6_2500_d_2","6_5000_s_5","18_5000_d_10","9_5000_s_1","10_5000_d_2","12_5000_s_9","12_3000_d_1","20_5000_s_3","6_3000_d_2","30_5000_d_10","18_3000_d_11","15_5000_d_1","25_5000_s_2","10_5000_s_8","18_5000_s_13","25_5000_d_2","20_5000_d_4","15_3000_d_1","30_5000_s_10","15_5000_s_2","15_5000_s_5","6_5000_s_4","9_3000_d_2","7_5000_d_1","20_5000_d_5","5_5000_s_2","12_3529_d_1","23_5000_s_10","16_3478_d_11","10_5000_s_6","23_5000_d_10","17_5000_d_2","7_3500_d_2","12_5000_s_2","10_5000_d_6","14_3500_d_1","20_5000_s_5","17_5000_s_3","5_3571_d_2","7_5000_s_3","16_5000_s_11","7_5000_s_8","14_5000_s_1","9_3750_d_2","18_5000_s_15","8_5000_s_2","15_5000_s_7","6_5000_s_6","8_5000_d_1","12_5000_d_2","24_5000_s_10","16_5000_s_4","16_5000_d_5","12_3750_d_1","12_5000_s_4","24_5000_d_10","12_5000_s_5","6_3750_d_2","15_3750_d_1","18_3750_d_11","20_5000_s_4","9_5000_s_4","20_5000_d_6","5_5000_s_6","15_5000_s_8","20_4167_d_1","10_5000_s_7","12_5000_s_6","30_5000_d_12","24_5000_d_3","15_4157_d_1","12_5000_d_3","25_5000_s_11","18_5000_d_2","18_5000_s_1","24_5000_s_1","10_4167_d_2","6_5000_d_1","5_4167_d_2","6_5000_s_3","20_5000_s_6","25_4167_d_11","30_5000_s_12","8_5000_d_6","7_4375_d_2","21_4375_d_1","17_5000_s_4","19_5000_d_2","32_5000_d_10","24_5000_s_2","14_4375_d_2","32_5000_s_10","7_5000_s_5","28_5000_s_11","17_4375_d_1","16_5000_s_3","14_5000_s_6","16_5000_d_3","24_5000_d_4","19_5000_s_1","8_5000_s_1","21_5000_s_2","28_4375_d_11"); 

//Not clear 
/*"WebContent/testpics/VisualPerception"
var simple_up=new Array("5_5000_s_4","23_5000_s_11","5_4167_d_1","17_5000_s_1","9_3000_d_1","6_5000_s_5","21_4375_d_2","9_3750_d_1","18_3000_d_10","9_5000_s_10","20_5000_d_2","16_3478_d_10","20_5000_d_1","7_5000_s_4","8_5000_s_5","15_4157_d_2","6_5000_s_8","8_5000_d_7","14_5000_d_1","18_5000_s_11","6_5000_s_2","8_5000_s_4","23_5000_d_11","16_5000_s_6","17_4375_d_2","14_5000_s_4","12_5000_s_3","15_5000_s_6","15_5000_s_1","10_5000_s_3","19_5000_s_2","15_3750_d_2","25_5000_s_1","19_5000_d_1","10_5000_d_7","28_5000_s_10","18_5000_s_12","12_3000_d_2","25_5000_s_10","28_4375_d_10","8_5000_d_2","10_5000_s_1","16_5000_s_1","5_5000_s_5","6_2500_d_1","17_5000_s_1","30_5000_d_13","12_5000_d_4","20_5000_d_3","10_5000_s_2","16_5000_d_1","7_5000_s_6","16_5000_d_6","24_5000_d_1","12_5000_s_1","24_5000_s_4","12_3529_d_2","6_3000_d_1","10_5000_d_4","16_5000_s_10","21_5000_s_1","12_5000_s_10","24_5000_s_3","7_4375_d_1","20_5000_s_2","6_5000_d_2","6_3750_d_1","20_5000_s_7","9_2500_d_10","32_5000_d_11","16_5000_s_2","7_5000_s_7","9_5000_s_2","30_5000_d_11","25_5000_d_1","7_3500_d_1","14_4375_d_1","5_5000_s_3","12_5000_d_6","17_5000_d_1","16_5000_d_2","8_2500_d_2","12_5000_s_12","20_4167_d_2","30_5000_s_11","18_5000_s_2","15_5000_d_2","6_5000_s_7","30_5000_s_13","15_5000_s_3","7_5000_d_2","10_4167_d_1","7_5000_s_1","18_3750_d_10","24_5000_d_2","32_5000_s_11","9_5000_s_3","14_5000_s_2","10_5000_s_4","24_5000_d_11","7_2500_d_2","18_5000_s_14","12_3750_d_2","10_5000_d_3","14_5000_s_4","8_5000_s_6","20_5000_s_8","15_5000_s_4","14_3500_d_2","24_5000_s_11","15_3000_d_2","18_5000_d_1","20_5000_s_1","12_5000_s_11","12_5000_d_5","25_4167_d_10","12_5000_s_8","18_5000_d_11","5_3571_d_1","5_2500_d_1");
var correct_result=new Array("P","Q","P","P","P","P","P","P","P","P","Q","P","Q","Q","Q","P","P","Q","Q","Q","P","Q","Q","Q","P","P","P","P","Q","P","Q","P","Q","Q","Q","P","P","P","P","P","Q","Q","Q","P","P","Q","Q","Q","Q","Q","Q","P","Q","Q","Q","Q","P","P","Q","P","P","P","Q","P","P","Q","P","Q","P","Q","Q","P","P","Q","Q","P","P","P","Q","Q","Q","P","Q","P","Q","Q","Q","Q","Q","P","Q","P","P","P","Q","Q","P","Q","Q","Q","P","P","P","Q","P","P","Q","P","P","Q","P","Q","Q","Q","Q","P","P","Q","P","P"); 
var left=new Array("5_5000_s_4","23_5000_s_11","5_4167_d_1","17_5000_s_1","9_3000_d_1","6_5000_s_5","21_4375_d_2","9_3750_d_1","18_3000_d_10","9_5000_s_10","20_5000_d_2","16_3478_d_10","20_5000_d_1","7_5000_s_4","8_5000_s_5","15_4157_d_2","6_5000_s_8","8_5000_d_7","14_5000_d_1","18_5000_s_11","6_5000_s_2","8_5000_s_4","23_5000_d_11","16_5000_s_6","17_4375_d_2","14_5000_s_4","12_5000_s_3","15_5000_s_6","15_5000_s_1","10_5000_s_3","19_5000_s_2","15_3750_d_2","25_5000_s_1","19_5000_d_1","10_5000_d_7","28_5000_s_10","18_5000_s_12","12_3000_d_2","25_5000_s_10","28_4375_d_10","8_5000_d_2","10_5000_s_1","16_5000_s_1","5_5000_s_5","6_2500_d_1","17_5000_s_1","30_5000_d_13","12_5000_d_4","20_5000_d_3","10_5000_s_2","16_5000_d_1","7_5000_s_6","16_5000_d_6","24_5000_d_1","12_5000_s_1","24_5000_s_4","12_3529_d_2","6_3000_d_1","10_5000_d_4","16_5000_s_10","21_5000_s_1","12_5000_s_10","24_5000_s_3","7_4375_d_1","20_5000_s_2","6_5000_d_2","6_3750_d_1","20_5000_s_7","9_2500_d_10","32_5000_d_11","16_5000_s_2","7_5000_s_7","9_5000_s_2","30_5000_d_11","25_5000_d_1","7_3500_d_1","14_4375_d_1","5_5000_s_3","12_5000_d_6","17_5000_d_1","16_5000_d_2","8_2500_d_2","12_5000_s_12","20_4167_d_2","30_5000_s_11","18_5000_s_2","15_5000_d_2","6_5000_s_7","30_5000_s_13","15_5000_s_3","7_5000_d_2","10_4167_d_1","7_5000_s_1","18_3750_d_10","24_5000_d_2","32_5000_s_11","9_5000_s_3","14_5000_s_2","10_5000_s_4","24_5000_d_11","7_2500_d_2","18_5000_s_14","12_3750_d_2","10_5000_d_3","14_5000_s_4","8_5000_s_6","20_5000_s_8","15_5000_s_4","14_3500_d_2","24_5000_s_11","15_3000_d_2","18_5000_d_1","20_5000_s_1","12_5000_s_11","12_5000_d_5","25_4167_d_10","12_5000_s_8","18_5000_d_11","5_3571_d_1","5_2500_d_1");
var right=new Array("10_5000_s_5","16_5000_s_11","6_5000_d_1","19_5000_s_1","15_5000_d_1","12_5000_s_7","24_5000_d_4","12_5000_d_2","30_5000_d_10","18_5000_s_10","14_3500_d_1","23_5000_d_10","12_3000_d_1","5_5000_s_2","6_5000_s_6","18_5000_d_2","10_5000_s_8","7_4375_d_2","7_2500_d_1","9_5000_s_11","8_5000_s_2","7_5000_s_5","16_3478_d_11","14_5000_s_6","19_5000_d_2","16_5000_s_3","20_5000_s_3","25_5000_s_2","9_5000_s_1","12_5000_s_6","17_5000_s_4","20_5000_d_6","15_5000_s_2","17_4375_d_1","7_3500_d_2","32_5000_s_10","30_5000_s_10","20_5000_d_4","30_5000_s_12","32_5000_d_10","6_3750_d_2","5_5000_s_1","12_5000_s_4","7_5000_s_8","12_5000_d_1","12_5000_s_2","25_4167_d_11","6_2500_d_2","15_3750_d_1","7_5000_s_3","8_2500_d_1","14_5000_s_5","14_4375_d_2","20_4167_d_1","6_5000_s_1","21_5000_s_2","17_5000_d_2","10_5000_d_2","6_3000_d_2","23_5000_s_10","24_5000_s_2","16_5000_s_4","20_5000_s_6","8_5000_d_6","24_5000_s_1","5_4167_d_2","8_5000_d_1","12_5000_s_9","18_5000_d_10","28_4375_d_11","8_5000_s_3","10_5000_s_6","12_5000_s_5","18_3000_d_11","15_3000_d_1","10_5000_d_6","16_5000_d_3","6_5000_s_3","10_4167_d_2","12_3529_d_1","12_3750_d_1","16_5000_d_4","10_5000_s_7","24_5000_d_3","18_5000_s_13","15_5000_s_8","9_3000_d_2","5_5000_s_6","25_5000_s_11","20_5000_s_4","5_3571_d_2","12_5000_d_3","8_5000_s_1","24_5000_d_10","21_4375_d_1","28_5000_s_11","15_5000_s_5","7_5000_s_2","6_5000_s_4","18_3750_d_11","14_5000_d_2","24_5000_s_10","16_5000_d_5","5_2500_d_2","20_5000_s_5","16_5000_s_5","15_5000_s_7","18_5000_s_1","20_5000_d_5","18_5000_s_15","25_5000_d_2","15_4157_d_1","14_5000_s_1","9_5000_s_4","9_3750_d_2","30_5000_d_12","17_5000_s_3","9_2500_d_11","7_5000_d_1","10_5000_d_1"); 
*/

//for debug
/*
var target=new Array(new Array("10_5000_d_3","8_5000_s_6","10_5000_s_4","12_3000_d_2","7_5000_d_2","7_5000_s_7","6_5000_s_2","16_5000_d_2"));
var left=new Array(new Array("10_5000_d_3","8_5000_s_6","10_5000_s_4","12_3000_d_2","7_5000_d_2","7_5000_s_7","6_5000_s_2","16_5000_d_2")); 
var right=new Array(new Array("5_2500_d_2","16_5000_s_5","6_5000_s_4","20_5000_d_4","5_3571_d_2","10_5000_s_6","8_5000_s_2","12_3750_d_1"));
var correct_result=new Array(new Array("Q","P","Q","P","Q","P","P","Q"));
*/


/*
var simple_up=new Array("15c");
var simple_left=new Array("cr");
var simple_right=new Array("c");
var simple_result=new Array("p");
*/

var complex_up=new Array();
var complex_left=new Array();
var complex_right=new Array();
var complex_result=new Array();

//Simple：
var simple_up_images=new Array();
var simple_left_images=new Array();
var simple_right_images=new Array();
//Complex：
var complex_up_images=new Array();
var complex_left_images=new Array();
var complex_right_images=new Array();
//complex
var complex_result_images=new Array();
//Simple
var simple_result_images=new Array();

var progress = 0;//loading images progress

var correct_result ;//
var user_result=new Array();
var rc_key = new Array();
var rc_time = new Array();
var user_time= new Array();
 
var timer_id;
var index = 0;
var trial_interval = 300; // interval between trials in ms
var key_interval = 1000; // interval after key press in ms
var fixation_interval = 400; // 
var blank_interval = 1000; //
var short_blank_interval = 500; // 
var relax_interval=2000;
var feedback_interval=2000;// feedback time
var ifinite_wait_interval=40000000;
var start_delay = 1000; // in ms
var undef_key = "undef";
var undef_time = trial_interval;
var timestamp;

var jg = new jsGraphics("myCanvas");
var midle_relax_interval=1000;//
var progressbar=0;//
var bar_length=300;//
var update_interval=midle_relax_interval/bar_length;//
var current_index=0;
var current_start_time=getTimestamp();
var ristrict_time=20*60*1000;
//var ristrict_time=0.2*60*1000;

//for debug
var relax_point=new Array("60","80");

var all_a;


//Order of stimulus
var tempArray2 = new Array();





function preloadimages()
{

	
	simple_up=randomOrder(simple_up);

	progress=0;
  //for (i=0;i<simple_up.length;i++)
  for (i=0;i<simple_up.length;i++)	  
  {
    simple_up_images[i]=new Image();
    simple_left_images[i]=new Image();
    simple_right_images[i]=new Image();
	simple_up_images[i].onload=function()
    {
		progress+=1;
		if (progress==simple_up.length)
		{
  			setTimeout("wait_to_start()",0);	
		}else
		{
			setTimeout("show_load_image_progress("+Math.round(progress/simple_up.length*100)+")",0);
		}	
	}
    simple_up_images[i].src=pic_path+simple_up[i]+".gif";
    simple_left_images[i].src=pic_path+simple_left[i]+".gif";
    simple_right_images[i].src=pic_path+simple_right[i]+".gif";
  }
}


var index;		
//让数组中的数字按照要求随机排列

//随机改变数组的排序
function randomOrder (targetArray){
	var arrayLength = targetArray.length
	//
	//先创建一个正常顺序的数组
	var tempArray1 = new Array();
	
	for (var i = 0; i < arrayLength; i ++)
	{  
	    tempArray1 [i] = i
	}
	//
	//再根据上一个数组创建一个随机乱序的数组

	
	for (var i = 0; i < arrayLength; i ++)
	{
	    //从正常顺序数组中随机抽出元素
	    tempArray2 [i] = tempArray1.splice (Math.floor (Math.random () * tempArray1.length) , 1)
	}
	
	//alert(tempArray2 [0] );
	
	//
	//最后创建一个临时数组存储 根据上一个乱序的数组从targetArray中取得数据
	var tempArray3 = new Array();
	var simple_result4=new Array(); 
	var simple_left4=new Array(); 
	var simple_right4=new Array(); 
	for (var i = 0; i < arrayLength; i ++) {
		simple_result4 [i] = simple_result [tempArray2 [i]];
		simple_left4 [i] = simple_left [tempArray2 [i]];
		simple_right4 [i] = simple_right [tempArray2 [i]];
		
	    tempArray3 [i] = targetArray [tempArray2 [i]];
	}
	simple_result=simple_result4;
	simple_left=simple_left4;
	simple_right=simple_right4;
	////返回最后得出的数组
	return tempArray3
}
//使用实例


  





function show_load_image_progress(progress)
{
    document.getElementById("loading").innerHTML = "<img  src='../../images/ajax-loader(2).gif'/><br/><br/><fmt:message key="jsp.eachtest.loading"/>" + progress + "%" ;
}

function wait_to_start()
{
		//alert(progress);
		document.getElementById('loading').style.display="none";
		//all_a=new Array(new ari_obj(simple_left_images,simple_right_images,simple_up_images,simple_result),new ari_obj(complex_left_images,complex_right_images,complex_up_images,complex_result));
		all_a=new Array(new ari_obj(simple_left_images,simple_right_images,simple_up_images,simple_result));
		
		any_key_start();
		current_index=0;
		current_start_time=getTimestamp();
}

/* 按任意键继续 */
function any_key_start()
{
	
	
	
	document.getElementById("myCanvas").style.display = "none";
	stroopnum_tips.style.display="block";
	stroopnum_tips.innerHTML="<br/><fmt:message key="jsp.eachtest.leftorrighthand"/>";
	document.onkeydown = ignor_key_press;
	//张静远：是ipad的情况下，显示图片，并且添加鼠标响应事件
	if (is_iPad())
	{
		document.getElementById("button_pq").style.display = "block";
		document.getElementById("button_pq").addEventListener("mousedown", ignor_key_press,true);
	}	
}

function ignor_key_press()
{
	current_start_time=getTimestamp();//record part start time
	var stroopnum_tips=document.getElementById("stroopnum_tip");
	stroopnum_tips.style.display="none";
	//张静远
	if(is_iPad()){
		document.getElementById("button_pq").removeEventListener("mousedown",ignor_key_press,true);
	}	
	setTimeout("show_fixation()", blank_interval);
}

/* the beginning method, in actural it is show blank screen */
function show_fixation()
{
//alert(simple_up.length);
	document.getElementById("message").style.display="none";
	document.getElementById("feed_back_div").style.display="none";
	//if(index<all_a.length)//simple and complex
	if(index<all_a.length)//simple and complex
	{
		var need_ralex=false;//(index<all_a.length-1);//the last portion
		//if((getTimestamp()-current_start_time>ristrict_time)||current_index>=all_a[index].length)//relax
		if((getTimestamp()-current_start_time>ristrict_time)||current_index>=120)//relax
		{
			post_result();
		}else
		{
			if(is_in(current_index,relax_point))//relax			
			{
				relax_point=romve_value(current_index,relax_point)//remove it
				document.getElementById("left_span").style.display = "none";
				document.getElementById("right_span").style.display = "none";
				document.getElementById("stroopnum_tip").innerHTML = " ";
				document.getElementById("myCanvas").style.display = "block";
				start_progressbar();
				document.onkeydown =null;
				StartSign=0;
				setTimeout("any_key_start()", midle_relax_interval+2000);
			}else	
			{
				setTimeout("change_view()", 0);
			}	
		}
		
	}else
	{

		post_result();
		//alert(" will submit the result.");

	}
}


function change_view()
{
		var stroop=all_a[index];
		document.getElementById("left_span").style.display = "block";
		document.getElementById("right_span").style.display = "block";
		//document.getElementById("up_span").style.display = "block";
		//document.getElementById("up_image").src = all_a[index].up_array[current_index].src;
		document.getElementById("left_image").src = all_a[index].l_array[current_index].src;
		document.getElementById("right_image").src = all_a[index].r_array[current_index].src;
		if(is_iPad()){
			document.getElementById("button_pq").style.display = "block";//张静远：是ipad，显示图片
		}
		
		all_a[index].user_result[current_index]=undef_key;
		//rc_key[index] = undef_key;
		rc_time[current_index] = undef_time;
		timestamp = getTimestamp();
			//stimidAll[current_index]=current_index+1;
			  
			stimidAll[current_index]=parseInt(tempArray2[current_index])+1;
			
			type4All[current_index]=0;
					
		current_index++;
		setTimeout("show_response()",200);
}

//check if a value in a array
function is_in(targ,sour)
{
	for(var i=0;i<sour.length;i++)
	{
		if(targ==sour[i])
		{
			return true;
		}
	}
	return false;
}

//remove a value in a array
function romve_value(targ,sour)
{
	var cop=new Array();
	for(var i=0;i<sour.length;i++)
	{
		if(targ!=sour[i])
		{
			cop.push(sour[i]);
		}
	}
	return cop;
}

function show_response()
{
	document.getElementById("left_image").src = "../../../images/black_toosmall.jpg";
	document.getElementById("right_image").src = "../../../images/black_toosmall.jpg";	
	document.getElementById("left_span").style.display = "none";
	document.getElementById("right_span").style.display = "none";
	document.onkeydown = key_down;
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

function post_result()
{
	var corrects=new Array();
	var users=new Array();

//alert(all_a.length);
	
	for(var i=0;i<all_a.length;i++)
	{
		var mdcobj=all_a[i];
		corrects=add_array(corrects,get_related_result(mdcobj.correct_result_array,mdcobj.user_result.length));
		users=add_array(users,mdcobj.user_result);
//alert(users);
		
	}
	/*
	for(var i=0;i<all_a.length;i++)
	{
		var mdcobj=all_a[i];
		add_result("correct_result", mdcobj.correct_result_array.join(";"));
		add_result("user_result", mdcobj.user_result.join(";"));
	}
	*/
	add_result("correct_result",corrects.join(";"));
	add_result("user_result",users.join(";"));
	add_result("user_time", rc_time.join(";"));	
	add_result("duration",getTimestamp()-start_time);

	
	///////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////
	var type4set=type4All.join(";");
	var stimidset=stimidAll.join(";");
	var correctanswerset= corrects.join(";")
	var buttonset=users.join(";");
	var timeset=rc_time.join(";");
	var timeaverage=getTimestamp()-start_time;
	add_result("type4set", type4set);
	add_result("stimidset",stimidset);
	add_result("correctanswerset",correctanswerset);
	add_result("buttonset", buttonset);
	add_result("timeset", timeset);
	add_result("timeaverage",timeaverage);
	var radioset=""; 
	var numset="";
	var timeset="";
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
			radioset=radioset+";"+"";
			numset=numset+";"+"";
			timeset=timeset+";"+"";
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
	add_result("radioset", radioset);
	add_result("numset", numset);
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////	

	document.getElementById("result").submit();	
}


//张静远：将key_down函数拆成了key_down和key_input函数
function key_down(e)
{
	//console.log("key_down");
	//console.log(e);
		var keyhit=check_keyhit(e);
		if(!keyhit)
		{
			return;
		}else{
			key_input(keyhit);
		}
}

function key_input(keyhit)
{
	if ( all_a[index].user_result[current_index-1] == undef_key )//if is the first type key q or p
	{
		clearInterval(timer_id);
	
		var key = undef_key;

		if (keyhit == '81')// q
		{	
			key = "q";
		}
		if (keyhit == '87')// w
		{	
			key = "p";
		}
		if (keyhit == '79')// w
		{	
			key = "q";
		}
		if (keyhit == '80')// p
		{	
			key = "p";
		}
	   
		all_a[index].user_result[current_index-1] = key;	
//alert(all_a[index].user_result[current_index-1]);
		   
		rc_time[current_index-1]= getTimestamp() - timestamp;
				  
	    show_user_result();
//alert(rc_time[index-1]);
	    
   }
}
//张静远：两个点击函数和判断ipad函数
function right_click()
{

			key_input("80");
}
function left_click()
{
			key_input("79");
}
function is_iPad(){
	//console.log("ispad?");
    var ua = navigator.userAgent.toLowerCase();
    if(ua.match(/iPad/i)=="ipad") {
        return true;
    } else {
        return false;
    }
}
function show_user_result()
{
	document.getElementById("feed_back_div").style.display="block";
	document.getElementById("message").style.display="block";	
	document.getElementById("left_span").style.display = "none";
	document.getElementById("right_span").style.display = "none";
	document.getElementById("up_span").style.display = "none";
	stroopnum_tips.style.display="none";
	
	//alert(all_a[index].user_result[current_index-1]+"  uc  "+all_a[index].correct_result_array[current_index-1]);
	if(all_a[index].user_result[current_index-1]==all_a[index].correct_result_array[current_index-1])
	{
		//document.getElementById("message").innerHTML = "<fmt:message key="jsp.eachtest.correctresponse"/>";
		//document.getElementById('messageimageObj').src =pleased_image;
	}else
	{
		//document.getElementById("message").innerHTML = "<fmt:message key="jsp.eachtest.wrongresponse"/>";
		//document.getElementById('messageimageObj').src =depressed_image;
	}
	setTimeout("show_fixation()",1500);
	
}
function check_keyhit(e)
{
	var typed_key;
	if (window.event)
	{  
		typed_key = window.event.keyCode;
	}
	else
	{
		typed_key = e.which;
	}
	//alert(typed_key);
	if (typed_key == '81'||typed_key == '80'||typed_key == '79'||typed_key == '87')
	{	
		return typed_key;
	}else
	{
		alert("<fmt:message key="jsp.eachtest.leftorrighthand"/>");
		document.onkeydown = key_down;
		return false;
	}
	
}
function show_status_bar()
{
	//alert(jg);
	jg.setColor("#ffeeaa");
	jg.drawRect(20,40,bar_length,20);// x-pix y-pix width height
	jg.paint();
	
	jg.setColor("#00aaaa");
	jg.fillRect(20,40,progressbar,20);
	jg.paint();

	
	if(progressbar<bar_length)
	{
		setTimeout("show_status_bar()",update_interval);
	}
	progressbar++;
	
}

function start_progressbar()
{
	jg.clear();
	progressbar=0;
	setTimeout("show_status_bar()",0);
}


function draw_dot()
{
	//alert(event.clientX);
	jg_doc.clear();
	var x=event.clientX;
	var y=event.clientY;
	alert(x);
	jg_doc.setColor("#ffeeaa");
	jg_doc.fillOval(x,y,radius,radius);
	jg_doc.paint();
}




function ari_obj(l_array,r_array,up_array,correct_result_array)
{
	if(l_array.length!=r_array.length)
	{
		alert("l_array.length!=r_array.length");
	}
	if(up_array.length!=r_array.length)
	{
		alert("up_array.length!=r_array.length");
	}
	this.l_array=l_array;
	this.r_array=r_array;
	this.up_array=up_array;
	this.correct_result_array=correct_result_array;
	this.length=l_array.length;
	this.user_result=new Array();
	//this.user_time=new Array();
	return this;
}
function getTimestamp()
{
	var now = new Date();
	return now.getTime(); // in ms
}
 
function start()
{
	//document.getElementById('loading').style.display="none";
	start_time=getTimestamp();
	preloadimages();	
}
function show_loading()
{
	document.getElementById('imageObj').src =loading_image;
	setTimeout("start()", start_delay);
}
window.onload = show_loading
 
</script>


</html>
