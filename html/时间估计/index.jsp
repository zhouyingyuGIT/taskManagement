<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>时间估值</title>
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
<div id="box" class="box">
    <div id="item1" class="item">
        <div id="zdy" class="div_flex"></div>
    </div>
    <div id="item2" class="item item2 hide"></div>
    <div id="item3" class="item item3 div_flex hide">
        <img src="luobo.png" alt="" >
    </div>
    <div id="item4" class="item item4 div_flex hide">
        <img src="tuzi.png" alt="" >
    </div>
    <div id="item5" class="item item5 hide">
        <div style="height: 80%;width: 100%">
            <div class="div_flex" style="width: 80%;height: 60%;margin: 0 auto;">
                兔子呈现了&nbsp;&nbsp;<input id="ans" value="" type="text" oninput="value=value.replace(/[^\d]/g,'')">&nbsp;&nbsp;秒
            </div>
            <div class="div_flex" style="width: 80%;height: 20%;margin: 0 auto;">
                <button id="btn" class="btn">确认</button>
            </div>
        </div>
    </div>
    <div id="item6" class="item item6 div_flex hide"></div>
</div>
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script>
    $(function () {
        var data1=[3000,6000,12000,15000,30000,45000];
        var data2=[5000,10000];
        var timer1=null,timer2=null,timer3=null,timer4=null;
        var time1=500,time2=1000,time3=0,time4=1000;
        var data_index=-1,taskid=0,taskid1="5998",taskid2="5997";
        var spacer1=true,reward=true,spacer3=false;
        var time,beginTime,endTime;
        var correctanswerset=[],buttonset=[],commentset=[],stimidset=[],numset=[],type4set=[];
        var data=[];
        taskid=getUrlParam("taskid");
        taskidFun(taskid);
        $("#btn").on("click",function () {
            var ans="";
            var ans1=data[data_index]/1000;
            var APH;
            ans=$("#ans").val();
            buttonset.push(ans);
            type4set.push("0");
            correctanswerset.push(ans1);
            commentset.push(ans1);
            stimidset.push(data_index);
            APH=Math.abs(parseInt(ans)-parseInt(ans1));
            numset.push(APH);
            $("#item5").addClass("hide");
            if(reward){
                $("#item6").removeClass("ls hs");

                if(ans == ans1){
                    $("#item6").addClass("ls");
                    $("#item6").text("答对了，是"+ans1+"秒")
                }else {
                    $("#item6").addClass("hs");
                    $("#item6").text("答错了，是"+ans1+"秒")
                }
                timer4Fun();
            }else {
                timer1Fun();
            }

        });


        function timer1Fun() {
            data_index++;
            if(data_index>=data.length){
                post_result();
            }
            $("#ans").val("");
            time3=data[data_index];
            $("#item2").removeClass("hide");
            timer1 = setInterval(function () {
                $("#item2").addClass("hide");
                timer2Fun();
                clearInterval(timer1);
                timer1=null;
            }, time1);
        }
        function timer2Fun() {
            $("#item3").removeClass("hide");
            timer2 = setInterval(function () {
                $("#item3").addClass("hide");
                timer3Fun();
                clearInterval(timer2);
                timer2=null;
            }, time2);
        }
        function timer3Fun() {
            $("#item4").removeClass("hide");
            timer3 = setInterval(function () {
                $("#item4").addClass("hide");
                $("#item5").removeClass("hide");
                $("#ans").focus();
                clearInterval(timer3);
                timer3=null;
            }, time3);
        }
        function timer4Fun() {
            $("#item6").removeClass("hide");
            timer4 = setInterval(function () {
                $("#item6").addClass("hide");
                timer1Fun();
                clearInterval(timer4);
                timer4=null;
            }, time4);
        }

        function taskidFun(taskid){
            data=[];
            if(taskid === taskid1){
                $("#zdy").text("屏幕中央将出现一根胡萝卜，紧接着出现一只兔子。请记住兔子从出现到消失的持续时间，并通过按键盘上的数字，把答案输入到括号里。按确认键继续。在任何时候都不得使用时钟或秒表计时。准备好了按 空格键 开始正式测试");
                reward=false;
                for(var t=0;t<3;t++){
                    pushArr(data1);
                    data=data.concat(data1)
                }
            }else if(taskid === taskid2){
                $("#zdy").text("屏幕中央将出现一根胡萝卜，紧接着出现一只兔子。请记住兔子从出现到消失的持续时间，并通过按键盘上的数字，把答案输入到括号里。按确认键继续。在任何时候都不得使用时钟或秒表计时。让我们先来练习一下，准备好了 按 空格键开始");
                reward=true;
                data=data2;
                pushArr(data);
            }

            console.log(data)
        }
        function restFun() {
            $("#item5").addClass("hide");
            $("#item4").removeClass("hide");
        }
        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        function pushArr(array) {
            for (var i = array.length - 1; i > 0; i--) {
                var j = Math.floor(Math.random() * (i + 1));
                var temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
        }
        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k === 32){
                if(spacer1){
                    spacer1=false;
                    $("#item1").addClass("hide");
                    timer1Fun();
                }
            }
        });
        /*$(document).keyup(function () {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k === 32){
                if(spacer3){
                    spacer3=false;
                    endTime=new Date().getTime();
                    time = (endTime - beginTime).toFixed(0);
                    buttonset.push(time);
                    $("#item4").addClass("hide");
                    timer4Fun();
                }
            }
        })*/
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
            opes_result_data.type4set = type4set.join(";");
            opes_result_data.stimidset = stimidset.join(";");
            opes_result_data.correctanswerset = correctanswerset.join(";");
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = "";
            opes_result_data.radioset = "";
            opes_result_data.buttonset = buttonset.join(";");
            opes_result_data.commentset = commentset.join(";");
            opes_result_data.numset = numset.join(";");
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;
        }
    })
</script>
</html>