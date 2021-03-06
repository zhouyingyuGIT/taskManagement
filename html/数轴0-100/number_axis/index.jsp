<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>多维心理</title>
    <link rel="stylesheet" href="/lattice/css/rangeslider.css">
    <style>
        *{
            margin: 0px;
            padding: 0px;
        }
        html,body{
            height: 100%;
            width: 100%;
            background: #0C0C0C;
        }
        .hide{
            display: none;
        }
        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
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
        }
        .btn-group-lg>.btn, .btn-lg {
            padding: 10px 38px;
            font-size: 24px;
            line-height: 1.3333333;
            border-radius: 6px;
        }
        .btn-primary {
            color: #fff;
            background-color: #337ab7;
            border-color: #2e6da4;
        }
        .irs--flat .irs-line{
            top: 17px;
            height: 40px;
        }
        .irs--flat .irs-bar{
            background-color:transparent;
        }
        .irs--flat .irs-handle{
            height: 30px;
            width: 0px;
        }
        .irs-single{
            display: none;
        }
        #bt  .irs-min, #bt .irs-max{
            display: block;
            visibility: visible !important;
            font-size: 16px;
            top: -10px;
            color: #000;
            font-weight: 900;
        }
        .irs-min,.irs-single,.irs-max{
            /*visibility: hidden;*/
            /*display: none;*/
            z-index: 999;
        }
        .irs-max{
            right: -22px;
        }
        .item{
            height: 100%;
            width: 100%;
            background: #000;
            position: relative;
        }
        .imgBox{
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .imgBox img{
            width:auto;
            height:100vh;
        }
        .time{
            position: absolute;
            top: 20px;
            right: 40px;
            font-size: 38px;
            color: #ff0000;
            z-index: 9999;
        }
        .irs-line{
            opacity: 0;
            cursor: pointer;
        }
        .item2{
            width: 1000px;
            height: 260px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -130px;
            margin-left: -500px;
        }
        .num{
            font-size: 36px;
            font-weight: 900;
            color: #fff;
            text-align: left;
            padding-bottom: 50px;
        }
        .bt{
            position: relative;
            width: 100%;
            top: -14px
        }
        .hr{
            height: 2px;
            border: 0px;
            background: #ff0000;
            position: absolute;
            top: 36px;
            z-index: 0;
            width: 100%;
        }
        .cb{
            width: 10px;
            height: 50px;
            background: #000;
            position: absolute;
            z-index: 99;
            top: 10px
        }
        .cb1{
            left: -3px;
        }
        .cb2{
            right: -3px;
        }
    </style>
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
<div class="time hide" id="tir"></div>

<div class="item" id="item1">
    <div class="item imgBox" id="item1_1">
        <img src="zdy1.png" alt="">
    </div>
</div>
<div id="item2" class="hide item2">
    <div id="num" class="num"></div>
    <div id="bt" class="bt">
        <hr class="hr">
        <div class="cb cb1"></div>
        <div class="cb cb2"></div>
        <div id="js-range-slider"></div>
        <div style="width: 2px;height: 36px;background: #ff0000;position: absolute;left: 7px;z-index: 999;top: 20px"></div>
        <div style="width: 2px;height: 36px;background: #ff0000;position: absolute;right: 7px;z-index: 999;top: 20px"></div>
    </div>
    <div style="text-align: left;padding-top: 30px;">
        <button id="btn" class="btn btn-lg btn-primary">下一题</button>
    </div>
</div>
<!--<output></output>-->
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script src="/lattice/js/rangeslider.js"></script>
<script type="text/javascript">
    $(function () {
        var space=true;
        var timer=null;
        var maxtime=120;
        var num,estimate,PAE;
        var beginTime,endTime,time;
        var correctanswerset=[],numset=[],commentset=[],timeset=[];
        $("#js-range-slider").ionRangeSlider({
            skin: "flat",
            min: 0,
            max: 100,
            step: 0.01,
            from: 0
        });
        var slider = $("#js-range-slider").data("ionRangeSlider");

        $("#btn").on("click",function () {
            estimate="";PAE=0;
            var absNum,indexX,indexY;
            endTime=new Date().getTime();
            time=(endTime-beginTime).toFixed(0);
            estimate=($(".irs-single").text()).replace(/\s/g,"");
            absNum=(Math.abs(Number(estimate)-num))/100;
            indexX=String(PAE).indexOf('.') + 1;
            indexY=String(PAE).length - indexX;
            if(indexY>3){
                PAE=absNum.toFixed(3);
            }else {
                PAE=absNum;
            }
            correctanswerset.push(num);
            numset.push(estimate);
            commentset.push(PAE);
            timeset.push(time);
            beginTime=new Date().getTime();
            num=random(1, 100);
            $("#num").text(num);

            slider.update({
                min: 0,
                max: 100,
                from: 0,
                step: 0.01
            });
        });
        function random(lower, upper) {
            return Math.floor(Math.random() * (upper - lower)) + lower;
        }

        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k==32){
                if(space){
                    space=false;
                    CountdownFun();
                    beginTime=new Date().getTime();
                    num=random(1, 100);
                    $("#num").text(num);
                    $("#item1").addClass("hide");
                    $("#item2").removeClass("hide");
                    $("#tir").removeClass("hide");

                }
            }
        });
        function CountdownFun() {
            timer = setInterval(function () {
                CountDown();
            }, 1000);
        }

        function CountDown() {
            if (maxtime >= 0) {
                $("#tir").text(maxtime+" 秒");
                --maxtime;
            } else{
                $("#tir").addClass("hide");
                post_result();
                clearInterval(timer);
                timer=null;
            }
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
            opes_result_data.correctanswerset = correctanswerset.join(";");
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = timeset.join(";");
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = "0";
            opes_result_data.commentset = commentset.join(";");
            opes_result_data.numset = numset.join(";");
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;
        }

    })
</script>
</html>