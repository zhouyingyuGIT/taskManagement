<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>时间计算</title>
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
    <div id="reward" class="hide div_flex"></div>
    <div id="item1" class="item">
        <div class="zdy div_flex">
            <img src="zdy.png" alt="">
        </div>
    </div>

    <div id="item2" class="hide item div_flex">
        <div class="item2">
            <div id="topic" class="item2_topic div_flex"></div>
            <div class="item2_input div_flex">
                <div class="input_num input_num1 div_flex">
                    <label id="label1" for="input_num1"><input id="input_num1" type="text" value="" oninput="value=value.replace(/[^\d]/g,'')"><span class="input_text" id="input_text1"></span></label>
                    <label id="label2" for="input_num2"><input id="input_num2" type="text" value="" oninput="value=value.replace(/[^\d]/g,'')"><span class="input_text" id="input_text2"></span></label>
                    <label id="label3" for="input_num3"><input id="input_num3" type="text" value="" oninput="value=value.replace(/[^\d]/g,'')"><span class="input_text" id="input_text3"></span></label>
                </div>
            </div>
            <div class="item2_btn div_flex">
                <button id="btn" class="btn">确认</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script>
$(function () {
    var data=[
        {"id":"1","topic":"2分3秒+4分6秒等于","ans1":"6","ans1Text":"分","ans2":"9","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"2","topic":"12分20秒+3分45秒等于","ans1":"16","ans1Text":"分","ans2":"5","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"3","topic":"5分20秒-3分10秒等于","ans1":"2","ans1Text":"分","ans2":"10","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"4","topic":"5分20秒-3分40秒等于","ans1":"1","ans1Text":"分","ans2":"40","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"}
    ];
    var data_index=0,data_lenght;
    var spacer=true;
    var time,beginTime,endTime;
    var timer1=null,timer;
    var maxtime=1200,time1=1000;
    var corT=[],butT=[];
    var stimidset=[],timeset=[],correctanswerset=[],buttonset=[],type4set=[],commentset=[];
    data_lenght=data.length;
    pushArr(data);

    function topicFun(data_index){
        $("#label3").addClass("hide");
        $("#topic").text(data[data_index].topic);
        $("#input_text1").text(data[data_index].ans1Text);
        $("#input_text2").text(data[data_index].ans2Text);
        if(data[data_index].inputNum ==="3"){
            $("#label3").removeClass("hide");
            $("#input_text3").text(data[data_index].ans3Text);
        }
    }

    $("#btn").on("click",function () {
        var a1,a2,a3,b1,b2,b3,at;
        at=true;
        endTime=new Date().getTime();
        time = (endTime - beginTime).toFixed(0);
        a1=$("#input_num1").val();
        a2=$("#input_num2").val();
        b1=data[data_index].ans1;
        b2=data[data_index].ans2;
        corT[0]=b1;corT[1]=b2;
        butT[0]=a1;butT[1]=a2;
        if(data[data_index].inputNum ==="3"){
            a3=$("#input_num3").val();
            b3=data[data_index].ans3;
            corT[2]=b3;butT[2]=a3;
            if(a3 !== b3){
                at=false;
            }
        }
        if(a1 === b1 && a2 === b2 && at){
            $("#reward").text("答对了");
            commentset.push(1);
        }else {
            $("#reward").text("答错了");
            commentset.push(0);
        }
        correctanswerset.push(corT.join(","));
        buttonset.push(butT.join(","));
        stimidset.push(data[data_index].id);
        timeset.push(time);
        type4set.push(0);
        timer1Fun();
    });

    function timer1Fun() {
        $("#reward").removeClass("hide");
        data_index++;

        timer1 = setInterval(function () {
            if(data_index>=data_lenght){
                post_result();
            }
            init();
            $("#reward").addClass("hide");
            topicFun(data_index);
            beginTime=new Date().getTime();
            clearInterval(timer1);
            timer1=null;
        }, time1);
    }

    function CountDown() {
        if (maxtime > 1) {
            --maxtime;
        } else{
            post_result();
            clearInterval(timer);
            timer=null;
        }
    }

    function init() {
        $("#topic").text("");
        $("#input_text1").text("");
        $("#input_text2").text("");
        $("#input_text3").text("");
        $("#input_num1").val("");
        $("#input_num2").val("");
        $("#input_num3").val("");
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
        if(k == 32){
            if(spacer){
                spacer=false;
                $("#item1").addClass("hide");
                $("#item2").removeClass("hide");
                topicFun(data_index);
                beginTime=new Date().getTime();
                timer = setInterval(function () {
                    CountDown();
                }, 1000);
            }
        }
    });
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
        opes_result_data.timeset = timeset.join(";");
        opes_result_data.radioset = "0";
        opes_result_data.buttonset = buttonset.join(";");
        opes_result_data.commentset = commentset.join(";");
        opes_result_data.numset = "0";
        opes_post_result_util_js_opes_post_result(opes_result_data);
        return;
    }
})
</script>
</html>