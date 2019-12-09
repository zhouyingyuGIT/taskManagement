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
            <img id="zdy" src="zdy.png" alt="">
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
    var data1=[
        {"id":"1","topic":"5分45秒+2分12秒等于","ans1":"7","ans1Text":"分","ans2":"57","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"2","topic":"25分6秒+14分20秒等于","ans1":"39","ans1Text":"分","ans2":"26","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"3","topic":"4分2秒+45秒等于","ans1":"4","ans1Text":"分","ans2":"47","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"4","topic":"5分32秒+20秒等于","ans1":"5","ans1Text":"分","ans2":"52","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"5","topic":"1时20分+15分等于","ans1":"1","ans1Text":"时","ans2":"35","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"6","topic":"3时30分+6时10分等于","ans1":"9","ans1Text":"时","ans2":"40","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"7","topic":"6时25分+20分等于","ans1":"6","ans1Text":"时","ans2":"45","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"8","topic":"2时10分+5时37分等于","ans1":"7","ans1Text":"时","ans2":"47","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"9","topic":"4时23分8秒+3时7分34秒等于","ans1":"7","ans1Text":"时","ans2":"30","ans2Text":"分","ans3":"42","ans3Text":"秒","inputNum":"3"},
        {"id":"10","topic":"6时45分2秒+2时12分13秒等于","ans1":"8","ans1Text":"时","ans2":"57","ans2Text":"分","ans3":"15","ans3Text":"秒","inputNum":"3"},
        {"id":"11","topic":"4时34分-20分等于","ans1":"4","ans1Text":"时","ans2":"14","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"12","topic":"6时20分-13分等于","ans1":"6","ans1Text":"时","ans2":"7","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"13","topic":"20时30分-8时10分等于","ans1":"12","ans1Text":"时","ans2":"20","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"14","topic":"9时40分-7时25分等于","ans1":"2","ans1Text":"时","ans2":"15","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"15","topic":"7分50秒-6分23秒等于","ans1":"1","ans1Text":"分","ans2":"27","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"16","topic":"12分45秒-3分20秒等于","ans1":"9","ans1Text":"分","ans2":"25","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"17","topic":"2分50秒-24秒等于","ans1":"2","ans1Text":"分","ans2":"26","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"18","topic":"12分48秒-23秒等于","ans1":"12","ans1Text":"分","ans2":"25","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"19","topic":"7时36分25秒-3时23分5秒等于","ans1":"4","ans1Text":"时","ans2":"13","ans2Text":"分","ans3":"20","ans3Text":"秒","inputNum":"3"},
        {"id":"20","topic":"15时45分21秒-5时12分11秒等于","ans1":"10","ans1Text":"时","ans2":"33","ans2Text":"分","ans3":"10","ans3Text":"秒","inputNum":"3"},
        {"id":"21","topic":"1时20分+45分等于","ans1":"2","ans1Text":"时","ans2":"5","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"22","topic":"5时30分+55分等于","ans1":"6","ans1Text":"时","ans2":"25","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"23","topic":"10时40分+60分等于","ans1":"11","ans1Text":"时","ans2":"40","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"24","topic":"1分30秒+45秒等于","ans1":"2","ans1Text":"分","ans2":"15","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"25","topic":"6分18秒+50秒等于","ans1":"7","ans1Text":"分","ans2":"8","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"26","topic":"6分20秒+48秒等于","ans1":"7","ans1Text":"分","ans2":"8","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"27","topic":"3时22分+4时45分等于","ans1":"8","ans1Text":"时","ans2":"7","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"28","topic":"2时35分+2时50分等于","ans1":"5","ans1Text":"时","ans2":"25","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"29","topic":"4时34分+2时45分等于","ans1":"7","ans1Text":"时","ans2":"19","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"30","topic":"2分32秒+7分30秒等于","ans1":"10","ans1Text":"分","ans2":"2","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"31","topic":"9分35秒+3分46秒等于","ans1":"13","ans1Text":"分","ans2":"21","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"32","topic":"1分23秒+4分40秒等于","ans1":"6","ans1Text":"分","ans2":"3","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"33","topic":"5时23分9秒+3时40分4秒等于","ans1":"9","ans1Text":"时","ans2":"3","ans2Text":"分","ans3":"13","ans3Text":"秒","inputNum":"3"},
        {"id":"34","topic":"3时10分24秒+1时36分50秒等于","ans1":"4","ans1Text":"时","ans2":"47","ans2Text":"分","ans3":"14","ans3Text":"秒","inputNum":"3"},
        {"id":"35","topic":"5时20分56秒+3时20分14秒等于","ans1":"8","ans1Text":"时","ans2":"41","ans2Text":"分","ans3":"10","ans3Text":"秒","inputNum":"3"},
        {"id":"36","topic":"3时56分20秒+2时10分45秒等于","ans1":"6","ans1Text":"时","ans2":"7","ans2Text":"分","ans3":"5","ans3Text":"秒","inputNum":"3"},
        {"id":"37","topic":"5时23分45秒+2时45分20秒等于","ans1":"8","ans1Text":"时","ans2":"9","ans2Text":"分","ans3":"5","ans3Text":"秒","inputNum":"3"},
        {"id":"38","topic":"4时56分2秒+4时24分59秒等于","ans1":"9","ans1Text":"时","ans2":"31","ans2Text":"分","ans3":"1","ans3Text":"秒","inputNum":"3"},
        {"id":"39","topic":"5时10分-3时30分等于","ans1":"1","ans1Text":"时","ans2":"4","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"40","topic":"10时25分-3时40分等于","ans1":"6","ans1Text":"时","ans2":"45","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"41","topic":"4时15分-1时46分等于","ans1":"1","ans1Text":"时","ans2":"29","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"42","topic":"4时25分-55分等于","ans1":"3","ans1Text":"时","ans2":"30","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"43","topic":"15时30分-40分等于","ans1":"14","ans1Text":"时","ans2":"50","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"44","topic":"5时34分-44分等于","ans1":"4","ans1Text":"时","ans2":"50","ans2Text":"分","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"45","topic":"3分40秒-55秒等于","ans1":"2","ans1Text":"分","ans2":"45","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"46","topic":"11分25秒-30秒等于","ans1":"2","ans1Text":"分","ans2":"55","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"47","topic":"7分2秒-45秒等于","ans1":"6","ans1Text":"分","ans2":"17","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"48","topic":"30分28秒-15分32秒等于","ans1":"14","ans1Text":"分","ans2":"56","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"49","topic":"16分2秒-11分40秒等于","ans1":"4","ans1Text":"分","ans2":"22","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"50","topic":"5分40秒-3分50秒等于","ans1":"1","ans1Text":"分","ans2":"50","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"51","topic":"8时56分24秒-3时23分40秒等于","ans1":"5","ans1Text":"时","ans2":"32","ans2Text":"分","ans3":"44","ans3Text":"秒","inputNum":"3"},
        {"id":"52","topic":"9时34分20秒-5时20分35秒等于","ans1":"4","ans1Text":"时","ans2":"13","ans2Text":"分","ans3":"45","ans3Text":"秒","inputNum":"3"},
        {"id":"53","topic":"20时45分28秒-8时34分40秒等于","ans1":"12","ans1Text":"时","ans2":"10","ans2Text":"分","ans3":"48","ans3Text":"秒","inputNum":"3"},
        {"id":"54","topic":"18时24分45秒-12时30分50秒等于","ans1":"5","ans1Text":"时","ans2":"53","ans2Text":"分","ans3":"55","ans3Text":"秒","inputNum":"3"},
        {"id":"55","topic":"4时45分24秒-2时50分45秒等于","ans1":"1","ans1Text":"时","ans2":"54","ans2Text":"分","ans3":"39","ans3Text":"秒","inputNum":"3"},
        {"id":"56","topic":"7时20分50秒-4时50分55秒等于","ans1":"2","ans1Text":"时","ans2":"29","ans2Text":"分","ans3":"55","ans3Text":"秒","inputNum":"3"}
    ],data2=[
        {"id":"1","topic":"2分3秒+4分6秒等于","ans1":"6","ans1Text":"分","ans2":"9","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"2","topic":"12分20秒+3分45秒等于","ans1":"16","ans1Text":"分","ans2":"5","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"3","topic":"5分20秒-3分10秒等于","ans1":"2","ans1Text":"分","ans2":"10","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"},
        {"id":"4","topic":"5分20秒-3分40秒等于","ans1":"1","ans1Text":"分","ans2":"40","ans2Text":"秒","ans3":"0","ans3Text":"0","inputNum":"2"}
    ];
    var data=[];
    var data_index=0,data_lenght;
    var spacer=true,taskid=0,feedback=false;
    var time,beginTime,endTime;
    var timer1=null,timer;
    var maxtime=1200,time1=200;
    var corT=[],butT=[];
    var stimidset=[],timeset=[],correctanswerset=[],buttonset=[],type4set=[],commentset=[];
    taskid=getUrlParam("taskid");
    taskidFun(taskid);
    function taskidFun(taskid){
        if(taskid === "5981"){
            data=data1;
            $("#zdy").attr("src","zdy1.png");
            time1=200;
            $("#reward").addClass("op");
            feedback=false;
        }else if(taskid === "5980"){
            data=data2;
            $("#zdy").attr("src","zdy.png");
            time1=1000;
            $("#reward").removeClass("op");
            feedback=true;
        }
    }

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
            commentset.push(1);
            if(feedback){
                $("#reward").text("答对了");
            }
        }else {
            commentset.push(0);
            if(feedback){
                $("#reward").text("答错了");
            }
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
        if(data_index>=data_lenght){
            post_result();
        }
        timer1 = setInterval(function () {
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
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
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