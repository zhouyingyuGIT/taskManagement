<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>连线测试TMT</title>
    <link rel="stylesheet" href="index.css">
    <SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
    <script src="/lattice/js/oneui/opes_post_result_util.js"></script>
</head>
<%
    Users u=(Users)request.getSession().getAttribute("cu");
    int uid=u.getUserid();
    int taskid=Integer.parseInt(request.getParameter("taskid"));
    String lan=request.getParameter("lan");
    String targetpagename=request.getParameter("targetpagename");

    int projectid=0;
    if (!(request.getParameter("projectid")==null)) {
        projectid=Integer.parseInt(request.getParameter("projectid"));
    }

    int codematerial=0;
    if (!(request.getParameter("codematerial")==null)) {
        codematerial=Integer.parseInt(request.getParameter("codematerial"));
    }

    int sumitcoids=u.getCoid();


    Vector
            <OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
    if (ots.size()==0)
    {
        response.sendRedirect("/lattice/"+targetpagename);
        return;
    }
    ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
    request.getSession().setAttribute("ot",ots.get(0));

%>
<body>

<div class="box" id="box">
    <div id="reward1" class="hide reward1">
        <div class="div_flex" style="height: 70%;">
            这个测验是计时的，你完成的时间越长，成绩就会越差，因此要抓紧时间！
        </div>
    </div>
    <div id="reward" class="hide reward1">
        <div class="div_flex reward">
            <span class="prompt" id="prompt1"></span>
            <span>&nbsp;</span>
            <span class="prompt" id="prompt2" style=""></span>
        </div>
    </div>
    <div id="item1" class="item">
        <div class="item div_flex zdy">
            你面前的屏幕有一些圆圈，圆圈里有数字。请用鼠标按照 1、2、3 一直到8的顺序点击它们。从开始键1开始，1连2，2连3直到连接到8为止。不能跳隔数字，要一个接一个的点击，要求快速并且准确。现在试着连接一下。
        </div>
    </div>
    <div id="item4" class="item hide">
        <div class="item div_flex zdy">
            在屏幕上会呈现1到25这些数字，它们没有规律散乱地分布，需要按照 1、2、3 一直到 25 的顺序把点击它们，不能跳隔数字，要一个接一个的连接，要求快速并且准确。起始为1，连接到 25 为止，开始。(立即开始计时)        </div>
        </div>
    <div id="item2" class="item div_flex hide">
        <!--<div style="height: 370px;width: 1000px;position: absolute;top: 0px;left: 0px;z-index: -11;background: #2e6da4">
            <img src="3.png" alt="" style="height: 100%;width: auto;">
        </div>-->
        <div id="TMTAtest" class="TMTAtest TMTBox">
            <div data-index="1" class="TMT div_flex active TMTActive Atest1 begin">1</div>
            <hr class="hr hr1 hide">
            <div data-index="2" class="TMT div_flex Atest2">A</div>
            <hr class="hr hr2 hide">
            <div data-index="3" class="TMT div_flex Atest3">2</div>
            <hr class="hr hr3 hide">
            <div data-index="4" class="TMT div_flex Atest4">B</div>
            <hr class="hr hr4 hide">
            <div data-index="5" class="TMT div_flex Atest5">3</div>
            <hr class="hr hr5 hide">
            <div data-index="6" class="TMT div_flex Atest6">C</div>
            <hr class="hr hr6 hide">
            <div data-index="7" class="TMT div_flex Atest7">4</div>
            <hr class="hr hr7 hide">
            <div data-index="8" class="TMT div_flex Atest8 end">D</div>
        </div>
    </div>
    <div id="item3" class="item hide div_flex">
        <div id="TMTA" class="TMTA TMTBox">
