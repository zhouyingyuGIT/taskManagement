<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>威斯康星卡片分类测验/Wisconsin Card Sorting Test</title>

<SCRIPT src="../../../js/wz_jsgraphics/wz_jsgraphics.js"
	type=text/javascript></SCRIPT>
<SCRIPT src="../../../js/utils.js" type=text/javascript></SCRIPT>
<SCRIPT src="../../../js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<SCRIPT src="../../../js/jquery-1.8.2.min.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../../../js/jquery-ui-1.9.1.custom.min.js"
	type="text/javascript"></SCRIPT>
<SCRIPT src="../../../js/progress_bar.js" type=text/javascript></SCRIPT>

<script type="text/javascript" defer="defer">
	var i, j, k;
	var a = 0, b = 0, c = 0;//图片地址
	var diffX, diffY, theElement;
	var image_url = "background.gif";
	var positionX = new Array(0, 0, 0, 0);
	var positionY = new Array(0, 0, 0, 0);
	var position = 0;
	var rules = new Array([ 0, 1, 2, 0, 1, 2 ], [ 0, 1, 2, 0, 2, 1 ], [ 0, 1,
			2, 1, 0, 2 ], [ 0, 1, 2, 1, 2, 0 ], [ 0, 2, 1, 0, 1, 2 ], [ 0, 2,
			1, 0, 2, 1 ], [ 0, 2, 1, 2, 0, 1 ], [ 0, 2, 1, 2, 1, 0 ], [ 1, 0,
			2, 0, 1, 2 ], [ 1, 0, 2, 0, 2, 1 ], [ 1, 0, 2, 1, 0, 2 ], [ 1, 0,
			2, 1, 2, 0 ], [ 1, 2, 0, 1, 0, 2 ], [ 1, 2, 0, 1, 2, 0 ], [ 1, 2,
			0, 2, 0, 1 ], [ 1, 2, 0, 2, 1, 0 ], [ 2, 0, 1, 0, 1, 2 ], [ 2, 0,
			1, 0, 2, 1 ], [ 2, 0, 1, 2, 0, 1 ], [ 2, 0, 1, 2, 1, 0 ], [ 2, 1,
			0, 1, 0, 2 ], [ 2, 1, 0, 1, 2, 0 ], [ 2, 1, 0, 2, 0, 1 ], [ 2, 1,
			0, 2, 1, 0 ]);//规则

	var picked_rule, rule_pos = 0;//选择的规则及规则指针
	//记录数据的函数是judge
	//下面是需要记录的变量,按1到8的顺序排列

	var rule = 0;
	var total_subject = 0; //Number of trials
	var correct = 0; //Number of correct trials
	var wrong = 0; //Number of incorrect trials
	var first_rule_times = 0; //time for first trial for a rule
	var concept_level = 0; //Number of correct trials for a rule    
	var continue_response = 0; //Number of incorrect trials for current rule but correct for previous rules
	var continue_wrong = 0; //Number of incorrect trials after subject's changing rule. 
	var cannot_complete_times = 0; //第八个函数“不能维持完整分类数”：指测试过程中，连续完成5－9个正确应答的次数，即已发现分类规则但不能坚持完成连续做对10个题目。
	var start_time;

	//variable name: process
	var open_time = new Array();//（1）	受测试者翻开卡片的时间点，函数在onclick里
	var which_picture = new Array();//（2）	翻开的是哪张卡片（卡片编号）,getRandomImage()
	var end_time = new Array();//（3）	将翻开的卡片进行归类完成的时间点（即将卡片拖动完成的时间点）,dropper()
	var which_position = new Array();//（4）	记录将翻开的图片放到了哪个目标图片下,dropper(),图片位置从左至右1，2，3，4

	//新增加的数据库变量
	var buttonset = new Array();//受试者使用的分类序列
	var numset = new Array(); //连续错误序列
	var correctanswerset = new Array();//正确的分类序列
	var commentset = new Array();//翻开的是哪张卡片
	var type4set = new Array();
	var stimidset = new Array();
	var radioset = new Array();

	var if_right = false;//这次做对了没有
	var correct_acount = 0;
	var used_rules = new Array([ 0, 0, 0 ], [ 0, 0, 0 ]);//CSN
	var last_if_right = true;
	var isIE = document.all ? true : false;
	var done = false;
	var stimidAll = new Array();
	var type4All = new Array();
	var passitemnumber = 10; //should be 10
	var rulenumber = 6; //should be 6   Subject should finish 6 rules. 
	var test_begin_ime;
	var PermissionTry = 200;
	var ristrict_time = 1000 * 60 * 21;
	var TimeLimited;

	function init() {
		test_begin_ime = getTimestamp();
		picked_rule = Math.round(23 * Math.random());//选择rule
		document.getElementById("mv").style.left = document
				.getElementById("back").offsetLeft
				+ "px";
		document.getElementById("mv").style.top = document
				.getElementById("back").offsetTop
				+ "px";
		for (i = 0; i < 4; i++) {
			positionX[i] = document.getElementById(i).offsetLeft;
			positionY[i] = document.getElementById(i).offsetTop;
		}
		begin();
	}
	function getRandomImage() {
		a = 1 + Math.round(3 * Math.random());
		b = 1 + Math.round(3 * Math.random());
		c = 1 + Math.round(3 * Math.random());
		//image_url = "" + a + "-" + b + "-" + c + ".gif";
		
		image_url = "" + a + "-" + b + "-" + c + ".gif";
		which_picture[total_subject] = a + "-" + b + "-" + c;

		commentset[total_subject] = (a - 1) * 16 + (b - 1) * 4 + c; //将出现的图片以1—64编号存入commentset
	}

	function judge() {
		if_right = false;
		total_subject++;
		//判断用户所使用的规则
		//这次匹配的规则
		if (position + 1 == a)
			used_rules[1][0] = 1;
		else
			used_rules[1][0] = 0;
		if (position + 1 == b)
			used_rules[1][1] = 1;
		else
			used_rules[1][1] = 0;
		if (position + 1 == c)
			used_rules[1][2] = 1;
		else
			used_rules[1][2] = 0;

		type4set[total_subject - 1] = 0;
		stimidset[total_subject - 1] = total_subject;
		radioset[total_subject - 1] = '';

		switch (rules[picked_rule][rule_pos]) {
		case 0://按顔色规则判断

			correctanswerset[total_subject - 1] = a; //将正确的规则存入correctanswer

			if (position + 1 == a) {
				if_right = true;
				last_if_right = true;
				correct_acount++;
				correct++;
				numset[total_subject - 1] = 0;
				if (correct_acount == passitemnumber) {
					rule_pos++;
					correct_acount = 0;
					if (rule_pos == 1)
						first_rule_times = total_subject;
					if (rule_pos == rulenumber) { //alert("You have finished the test");
						post_result();
					}
				}
			} else {
				if (last_if_right == false) {
					numset[total_subject - 1] = 0;
					for (i = 0; i < 3; i++)
						if (used_rules[0][i] == 1 && used_rules[1][i] == 1) {
							numset[total_subject - 1] = 1;
							numset[total_subject - 2] = 1;
							continue_wrong++;
						}
				} else
					numset[total_subject - 1] = 0;
				last_if_right = false;
				wrong++;
				if (rule_pos > 0) {
					if (rules[picked_rule][rule_pos - 1] == 0)//与上一条规则匹配
						if (position + 1 == a)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 1)
						if (position + 1 == b)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 2)
						if (position + 1 == c)
							continue_response++;

				}
				if (correct_acount > 4)
					cannot_complete_times++;
				if (correct_acount > 2)
					concept_level += correct_acount;
				correct_acount = 0;
			}
			break;
		case 1://形状

			correctanswerset[total_subject - 1] = b; //将正确的规则存入correctanswer

			if (position + 1 == b) {
				if_right = true;
				last_if_right = true;
				correct_acount++;
				correct++;
				numset[total_subject - 1] = 0;

				if (correct_acount == passitemnumber) {
					rule_pos++;
					correct_acount = 0;
					if (rule_pos == 1)
						first_rule_times = total_subject;
					if (rule_pos == rulenumber) {
						alert("You have finished the test");
						post_result();
					}
				}
			} else {
				if (last_if_right == false) {
					numset[total_subject - 1] = 0;
					for (i = 0; i < 3; i++)
						if (used_rules[0][i] == 1 && used_rules[1][i] == 1) {
							numset[total_subject - 1] = 1;
							numset[total_subject - 2] = 1;
							continue_wrong++;
						}
				} else
					numset[total_subject - 1] = 0;
				last_if_right = false;
				wrong++;
				if (rule_pos > 0) {
					if (rules[picked_rule][rule_pos - 1] == 0)//与上一条规则匹配
						if (position + 1 == a)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 1)
						if (position + 1 == b)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 2)
						if (position + 1 == c)
							continue_response++;

				}
				if (correct_acount > 4)
					cannot_complete_times++;
				if (correct_acount > 2)
					concept_level += correct_acount;
				correct_acount = 0;
			}
			break;
		case 2://数量

			correctanswerset[total_subject - 1] = c; //将正确的规则存入correctanswer

			if (position + 1 == c) {
				if_right = true;
				last_if_right = true;
				correct_acount++;
				correct++;
				numset[total_subject - 1] = 0;

				if (correct_acount == passitemnumber) {
					rule_pos++;
					correct_acount = 0;
					if (rule_pos == 1)
						first_rule_times = total_subject;
					if (rule_pos == rulenumber) {
						alert("You have finished the test");
						post_result();
					}
				}
			} else {
				if (last_if_right == false) {
					numset[total_subject - 1] = 0;
					for (i = 0; i < 3; i++)
						if (used_rules[0][i] == 1 && used_rules[1][i] == 1) {
							numset[total_subject - 1] = 1;
							numset[total_subject - 2] = 1;
							continue_wrong++;
						}
				} else
					numset[total_subject - 1] = 0;
				last_if_right = false;
				wrong++;
				if (rule_pos > 0) {
					if (rules[picked_rule][rule_pos - 1] == 0)//与上一条规则匹配
						if (position + 1 == a)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 1)
						if (position + 1 == b)
							continue_response++;
					if (rules[picked_rule][rule_pos - 1] == 2)
						if (position + 1 == c)
							continue_response++;
				}
				if (correct_acount > 4)
					cannot_complete_times++;
				if (correct_acount > 2)
					concept_level += correct_acount;
				correct_acount = 0;
			}
			break;
		}
		//set used_rules
		for (i = 0; i < 3; i++)
			used_rules[0][i] = used_rules[1][i];
		if (if_right) {
			document.getElementById("smile").src = "smile.gif";
		} else {
			document.getElementById("smile").src = "sad.gif";
		}
		//if ( total_subject>=PermissionTry | getTimestamp()-test_begin_ime>40*60*1000)
		if (total_subject >= PermissionTry) {
			post_result();
		}
	}

	function post_result() {
		add_result("rule", picked_rule);
		add_result("total_subject", total_subject);
		add_result("correct", correct);
		add_result("wrong", wrong);
		add_result("first_rule_times", first_rule_times);
		add_result("concept_level", concept_level);
		add_result("continue_response", continue_response + 1);
		add_result("continue_wrong", continue_wrong + 1);
		add_result("cannot_complete_times", cannot_complete_times);
		add_result("timeaverage", 0);

		add_result("open_time", "");
		//alert(end_time);
		//alert(which_picture);	
		add_result("end_time", end_time.join(";"));
		add_result("which_picture", which_picture.join(";"));
		add_result("which_position", which_position.join(";"));

		add_result("user_result", "");
		add_result("user_time", "");
		add_result("correct_result", "");
		add_result("duration", getTimestamp() - test_begin_ime);

		add_result("buttonset", buttonset.join(";"));
		add_result("numset", numset.join(";"));
		add_result("commentset", commentset.join(";"));
		add_result("correctanswerset", correctanswerset.join(";"));
		add_result("type4set", type4set.join(";"));
		add_result("stimidset", stimidset.join(";"));
		add_result("radioset", radioset.join(";"));

		buttonset = buttonset.join(";");
		numset = numset.join(";");
		commentset = commentset.join(";");
		correctanswerset = correctanswerset.join(";");
		type4set = type4set.join(";");
		stimidset = stimidset.join(";");
		radioset = radioset.join(";");
		var timeset = "";

		//var corrects=get_related_result(correct_result,user_result.length);
		///////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////
		//var type4set=type4All.join(";");
		//var stimidset=stimidAll.join(";");
		//var correctanswerset= corrects.join(";")
		//var buttonset=users.join(";");
		//var timeset=rc_time.join(";");
		var timeaverage = getTimestamp() - start_time;
		//add_result("type4set", type4set);
		//add_result("stimidset",stimidset);
		//add_result("correctanswerset",correctanswerset);
		//add_result("buttonset", buttonset);
		add_result("timeset", timeset);
		add_result("timeaverage", timeaverage);
		//var radioset=""; 
		//var numset="";
		var radiolist1set = "";
		var radiolist2set = "";
		var radiolist3set = "";
		var radiolist4set = "";
		var radiolist5set = "";
		var radiolist6set = "";
		var radiolist7set = "";
		var radiolist8set = "";
		var radiolist9set = "";
		var radiolist10set = "";
		if (correctanswerset.length > 1) {
			for ( var i = 0; i < correctanswerset.length - 1; i++) {
				//radioset=radioset+";"+"";
				//numset=numset+";"+"";
				radiolist1set = radiolist1set + ";" + "";
				radiolist2set = radiolist2set + ";" + "";
				radiolist3set = radiolist3set + ";" + "";
				radiolist4set = radiolist4set + ";" + "";
				radiolist5set = radiolist5set + ";" + "";
				radiolist6set = radiolist6set + ";" + "";
				radiolist7set = radiolist7set + ";" + "";
				radiolist8set = radiolist8set + ";" + "";
				radiolist9set = radiolist9set + ";" + "";
				radiolist10set = radiolist10set + ";" + "";
			}
		}
		var countOfCorrectNumber_ByType = getCorrectCountSortByType(numset,
				correctanswerset, type4set);
		var countOfCorrectButton_ByType = getCorrectCountSortByType(buttonset,
				correctanswerset, type4set);
		var countOfCorrectRadio_ByType = getCorrectCountSortByType(radioset,
				correctanswerset, type4set);
		var countOfCorrectButton_ByType_Corrected = getCorrectCountSortByType_Corrected(
				buttonset, correctanswerset, type4set);
		var percentageCorrectNumber_ByType = getPercentageCorreceSortByType(
				numset, correctanswerset, type4set);
		var percentageCorrectButton_ByType = getPercentageCorreceSortByType(
				buttonset, correctanswerset, type4set);
		var percentageCorrectRadio_ByType = getPercentageCorreceSortByType(
				radioset, correctanswerset, type4set);
		var meanNumber_ByType = getMeanSortByType(numset, type4set);
		var sumNumber_ByType = getSumSortByType(numset, type4set);
		var meanRT_ByType = getMeanSortByType(timeset, type4set);
		var meanDeviationNumber_ByType = getMeanDeviationSortByType(numset,
				correctanswerset, type4set);
		var sumWeightedRadio_ByType = getWeightedScoreSortByType(radioset,
				type4set, radiolist1set, radiolist2set, radiolist3set,
				radiolist4set, radiolist5set, radiolist6set, radiolist7set,
				radiolist8set, radiolist9set, radiolist10set);
		var type4_Unique = getType(type4set);
		add_result("countOfCorrectNumber_ByType", countOfCorrectNumber_ByType);
		add_result("countOfCorrectButton_ByType", countOfCorrectButton_ByType);
		add_result("countOfCorrectRadio_ByType", countOfCorrectRadio_ByType);
		add_result("countOfCorrectButton_ByType_Corrected",
				countOfCorrectButton_ByType_Corrected);
		add_result("percentageCorrectNumber_ByType",
				percentageCorrectNumber_ByType);
		add_result("percentageCorrectButton_ByType",
				percentageCorrectButton_ByType);
		add_result("percentageCorrectRadio_ByType",
				percentageCorrectRadio_ByType);
		add_result("meanNumber_ByType", meanNumber_ByType);
		add_result("sumNumber_ByType", sumNumber_ByType);
		add_result("meanRT_ByType", meanRT_ByType);
		add_result("meanDeviationNumber_ByType", meanDeviationNumber_ByType);
		add_result("sumWeightedRadio_ByType", sumWeightedRadio_ByType);
		add_result("type4_Unique", type4_Unique);
		//add_result("radioset", radioset);
		//add_result("numset", numset);
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////	

		document.getElementById("result").submit();
	}

	function add_result(id, value) {
		var elem = document.createElement("input");
		elem.setAttribute("type", "text");
		elem.setAttribute("id", id);
		elem.setAttribute("name", id);
		elem.setAttribute("value", value);
		document.getElementById("result").appendChild(elem);
	}

	function begin() {//点击开始或确定后将div重置到初始位置，并将所处位置的图片改为div上的图片，并获得新的图片

		done = false;

		if (a != 0) {
			//alert(open_time[total_subject]+" "+end_time[total_subject]+" "+which_position[total_subject]+" "+which_picture[total_subject]);
			judge();
			document.getElementById('smile').style.visibility = 'visible';

		}//判断正误

		getRandomImage();
		document.getElementById("mv").style.backgroundImage = "url("
				+ image_url + ")";
		//document.getElementById("button").value="确定";

		start_time = getTimestamp();

		TimeLimited = setTimeout("ifback()", ristrict_time);
	}

	function ifback() //判断整个测试过程时间是否用完
	{
		post_result();
	}
	$(document).keydown(function (event) {
		var e = event || window.event;
		var k = e.keyCode || e.which;
		if(e.ctrlKey && e.shiftKey && k===75){
			ifback();
		}
	});
	function getTimestamp() {
		var now = new Date();
		return now.getTime(); // in ms
	}

	function grabber(event) {
		document.getElementById("back").src = "background.gif";
		if (isIE) {
			theElement = event.srcElement;
			var posX = parseInt(theElement.offsetLeft);
			var posY = parseInt(theElement.offsetTop);
			diffX = event.clientX - posX;
			diffY = event.clientY - posY;
			document.attachEvent("onmousemove", mover);
			document.attachEvent("onmouseup", dropper);
		} else {
			theElement = event.currentTarget;
			var PosX = parseInt(theElement.style.left);
			var PosY = parseInt(theElement.style.top);
			diffX = event.clientX - PosX;
			diffY = event.clientY - PosY;
			document.addEventListener("mousemove", mover, true);
			document.addEventListener("mouseup", dropper, true);
			event.stopPropagation();
			event.preventDefault();
		}
	}
	function mover(event) {
		theElement.style.left = (event.clientX - diffX) + "px";
		theElement.style.top = (event.clientY - diffY) + "px";
	}
	function dropper(event) {
		if (isIE) {
			document.detachEvent("onmousemove", mover);
			document.detachEvent("onmouseup", dropper);
			event.cancelBubble = true;
		} else {
			document.removeEventListener("mouseup", dropper, true);
			document.removeEventListener("mousemove", mover, true);
			event.stopPropagation();
		}
		j = 0;//将图片移至方框位置或者移回原位
		for (i = 0; i < 4; i++) {
			if (positionX[i] < event.clientX
					&& event.clientX < (positionX[i] + 125)
					&& positionY[i] < event.clientY
					&& event.clientY < positionY[i] + 200) {
				//document.getElementById("mv").style.left=document.getElementById(i).offsetLeft;
				//document.getElementById("mv").style.top=document.getElementById(i).offsetTop;
				j = 1;
				position = i;
				which_position[total_subject] = position + 1;
				buttonset[total_subject] = position + 1;
				done = true;
				document.getElementById(position).src = image_url;
				document.getElementById("mv").style.left = document
						.getElementById("back").offsetLeft
						+ "px";
				document.getElementById("mv").style.top = document
						.getElementById("back").offsetTop
						+ "px";
				document.getElementById('back').style.zIndex = 15;
				document.getElementById("back").src = "wordsbackground.gif";
				var mydate = new Date();
				end_time[total_subject] = mydate.getTime()
						- open_time[total_subject];
				//.toString().substring(6,13);

				begin();
			}
		}
		if (j == 0) {
			document.getElementById("mv").style.left = document
					.getElementById("back").offsetLeft
					+ "px";
			document.getElementById("mv").style.top = document
					.getElementById("back").offsetTop
					+ "px";
		}
	}
