<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>感数任务</title>
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
    <div id="item1" class="item item1">
        <div class="item1_1 div_flex">
            <%=ots.get(0).getInstruction() %>
        </div>
    </div>
    <div id="item2" class="item hide">
        <div id="item2_1" class="item2_1">
            <div id="imgBox" class="imgBox div_flex">
                <div id="item2_1_1" class="item2_1_1">
                    <img id="img" src="" alt="">
                </div>
            </div>
        </div>
    </div>
    <div id="item3" class="item item1 hide">
        <div class="item1_1 div_flex">谢谢</div>
    </div>
    <div id="item4" class="item item4 hide div_flex">
        +
    </div>
</div>
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script>
    $(function () {
        var data1=[

            {"ID":"2","ANS":"1","TOPIC":"img/A_1_2.png"},
            {"ID":"3","ANS":"1","TOPIC":"img/A_1_3.png"},
            {"ID":"4","ANS":"1","TOPIC":"img/A_1_4.png"},
            {"ID":"5","ANS":"1","TOPIC":"img/A_1_5.png"},
            {"ID":"6","ANS":"2","TOPIC":"img/A_2_1.png"},
            {"ID":"7","ANS":"2","TOPIC":"img/A_2_2.png"},
            {"ID":"8","ANS":"2","TOPIC":"img/A_2_3.png"},
            {"ID":"9","ANS":"2","TOPIC":"img/A_2_4.png"},
            {"ID":"10","ANS":"2","TOPIC":"img/A_2_5.png"},
            {"ID":"11","ANS":"3","TOPIC":"img/A_3_1.png"},
            {"ID":"12","ANS":"3","TOPIC":"img/A_3_2.png"},
            {"ID":"13","ANS":"3","TOPIC":"img/A_3_3.png"},
            {"ID":"14","ANS":"3","TOPIC":"img/A_3_4.png"},
            {"ID":"15","ANS":"3","TOPIC":"img/A_3_5.png"},
            {"ID":"16","ANS":"4","TOPIC":"img/A_4_1.png"},
            {"ID":"17","ANS":"4","TOPIC":"img/A_4_2.png"},
            {"ID":"18","ANS":"4","TOPIC":"img/A_4_3.png"},
            {"ID":"19","ANS":"4","TOPIC":"img/A_4_4.png"},
            {"ID":"20","ANS":"4","TOPIC":"img/A_4_5.png"},
            {"ID":"21","ANS":"1","TOPIC":"img/B_1_1.png"},
            {"ID":"22","ANS":"1","TOPIC":"img/B_1_2.png"},
            {"ID":"23","ANS":"1","TOPIC":"img/B_1_3.png"},
            {"ID":"24","ANS":"1","TOPIC":"img/B_1_4.png"},
            {"ID":"25","ANS":"1","TOPIC":"img/B_1_5.png"},
            {"ID":"26","ANS":"2","TOPIC":"img/B_2_1.png"},
            {"ID":"27","ANS":"2","TOPIC":"img/B_2_2.png"},
            {"ID":"28","ANS":"2","TOPIC":"img/B_2_3.png"},
            {"ID":"29","ANS":"2","TOPIC":"img/B_2_4.png"},
            {"ID":"30","ANS":"2","TOPIC":"img/B_2_5.png"},
            {"ID":"31","ANS":"3","TOPIC":"img/B_3_1.png"},
            {"ID":"32","ANS":"3","TOPIC":"img/B_3_2.png"},
            {"ID":"33","ANS":"3","TOPIC":"img/B_3_3.png"},

            {"ID":"35","ANS":"3","TOPIC":"img/B_3_5.png"},
            {"ID":"36","ANS":"4","TOPIC":"img/B_4_1.png"},
            {"ID":"37","ANS":"4","TOPIC":"img/B_4_2.png"},
            {"ID":"38","ANS":"4","TOPIC":"img/B_4_3.png"},
            {"ID":"39","ANS":"4","TOPIC":"img/B_4_4.png"},
            {"ID":"40","ANS":"4","TOPIC":"img/B_4_5.png"}
        ];
        var data2=[
            {"ID":"1","ANS":"1","TOPIC":"img/A_1_1.png"},
            {"ID":"34","ANS":"3","TOPIC":"img/B_3_4.png"},
        ];
        var data=[];
        var time1=100,time2=20,time3=1000,time4=1000,time5=1000;
        var timer1=null,timer2=null,timer3=null,timer4=null,timer5=null;
        var spacer=true,PKey=false,numKey=false,feedback=false;
        var color_index=200,back_color=200,data_index=0,taskid;
        var time,beginTime,endTime;
        var stimidset=[],timeset=[],correctanswerset=[],buttonset=[],type4set=[],commentset=[];
        var data_length;
        taskid=getUrlParam("taskid");
        taskidFun(taskid);
        function taskidFun(taskid){
            if(taskid === "7036"){
                data=data1;
                feedback=true;
            }else if(taskid === "7049"){
                data=data2;
                feedback=false;
            }
            data_length=data.length;
            pushArr(data);
        }
        function keyFun(key) {
            if(numKey){
                numKey=false;
                clearIntervalFun();
                endTime=new Date().getTime();
                var ans=key;
                var ans1=data[data_index].ANS;
                time = (endTime - beginTime).toFixed(0);
                stimidset.push(data[data_index].ID);
                correctanswerset.push(ans1);
                buttonset.push(ans);
                type4set.push("1");
                if(ans1 == ans){
                    commentset.push("1");
                    $("#reward").text("答对了")
                }else {
                    commentset.push("0");
                    $("#reward").text("答错了")
                }
                timeset.push(time);
                color_index=200;
                if (feedback){
                    data_index++;
                    if(data_index>=data_length){
                        timer5Fun();
                        return;
                    }
                    topicFun(data_index);
                    timer3Fun();
                }else {
                    timer4Fun();
                }
            }
        }

        function timer1Fun() {
            $("#item2_1_1").css({"background":"rgb("+color_index+","+color_index+","+color_index+")"});
            timer1 = setInterval(function () {
                timer2Fun();
                clearInterval(timer1);
                timer1=null;
            }, time1);
        }
        function timer2Fun() {
            $("#item2_1_1").css({"background":"rgb("+back_color+","+back_color+","+back_color+")"});
            timer2 = setInterval(function () {
                color_index=color_index-0.2;
                timer1Fun();
                clearInterval(timer2);
                timer2=null;
            }, time2);
        }
        function timer3Fun() {
            $("#item2").addClass("hide");
            $("#item4").removeClass("hide");
            timer3 = setInterval(function () {
                $("#item4").addClass("hide");
                $("#item2").removeClass("hide");
                timer1Fun();
                topicAnsFun(true);
                beginTime=new Date().getTime();
                // PKey=true;
                numKey=true;
                clearInterval(timer3);
                timer3=null;
            }, time3);
        }
        function timer4Fun() {
            $("#reward").removeClass("hide");
            timer4 = setInterval(function () {
                $("#reward").addClass("hide");
                data_index++;
                if(data_index>=data_length){
                    timer5Fun();
                    return;
                }
                topicFun(data_index);
                timer3Fun();
                clearInterval(timer4);
                timer4=null;
            }, time4);
        }
        function timer5Fun() {
            $("#item2").addClass("hide");
            $("#item3").removeClass("hide");
            timer5= setInterval(function () {
                post_result();
                clearInterval(timer5);
                timer5=null;
            }, time5);
        }

        function topicAnsFun(y) {
            if(y){
                $("#imgBox").removeClass("hide");
                $("#ans").addClass("hide");
            }else {
                $("#imgBox").addClass("hide");
                $("#ans").removeClass("hide");
            }
        }

        function topicFun(data_index) {
            $("#img").attr("src",data[data_index].TOPIC)
        }
        function clearIntervalFun(){
            clearInterval(timer2);
            clearInterval(timer1);
            timer2=null;
            timer1=null;
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
            if(k === 32){
                if(spacer){
                    spacer=false;
                    // PKey=true;
                    numKey=true;
                    $("#item1").addClass("hide");
                    $("#item2").removeClass("hide");
                    topicFun(data_index);
                    timer3Fun();
                }

            }

            if(k === 97 || k === 49){
                keyFun("1")
            }
            if(k===98 || k === 50){
                keyFun("2")
            }
            if(k===99 || k === 51){
                keyFun("3")
            }
            if(k===100 || k === 52){
                keyFun("4")
            }
            if(k===101 || k === 53){
                keyFun("5")
            }
            if(k===102 || k === 54){
                keyFun("6")
            }
            if(k===103 || k === 55){
                keyFun("7")
            }
            if(k===104 || k === 56){
                keyFun("8")
            }
            if(k===105 || k === 57){
                keyFun("9")
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
            opes_result_data.radioset = "";
            opes_result_data.buttonset = buttonset.join(";");
            opes_result_data.commentset = commentset.join(";");
            opes_result_data.numset = commentset.join(";");
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;
        }
    })
</script>
</html>