<!--            <img src="5.png" alt="" style="height: 100%;width: 648px;position: absolute;top: 0px;left: 0px;z-index: 0">-->
            <div style="height: 500px;width: 648px;position: absolute;top: 0px;left: 0px;z-index: 3;">
                <div data-index="1" class="TMTZ div_flex A1 active TMTActive begin">1</div>
                <hr class="hr Ahr1 hide">
                <div data-index="2" class="TMTZ div_flex A2">A</div>
                <hr class="hr Ahr2 hide">
                <div data-index="3" class="TMTZ div_flex A3">2</div>
                <hr class="hr Ahr3 hide">
                <div data-index="4" class="TMTZ div_flex A4">B</div>
                <hr class="hr Ahr4 hide">
                <div data-index="5" class="TMTZ div_flex A5">3</div>
                <hr class="hr Ahr5 hide">
                <div data-index="6" class="TMTZ div_flex A6">C</div>
                <hr class="hr Ahr6 hide">
                <div data-index="7" class="TMTZ div_flex A7">4</div>
                <hr class="hr Ahr7 hide">
                <div data-index="8" class="TMTZ div_flex A8">D</div>
                <hr class="hr Ahr8 hide">
                <div data-index="9" class="TMTZ div_flex A9">5</div>
                <hr class="hr Ahr9 hide">
                <div data-index="10" class="TMTZ div_flex A10">E</div>
                <hr class="hr Ahr10 hide">
                <div data-index="11" class="TMTZ div_flex A11">6</div>
                <hr class="hr Ahr11 hide">
                <div data-index="12" class="TMTZ div_flex A12">F</div>
                <hr class="hr Ahr12 hide">
                <div data-index="13" class="TMTZ div_flex A13">7</div>
                <hr class="hr Ahr13 hide">
                <div data-index="14" class="TMTZ div_flex A14">G</div>
                <hr class="hr Ahr14 hide">
                <div data-index="15" class="TMTZ div_flex A15">8</div>
                <hr class="hr Ahr15 hide">
                <div data-index="16" class="TMTZ div_flex A16">H</div>
                <hr class="hr Ahr16 hide">
                <div data-index="17" class="TMTZ div_flex A17">9</div>
                <hr class="hr Ahr17 hide">
                <div data-index="18" class="TMTZ div_flex A18">I</div>
                <hr class="hr Ahr18 hide">
                <div data-index="19" class="TMTZ div_flex A19">10</div>
                <hr class="hr Ahr19 hide">
                <div data-index="20" class="TMTZ div_flex A20">J</div>
                <hr class="hr Ahr20 hide">
                <div data-index="21" class="TMTZ div_flex A21">11</div>
                <hr class="hr Ahr21 hide">
                <div data-index="22" class="TMTZ div_flex A22">K</div>
                <hr class="hr Ahr22 hide">
                <div data-index="23" class="TMTZ div_flex A23">12</div>
                <hr class="hr Ahr23 hide">
                <div data-index="24" class="TMTZ div_flex A24">L</div>
                <hr class="hr Ahr24 hide">
                <div data-index="25" class="TMTZ div_flex A25 end">13</div>
<!--                <div class="TMTZ div_flex A16">16</div>-->
<!--                <div class="TMTZ div_flex end">25</div>-->
            </div>
        </div>
        <!--<div id="TMTA" class="TMTA TMTBox">

            <div class="TMTZ div_flex active TMTActive begin A1">1</div>
            <hr class="hr" style="width: 1000px;height: 2px;top: 100px">
            <div class="TMTZ div_flex">2</div>
            <hr class="hr" style="width: 1000px;height: 2px;top: 200px">
            <hr class="hr" style="width: 1000px;height: 2px;top: 250px">
            <hr class="hr" style="width: 1000px;height: 2px;top: 375px">
            <div class="TMTZ div_flex">3</div>
            <hr class="hr" style="width: 1000px;height: 2px;top: 300px">
            <div class="TMTZ div_flex">4</div>
            <hr class="hr" style="width: 1000px;height: 2px;top: 400px">
            <div class="TMTZ div_flex">5</div>
            <hr class="hr" style="width: 2px;height: 500px;left: 100px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 200px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 300px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 400px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 500px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 600px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 700px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 800px;">
            <hr class="hr" style="width: 2px;height: 500px;left: 900px;">
            <div class="TMTZ div_flex A6">6</div>
            <div class="TMTZ div_flex">7</div>
            <div class="TMTZ div_flex A8">8</div>
            <div class="TMTZ div_flex A13">13</div>
            <div class="TMTZ div_flex A16">16</div>
            <div class="TMTZ div_flex end">25</div>
        </div>-->
    </div>