</script>
</head>
<body bgcolor="#000000" onload="init();">

	<form id="result" name="result" method="post"
		action="/lattice/OPESHandler?type=formal">
		<input type=hidden value="35" name="taskid" id="taskid" /> <input
			type=hidden value="<%=request.getParameter("sumitcoids")%>"
			name="sumitcoids" id="sumitcoids" /> <input type=hidden
			value="<%=request.getParameter("targetpagename")%>"
			name="targetpagename" id="targetpagename" /> <input type=hidden
			value="WCST" name="taskIdentifier" id="taskIdentifier" />
	</form>

	<div onmousedown="grabber(event);"
		style="position: absolute; width: 88px; z-index: 10; height: 140px; background-image: url(background.gif);"
		id="mv"></div>
	<div align="center">
		<table border="0" cellpadding="10">
			<tr>
				<td align="center" width="200"><img
					src="1-1-1.gif" /></td>
				<td align="center" width="200"><img
					src="2-2-2.gif" /></td>
				<td align="center" width="200"><img
					src="3-3-3.gif" /></td>
				<td align="center" width="200"><img
					src="4-4-4.gif" /></td>
			</tr>
			<tr>
				<td colspan="4"><hr color="Gray"
						style="height: 10px; width: 760px" id="hr" /></td>
			</tr>
			<tr>
				<td align="center" width="200"><img
					src="background.gif" id="0"
					style="position: relative; left: auto; top: auto;" /></td>
				<td align="center" width="200"><img
					src="background.gif" id="1"
					style="position: relative; left: auto; top: auto;" /></td>
				<td align="center" width="200"><img
					src="background.gif" id="2"
					style="position: relative; left: auto; top: auto;" /></td>
				<td align="center" width="200"><img
					src="background.gif" id="3"
					style="position: relative; left: auto; top: auto;" /></td>
			</tr>
			<tr>
				<td align="center" width="200"></td>
				<td align="center" width="200"><img
					src="wordsbackground.gif" id="back"
					style="position: relative; z-index: 15 left:auto; top: auto;"
					onclick="	document.getElementById('smile').style.visibility='hidden';document.getElementById('back').style.zIndex=5;var mydate=new Date();
	open_time[total_subject]=  mydate.getTime();" /></td>

				<td align="center" width="200"><img
					src="smile.jsp" id="smile"
					style="visibility: hidden;" /></td>
				<td align="center" width="200"></td>
			</tr>
		</table>
	</div>
</body>
</html>

var image_url="background.gif";
