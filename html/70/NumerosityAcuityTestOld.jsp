<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>TITLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<SCRIPT src="../../../js/wz_jsgraphics/wz_jsgraphics.js" type=text/javascript></SCRIPT>
<SCRIPT src="../../../js/utils.js" type=text/javascript></SCRIPT>
<link rel="stylesheet" href="/lattice/css/layout.css" type="text/css"/>
<link rel="stylesheet" href="/lattice/css/main.css" type="text/css"/>
<style type="text/css"> 

body {margin: 0px; background-color: #000000;cursor: url(../../images/empty.cur), auto;           }
 
span { font-family: Arial, Helvetica, sans-serif; font-size: 30pt; color: #ffffff; }
span.loading { font-family: Arial, Helvetica, sans-serif; font-size: 20pt; color: #ffffff; }
span.fixation { font-family: Arial, Helvetica, sans-serif; font-size: 80pt; color: #ffffff; }
span.message { font-family: Arial, Helvetica, sans-serif; font-size: 25pt; color: #ffffff; }
span.addsubmildiv{ font-family: Arial, Helvetica, sans-serif; font-size: 60pt; color: #ffffff; }
span.asmdresult{ font-family: Arial, Helvetica, sans-serif; font-size: 40pt; color: #ffffff; }
span.myCanvasSpan{font-family: Arial, Helvetica, sans-serif; font-size: 25pt; color: #ffffff; }
.stroopnum_tip_div{	margin:0 auto;	background-color: #000000;	clear: both; 	align: center;	height: 30%;	width: 60%;	position: absolute;	left:20%;	top:35%;	line-height:50px; text-align: center;	font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 40px;	color: #FFFFFF;}
.stroopnum_relax_tips_div{		background-color: #000000;	clear: both; 	align: center;	height: 100px;	width: 40%;	position: absolute;	left:30%;	right:50%;	top:300px;	text-align: center;	font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 27px;	color: #FFFFFF;}


</style>
</head>
<body onload="">
<form id="result" name="result" method="post" action="/lattice/NumerosityAcuityHandler?type=test">
<input type=hidden value="57" name="taskid" id="taskid"/>
<input type=hidden value="" name="sumitcoids" id="sumitcoids"/>
<input type=hidden value="<%= request.getParameter("targetpagename") %>" name="targetpagename" id="targetpagename"/>

</form>

    <table height="100%" border=0px width="100%" border="0">
            <tr>
                <td align="center" valign="middle">
                    <table  cellspacing="0" border=0px cellpadding="0"  width="80%" align="center" border="0">
                        <tr>
                        	<td align=center colspan=3>
                        		<span id="loading" class="loading">
									<img name="imageObj" id="imageObj" src="../../../images/black_toosmall.jpg"/>
									<br/>Uploading...
								</span>
                        	</td>
                        </tr>
                        <tr align=center>
                        	<td align=right>
								<span id="left_span" class="asmdresult"> 
								<img name="left_image" id="left_image" src="../../../images/black_toosmall.jpg" />
								</span>
							</td>
							<td align=center >
								&nbsp;
								<span id="up_span" class="addsubmildiv">
								<img name="up_image" id="up_image" src="../../../images/black_toosmall.jpg" />
								</span>	
								&nbsp;
							</td>							
							<td align=left>
								<span id="right_span" class="asmdresult"> 
								<img name="right_image" id="right_image" src="../../../images/black_toosmall.jpg" />
								</span>
							</td>
						</tr>				

                        						
                    </table>
                </td>
            </tr>
    </table>
 
<div id="stroopnum_tip" style="display:none;" class="stroopnum_tip_div">
</div>
<div id="myCanvas" style="display:none;" class="stroopnum_relax_tips_div">
<br/>
<span id="myCanvasSpan" class="myCanvasSpan">Rest</span>
</div>    
  
<div id="feed_back_div" style="display:none;" class="stroopnum_relax_tips_div">
<br/>
<span id="message" class="message"><img name="feed_back_img" id="feed_back_img" src="../../../images/black_toosmall.jpg"/></span>
<!--<span><img name="messageimageObj" id="messageimageObj" src="../../../images/black_toosmall.jpg"/></span>-->
</div> 
  
</body>
<script type="text/javascript">

var black_image="../../../images/black_toosmall.jpg";
var pleased_image="../../../images/pleased.JPG";
var depressed_image="../../../images/depressed.JPG";
var loading_image="../../../images/ajax-loader(2).gif";

var target=new Array(new Array("10_5000_d_3","8_5000_s_6","10_5000_s_4","12_3000_d_2","7_5000_d_2","7_5000_s_7","6_5000_s_2","16_5000_d_2"));
var left=new Array(new Array("10_5000_d_3","8_5000_s_6","10_5000_s_4","12_3000_d_2","7_5000_d_2","7_5000_s_7","6_5000_s_2","16_5000_d_2")); 
var right=new Array(new Array("5_2500_d_2","16_5000_s_5","6_5000_s_4","20_5000_d_4","5_3571_d_2","10_5000_s_6","8_5000_s_2","12_3750_d_1"));
var correct_result=new Array(new Array("Q","P","Q","P","Q","P","P","Q"));

 
target=target[0]; 
correct_result=correct_result[0];
left=left[0];
right=right[0];


  
var user_result=new Array();
var user_time=new Array();
var rc_key = new Array();
var rc_time = new Array();
 
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

var black_interval = 800;// interval for showing nothing.
var figure_show_interval = 800;//interval for showing the figure.
var smile_img = "./smile.bmp";//when typing right key, show this pic.
var sad_img = "./sad.bmp";//when typing wrong key, show this pic.
var jg = new jsGraphics("myCanvas");
var midle_relax_interval=2000;//
var progressbar=0;//
var bar_length=300;//
var update_interval=midle_relax_interval/bar_length;//
var index=0;
var current_start_time=getTimestamp();
var ristrict_time=99999999;
var pic_path="../../../testpics/NumerosityAcuity/";
var target_images=new Array();
var left_images=new Array();
var right_images=new Array();
  
//使用实例
//var tmp = ["1", "2", "3", "4"];
//alert(randomOrder(tmp));
var relax_point=new Array("48","96");
var material= new Array();   

function preloadimages()
{
  progress=0;
 
  for (i=0;i<target.length;i++)
  {
    target_images[i]=new Image();
    left_images[i]=new Image();
    right_images[i]=new Image();
    
	target_images[i].onload=function()
    {
		progress+=1;
		if (progress==target_images.length)
		{
  			setTimeout("wait_to_start()",0);	
		}else
		{
			setTimeout("show_load_image_progress("+Math.round(progress/target.length*100)+")",0);
		}	
	}
    target_images[i].src=pic_path+target[i]+".gif";
    left_images[i].src=pic_path+left[i]+".gif";
    right_images[i].src=pic_path+right[i]+".gif";
  }
}

function show_load_image_progress(progress)
{
    document.getElementById("loading").innerHTML = "<img  src='../../images/ajax-loader(2).gif'/><br/><br/><fmt:message key="jsp.eachtest.loading"/>" + progress + "%" ;
	
}

function wait_to_start()
{
		//alert(progress);
		document.getElementById('loading').style.display="none";
		//all_a=new Array(new ari_obj(simple_left_images,simple_right_images,simple_up_images,simple_result),new ari_obj(complex_left_images,complex_right_images,complex_up_images,complex_result));
		//all_a=new Array(new ari_obj(simple_left_images,simple_right_images,simple_up_images,simple_result));
		any_key_start();
}

function any_key_start()
{
	current_start_time=getTimestamp();
	document.getElementById("myCanvas").style.display = "none";
	
	var stroopnum_tips=document.getElementById("stroopnum_tip");
	stroopnum_tips.style.display="block";
	stroopnum_tips.innerHTML="<br/><fmt:message key="jsp.eachtest.leftorrighthand"/>";
	document.onkeydown = ignor_key_press;
}
function ignor_key_press()
{
	current_start_time=getTimestamp();//record part start time
	var stroopnum_tips=document.getElementById("stroopnum_tip");
	stroopnum_tips.style.display="none";
	setTimeout("show_fixation()", blank_interval);
}

/* the beginning method, in actural it is show blank screen */
function show_fixation()
{
	document.getElementById("feed_back_div").style.display="none";
	if(index<target.length)
	{ 
		if((getTimestamp()-current_start_time)<ristrict_time)//relax
		{   
			if(is_in(index,relax_point))//relax
			{
				relax_point=romve_value(index,relax_point)//remove it
				//document.getElementById("upper").innerHTML = " ";
				//document.getElementById("nether").innerHTML = " ";
				document.getElementById("stroopnum_tip").innerHTML = " ";
				document.getElementById("myCanvas").style.display = "block";
				document.getElementById("myCanvasSpan").innerHTML="<br/>请休息一会儿";
				start_progressbar();
				document.onkeydown =null;
				setTimeout("any_key_start()", midle_relax_interval+4000);
			}else 
			{
				setTimeout("change_view()", blank_interval);
			}			
		}else
		{
			post_result();
		}
		
	}else
	{
		post_result();
	}
}



function change_view()
{
		//document.getElementById("up_image").style.display = "block";
		//document.getElementById("up_image").src=target_images[index].src;
		setTimeout("show_test()", 0);
} 


 
function show_test()
{
	document.getElementById("right_image").style.display = "block";
	document.getElementById("left_image").style.display = "block";
	document.getElementById("left_image").src=left_images[index].src;
	document.getElementById("right_image").src=right_images[index].src;
	setTimeout("show_black()",400);
}

//Blank Screen for 1s
function show_black()
{
	document.getElementById("left_image").style.display = "none";
	document.getElementById("right_image").style.display = "none";
	 
	
	user_result[index]=undef_key;
	user_time[index]=0;
	timestamp = getTimestamp();
	document.onkeydown = key_down;
}

function add_result_to_form(id, value)
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
	add_result("material", material.join(";"));
	add_result("correct_result", correct_result.join(";"));
	add_result("user_result", user_result.join(";"));
	add_result("user_time", user_time.join(";"));
	add_result("duration",getTimestamp()-start_time);
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


function key_down(e)
{
	var keyhit=check_keyhit(e);
	if(!keyhit)
	{
		return;
	}
	if ( user_result[index] == undef_key )//if is the first type key q or p
	{
		clearInterval(timer_id);
	
		var key = undef_key;

		if (keyhit == '81')// q
		{	
			key = "Q";
		}
		if (keyhit == '87')// w
		{	
			key = "P";
		}
		if (keyhit == '79')// O
		{	
			key = "Q";
		}
		if (keyhit == '80')// p
		{	
			key = "P";
		}
	   
	   user_result[index] = key;	   
	   user_time[index] = getTimestamp()-timestamp;
		
		material[index]=target[index];		
       //alert(material[index]);	  
	   show_user_result();
    }         
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

function show_user_result()
{
	document.getElementById("feed_back_div").style.display="block";
	document.getElementById("left_image").style.display = "none";
	document.getElementById("right_image").style.display = "none";	
	if(correct_result[index]==user_result[index])
	{
		document.getElementById("message").innerHTML = "<fmt:message key="jsp.eachtest.correctresponse"/>";
		//document.getElementById("feed_back_img").src = smile_img ;
	}else 
	{
		document.getElementById("message").innerHTML = "<fmt:message key="jsp.eachtest.wrongresponse"/>";
		//document.getElementById("feed_back_img").src = sad_img ;
	}
	setTimeout("show_fixation()",feedback_interval);
	index++;
	 
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
		alert("<fmt:message key="jsp.eachtest.onlyindexfingerPQ"/>");
		document.onkeydown = key_down;
		return false;
	}
	
} 
function show_status_bar()
{
	jg.setColor("#ffeeaa");
	jg.drawRect(20,70,bar_length,20);// x-pix y-pix width height
	jg.paint();
	jg.setColor("#00aaaa");
	jg.fillRect(20,70,progressbar,20);
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


function getTimestamp()
{
	var now = new Date();
	return now.getTime(); // in ms
}
 
function start()
{

	preloadimages();
	document.getElementById('loading').style.display="none";
	start_time=getTimestamp();
	any_key_start();
}
function show_loading()
{
	document.getElementById('imageObj').src =loading_image;
	setTimeout("start()", start_delay);
}
window.onload = show_loading
 
</script>


</html>