</div>
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script>
    $(function () {
        var Atest=["1", "2", "3", "4", "5", "6", "7", "8"];
        var A=["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"];
        var Btest=["1","A","2","B","3","C","4","D"];
        var B=["1","A","2","B", "3","C", "4","D", "5","E","6","F","7","G","8","H","9","I","10","J","11","K","12","L","13"];
        var spacer=true,spacer1=false,reward=false;
        var data=Btest;
        var time,beginTime,endTime;
        var data_index=1,errorNum=0;
        var time1=3000,timer1=null,maxtime=300,timer=null,time2=10000,timer2=null,time3=3000,timer3=null;
        var commentset=[];
        $(".TMT").on("click",function () {
            var num1=Number($(this).attr("data-index"));
            var num2=Number(data_index+1);
            if(num1 === num2){
                $(".TMT").removeClass("active");
                $(this).addClass("active TMTActive");
                $(".hr"+(num2-1)).removeClass("hide");
                data_index++;
                if(data_index>=8){
                    data=[];
                    data=B;
                    spacer1=true;
                    errorNum=0;
                    data_index=1;
                    $("#prompt2").removeClass("hide");
                    $("#item2").addClass("hide");
                    $("#item4").removeClass("hide");
                }
            }else {
                if(num1 > num2){
                    var prompt1="您连错了，你现在连到了"+data[data_index-1]+"，下一个应该连什么? 是"+data[data_index]+"吗？"
                    errorNum++;
                    if(errorNum>3){
                        $("#prompt2").addClass("hide")
                    }
                    $("#prompt1").text(prompt1);
                    timer1Fun();
                }
            }
        });
        $(".TMTZ").on("click",function () {
            timer2Fun();
            var num1=Number($(this).attr("data-index"));
            var num2=Number(data_index+1);
            if(num1 === num2){
                $(".TMTZ").removeClass("active");
                $(this).addClass("active TMTActive");
                $(".Ahr"+(num2-1)).removeClass("hide");
                data_index++;
                if(data_index>=25){
                    spacer1=true;
                    endTime=new Date().getTime();
                    time = (endTime - beginTime).toFixed(0);
                    endFun();
                }
            }else {
                if(num1 > num2){
                    var prompt1="您连错了，你现在连到了"+data[data_index-1]+"，下一个应该连什么? 是"+data[data_index]+"吗？"
                    errorNum++;
                    if(errorNum>3){
                        $("#prompt2").addClass("hide")
                    }
                    $("#prompt1").text(prompt1);
                    timer1Fun();
                }
            }
        });

        function timer1Fun(){
            $("#reward").removeClass("hide");
            timer1 = setInterval(function () {
                $("#reward").addClass("hide");
                if(reward){
                    timer2Fun();
                }
                clearInterval(timer1);
                timer1=null;
            }, time1);
        }
        function timer2Fun(){
            clearInterval(timer2);
            timer2=null;
            timer2 = setInterval(function () {
                timer3Fun();
                clearInterval(timer2);
                timer2=null;
            }, time2);
        }
        function timer3Fun(){
            $("#reward1").removeClass("hide");
            timer3 = setInterval(function () {
                $("#reward1").addClass("hide");
                timer2Fun();
                clearInterval(timer3);
                timer3=null;
            }, time3);
        }
        function CountDown() {
            if (maxtime > 1) {
                --maxtime;
            } else{
                time=300000;
                endFun();
                clearInterval(timer);
                timer=null;
            }
        }
        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k === 32){
                if(spacer){
                    spacer=false;
                    $("#prompt2").text("你面前的屏幕有一些圆圈，圆圈里有数字。请用鼠标按照 1、2、3 一直到8的顺序点击它们。从开始键1开始，1连2，2连3直到连接到8为止。不能跳隔数字，要一个接一个的点击，要求快速并且准确。现在试着连接一下。")

                    $("#item1").addClass("hide");
                    $("#item2").removeClass("hide");
                }
                if(spacer1){
                    spacer1=false;
                    reward=true;
                    $("#prompt2").text("在屏幕上会呈现1到25这些数字，它们没有规律散乱地分布，需要按照 1、2、3 一直到 25 的顺序把点击它们，不能跳隔数字，要一个接一个的连接，要求快速并且准确。起始为1，连接到 25 为止")
                    $("#item4").addClass("hide");
                    $("#item3").removeClass("hide");
                    beginTime=new Date().getTime();
                    timer1 = setInterval(function () {
                        CountDown();
                    }, 1000);
                }
            }
        });

        function endFun() {
            commentset=[];
            commentset.push(time);
            commentset.push(errorNum);
            commentset.push(data_index);
            post_result();
        }
        function post_result() {
            // sumscore,meanscore,meanart;
            var opes_result_data = {};
            opes_result_data.taskid =<%= taskid %>;
            opes_result_data.sumitcoids =<%= sumitcoids %>;
            opes_result_data.targetpagename = "<%=targetpagename%>";
            opes_result_data.codematerial =<%= codematerial %>;
            opes_result_data.uid =<%= uid %>;
            opes_result_data.lan = "<%=lan%>";
            opes_result_data.projectid =<%= projectid %>;
            opes_result_data.duration = 0;
            opes_result_data.timeaverage = Math.round(0);
            opes_result_data.type4set = "0";
            opes_result_data.stimidset = "0";
            opes_result_data.correctanswerset = "0";
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = "0";
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = "0";
            opes_result_data.commentset = commentset.join(";");
            opes_result_data.numset = "0";
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;
        }
    })
</script>
</html>