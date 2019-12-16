<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
    <div id="item2" class="item hide" style="background: #000"></div>
    <div id="item3" class="item div_flex hide">
        <img src="xyy.png" alt="">
    </div>
    <div id="item4" class="item hide" style="background: #000"></div>
    <div id="item5" class="item div_flex hide">
        <img src="dlam.png" alt="">
    </div>
    <div id="item6" class="item hide">
        <div class="div_flex" style="height: 26%;font-size: 3em;font-weight: 900;">
            请判断哪个持续的时间久，按pq键反应
        </div>
        <div class="div_flex" style="height: 70%">
            <div class="div_flex" style="width: 50%;height: 100%">
                <img src="xyy.png" alt="" style="max-width: 80%;max-height: 80%">
            </div>
            <div class="div_flex" style="width: 50%;height: 100%">
                <img src="dlam.png" alt="" style="max-width: 80%;max-height: 80%">
            </div>
        </div>
    </div>
    <div id="item7" class="item div_flex hide">

    </div>
</div>
</body>
<script src="/lattice/js/jquery.3.4.1.js"></script>
<script>
    $(function () {
        var data=[1500,2250,2400,2500,3600,3750,4000,6000],xyy=[],dlam=[];
        var spacer=true,allKey=false,reward=false;
        var timer1=null,timer2=null,timer3=null,timer4=null,timer5=null;
        var time1=500,time2=3000,time3=2000,time4=0,time5=2000;
        var data_index=-1,data_length=0,taskid=0,taskid1="7018",taskid2="7017";
        var correctanswerset=[],buttonset=[],commentset=[],stimidset=[];
        taskid=getUrlParam("taskid");
        taskidFun(taskid);
        function timer1Fun() {
            data_index++;
            if(data_index>=data_length){
                post_result();
            }
            time4=dlam[data_index];
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
                timer4Fun();
                clearInterval(timer3);
                timer3=null;
            }, time3);
        }

        function timer4Fun() {
            $("#item5").removeClass("hide");
            timer4 = setInterval(function () {
                $("#item5").addClass("hide");
                allKey=true;
                $("#item6").removeClass("hide");
                clearInterval(timer4);
                timer4=null;
            }, time4);
        }

        function timer5Fun() {
            $("#item6").addClass("hide");
            $("#item7").removeClass("hide");
            timer5 = setInterval(function () {
                $("#item7").addClass("hide");
                timer1Fun();
                clearInterval(timer5);
                timer5=null;
            }, time5);
        }
        function taskidFun(taskid){
            dlam=[];
            if(taskid === taskid1){
                $("#zdy").text("屏幕中央将相继出现一只白色的喜羊羊和一只蓝色的机器猫，请判断哪个持续时间长。若白色的喜羊羊持续的时间长请按q键，蓝色的机器猫持续的时间长请按p键。在任何时候都不得使用时钟和秒表计数，也不得出现不出声的计数方法。准备好了按 空格键 开始测试");
                reward=false;
                for(var t=0;t<7;t++){
                    pushArr(data);
                    dlam=dlam.concat(data)
                }
            }else if(taskid === taskid2){
                $("#zdy").text("屏幕中央将相继出现一只白色的喜羊羊和一只蓝色的机器猫，请判断哪个持续时间长。若白色的喜羊羊持续的时间长请按q键，蓝色的机器猫持续的时间长请按p键。在任何时候都不得使用时钟和秒表计数，也不得出现不出声的计数方法。准备好了请按空格键开始练习");
                reward=true;
                dlam=[1500,2400,3600,4000];
                pushArr(dlam);
            }
            data_length=dlam.length;
            commentset=dlam;
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
        function allKeyFun(key){
            var ans1="";
            if(dlam[data_index]<3000){
                correctanswerset.push("Q");
                ans1="Q";
            }else {
                correctanswerset.push("P");
                ans1="P";
            }
            buttonset.push(key);
            stimidset.push(data_index);
            if(reward){
                $("#item7").removeClass("ls hs");
                if(ans1 === key){
                    $("#item7").addClass("ls");
                    $("#item7").text("答对了")
                }else {
                    $("#item7").addClass("hs");
                    $("#item7").text("答错了");
                }
            }
            timer5Fun();
        }

        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k === 32){
                if(spacer){
                    spacer=false;
                    $("#item1").addClass("hide");
                    timer1Fun();
                }
            }
            if(k === 81){
                if(allKey){
                    allKey=false;
                    allKeyFun("Q")
                }
            }
            if(k === 80){
                if(allKey){
                    allKey=false;
                    allKeyFun("P")
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
            opes_result_data.type4set = "0";
            opes_result_data.stimidset = stimidset.join(";");
            opes_result_data.correctanswerset = correctanswerset.join(";");
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = "0";
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