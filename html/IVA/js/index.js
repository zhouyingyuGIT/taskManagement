var instructionTime={
    time1:2000, //2000方块呈现时间
    time2:1000, //1000"你会在屏幕上看到闪的数字，就像这样"指导语呈现时间
    time3:500,  //数字1呈现时间
    time4:1000, //间隙时间
    time5:2000, //2000"数字始终是(1)"指导语呈现时间
    time6:2000, //2000"当你看到数字时，请点击鼠标左键一次"指导语呈现时间
    time7:2000, //2000"请尽量快速并准确地点击鼠标"指导语呈现时间
    time8:4000,//4000 "你会在屏幕上看到闪的数字，就像这样:"
    time9:2000,//2000"数字始终是(1)"
    time10:3000,//3000"请尽量快速并准确地点击鼠标"
    time11:5000,//5000"当你看到数字时，请点击鼠标左键一次"
};
var convert=0;
/*热身阶段数据*/
var clickCount=0,clickSwitch=false;
var hotTestViewResult = ["0","0","0","0","0","0","0","0","0","0"]; // 记录 热身测试视觉的结果;
var hotTestSoundResult = ["0","0","0","0","0","0","0","0","0","0"]; // 记录 热身测试的测试结果
var instructionTimer=null,hintTimer=null;
var testSwitch=false;
var viewSoundSwitch=true;
var SKeyTest=false;
var isView=false,isSound=false;
var count=0,numCount=3;//3热身数字1闪烁次数
var test=0,testCount=10;//10测试次数
var layoutSet = {
    pageStyle: {
        width: 100, // 宽度 百分比
        height: 100, // 视口的相对大小
        backGroundColor: '#232225', // 背景颜色
        fontSize: '20px'
    }
};
var layout = {
    layoutPages: function() {
        var oPageStyle = document.querySelector('.pages');
        oPageStyle.style.width = layoutSet.pageStyle.width + "%";
        oPageStyle.style.height = layoutSet.pageStyle.height + "vh";
        oPageStyle.style.backgroundColor = layoutSet.pageStyle.backGroundColor;
        oPageStyle.style.fontSize = layoutSet.pageStyle.fontSize;
        return this;
    }
};
layout.layoutPages();
var hotViewTest = {
    isSysTest: true,
    isHotViewTest: false,
    sysTestDesc: function() {
        $('#mainTestDesc').addClass('hide');
        $('#AudiovisualIntegrationPractice').removeClass('hide');
        // 系统测试描述开关 关掉
        this.isSysTest = false;
        // 热身测试描述开关 关掉
        this.isHotViewTest = true;
    },
    startTestDesc: function() {
        // 热身测试 文字描述
        $("#hottestPart1P").removeClass('hide');
        $('#AudiovisualIntegrationPractice').addClass('hide');
        $('#hottestPart1').removeClass('hide');
        instructionTimer1Fun();
    },
    startTest: function() {

    }
};

// 练习阶段数据
var exerciseClickSwitch=false;
var PKeyTest=false;
var isExercise=false;
var exciteTestSwitch=false;
var exerciseTimer=null;
var OOPSTimer=null;
var exerciseCount=0;
var OOPSCount=0;
var exerciseClickCount=0;
var exerciseCountNum1=3,exerciseCountNum2=19;//3,19
var exerciseTestExcite=[1,2,3,4];
var exerciseExcite=[3,4,3,2,1,2,3,4,2,1,4,1,2,4,1,3,2,3,2,3];

// 目标测试 + 干扰测试数据
var targetInterfereSwitch=false;
var targetInterfereClick=false;
var DKeyTest=false;
var targetSwitch=false;
var interfereSwitch=false;
var targetInterfereTimer=null;
var targetInterfereCount=0;
var targetInterfereClickCount=0;
var targetInterfereTotal=0;
var targetInterfereIndex=0;
var targetInterfereCountNum=50; //50
var targetInterfereTotalNum=3; //9
var targetInterfereData=[];
var targetTest=[3,1,3,3,1,2,1,1,3,3,1,4,3,1,3,1,1,3,2,3,3,3,1,3,1,4,1,1,1,3,2,3,3,3,1,1,3,4,1,1,3,1,3,4,3,1,3,3,2,1];
// var targetTest=[3,1,3,3,1];

// var interfereTest=[4,2,4,4,2];
var interfereTest=[4,2,4,4,2,1,2,2,4,4,2,3,4,2,4,2,2,4,1,4,2,2,4,2,4,1,4,4,4,2,3,2,2,2,4,4,2,1,4,4,2,4,2,1,2,4,2,4,3,4];
var targetInterfereTestArr=[];
/*targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
console.log(targetInterfereTestArr);
targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
console.log(targetInterfereTestArr);*/


//恢复视觉测试
var visualRestorationTestSKey=false;
var visualRestorationTestSwitch=false;
var visualRestorationTestTimer=null;
var visualRestorationTestCount=0,visualRestorationTestCountTotal=3;//0   3;
var visualRestorationCount=0,visualRestorationCountTotal=10;//0    10

//恢复视觉测试
var hearingRestorationTestSKey=false;
var hearingRestorationTestSwitch=false;
var hearingRestorationTestTimer=null;
var hearingRestorationTestCount=0,hearingRestorationTestCountTotal=3;//0   3;
var hearingRestorationCount=0,hearingRestorationCountTotal=10;//10





//恢复听觉测试




// 热身阶段函数
$("#timeBtn").click(function () {
    if($("#time1").val() != ""){
        instructionTime.time1=parseInt($("#time1").val());
    }
    if($("#time2").val() != ""){
        instructionTime.time2=parseInt($("#time2").val());
    }
    if($("#time3").val() != ""){
        instructionTime.time3=parseInt($("#time3").val());
    }
    if($("#time4").val() != ""){
        instructionTime.time4=parseInt($("#time4").val());
    }
    if($("#time5").val() != ""){
        instructionTime.time5=parseInt($("#time5").val());
    }
    if($("#time6").val() != ""){
        instructionTime.time6=parseInt($("#time6").val());
    }
    if($("#time7").val() != ""){
        instructionTime.time7=parseInt($("#time7").val());
    }


});
function play_sound(data){
    // thissound=document.getElementById("sound");
    //alert(thissound.src);
    //thissound.Play();
    //document.all.bgs.src=thissound.src;
    var div = document.getElementById('music');
    div.innerHTML = '<embed src="'+data+'" loop="0" autostart="true" hidden="true"></embed>';
}
function instructionTimer1Fun(){
    instructionTimer=setInterval(function () {
        if(viewSoundSwitch){
            $("#hottestPart1H6").removeClass("visbili-hide");
        }else {
            $("#soundhottestPart1H6").removeClass("visbili-hide")
        }

        clearInterval(instructionTimer);
        instructionTimer=null;
        startTestFun();
    },instructionTime.time1)
}
function instructionTimer2Fun(){
    instructionTimer=setInterval(function () {

        if (viewSoundSwitch) {
            $("#hottestPartTipsPart2").removeClass("visbili-hide");

        }else {
            $("#soundhottestPartTipsPart2").removeClass("visbili-hide");
        }
        clearInterval(instructionTimer);
        instructionTimer=null;
        instructionTimer3Fun();
    },instructionTime.time5)
}
function instructionTimer3Fun(){
    instructionTimer=setInterval(function () {
        if(viewSoundSwitch){
            $("#hottestPartTipsPart3").removeClass("visbili-hide");
        }else {
            $("#soundhottestPartTipsPart3").removeClass("visbili-hide");
        }


        clearInterval(instructionTimer);
        instructionTimer=null;
        instructionTimer4Fun();
    },instructionTime.time6)
}
function instructionTimer4Fun(){
    instructionTimer=setInterval(function () {
        if(viewSoundSwitch){
            $("#hottestPartTipsPart4").removeClass("visbili-hide");
        }else {
            $("#soundhottestPartTipsPart4").removeClass("visbili-hide");
        }


        clearInterval(instructionTimer);
        instructionTimer=null;
        SKeyTest=true;
    },instructionTime.time7)
}
function startTestFun(){
    instructionTimer=setInterval(function () {
        if(viewSoundSwitch){
            if(!testSwitch){
                count++;
                $("#hottestPart1Span").removeClass("hide");

            }else {
                $("#starHotTestViewArea").removeClass("hide");
            }
        }else {
            if(!testSwitch){
                count++;
                play_sound("js/1.mp3");

            }else {
                play_sound("js/1.mp3");
                // $("#starHotTestViewArea").removeClass("hide");
            }
        }

        clearInterval(instructionTimer);
        instructionTimer=null;
        startTestHideFun()
    },instructionTime.time2)
}
function startTestShowFun(){
    instructionTimer=setInterval(function () {

        if(viewSoundSwitch){
            if(!testSwitch){
                count++;
                $("#hottestPart1Span").removeClass("hide");

            }else {
                $("#starHotTestViewArea").removeClass("hide");
                test++
            }
        }else {
            if(!testSwitch){
                count++;
                play_sound("js/1.mp3");

            }else {
                play_sound("js/1.mp3");
                test++
            }
        }


        clearInterval(instructionTimer);
        instructionTimer=null;
        startTestHideFun()
    },instructionTime.time4)
}
function startTestHideFun(){
    instructionTimer=setInterval(function () {
        if(viewSoundSwitch){
            if(!testSwitch){
                $("#hottestPart1Span").addClass("hide");
            }else {
                if(clickCount == 0){
                    hotTestViewResult[test-1] ="0";
                }
                clickCount=0;
                $("#starHotTestViewArea").addClass("hide");

            }
        }else {
            if(!testSwitch){
                // $("#hottestPart1Span").addClass("hide");
            }else {
                if(clickCount == 0){
                    hotTestSoundResult[test-1] ="0";
                }
                clickCount = 0;
            }
        }



        clearInterval(instructionTimer);
        instructionTimer=null;
        if(viewSoundSwitch){
            if(!testSwitch){
                if(count < numCount){
                    startTestShowFun();
                }else {
                    testSwitch=true;
                    $("#hottestPartTipsPart1").removeClass("visbili-hide");
                    instructionTimer2Fun()
                }
            }else {
                if(test < testCount){
                    startTestShowFun();
                }else {
                    testSwitch=false;
                    clickSwitch=false;

                    viewSoundSwitchFun();

                }
            }
        }else {
            if(!testSwitch){
                if(count < numCount){
                    startTestShowFun();
                }else {
                    testSwitch=true;
                    $("#soundhottestPartTipsPart1").removeClass("visbili-hide");
                    instructionTimer2Fun()
                }
            }else {
                if(test < testCount){
                    startTestShowFun();
                }else {
                    testSwitch=false;
                    clickSwitch=false;
                    exerciseFun();
                    /*进入练习阶段*/

                }
            }
        }


    },instructionTime.time3)
}
function hintTimerFun() {
    $("#hint").removeClass("hide");
    hintTimer=setInterval(function () {
        $("#hint").addClass("hide");

        clearInterval(hintTimer);
        hintTimer=null;
    },500)
}
function viewSoundSwitchFun() {
    if(viewSoundSwitch){
        $("#viewTest").addClass("hide");
        $("#soundTest").removeClass("hide");
        $("#soundhottestPart1").removeClass("hide");
        viewSoundSwitch=false;
        testSwitch=false;
        count=0;
        test=0;
        instructionTimer1Fun();
    }else {
        alert("23456")
    }

}

function getTimeNow() {
    var now = new Date();
    return now.getTime();
};
(function(){
    // 鼠标长按事件&提示
    document.onmousedown = function() {
        holdDown();
    };
    document.onmouseup = function() {
        holdUp();
    };
})();
// 鼠标按下时触发
function holdDown() {
    timeStart = getTimeNow();// 获取鼠标按下时的时间
    // setInterval会每100毫秒执行一次
    time = setInterval(function () {
        timeEnd = getTimeNow();// 也就是每100毫秒获取一次时间
        // 如果此时检测到的时间与第一次获取的时间差有1000毫秒
        if (timeEnd - timeStart > 1000) {
            clearInterval(time);    // 便不再继续重复此函数 （clearInterval取消周期性执行）
            alert("按下鼠标的时间不要太长"); // 并弹出代码
        };
    }, 100);
};
// 如果按下时间不到1000毫秒便弹起，
function holdUp() {
    clearInterval(time);
};



/*练习函数*/
function exerciseFun() {
    $("#soundTest").addClass("hide");
    $("#exerciseTest").removeClass("hide");
    exerciseTimerFun1()
}
function exciteFun(num) {
    if(!exciteTestSwitch){
        if(num == 1){
            $("#exerciseTestPart1Span").text("1");
            $("#exerciseTestPart1Span").removeClass("hide");
        }else if(num==2){
            $("#exerciseTestPart1Span").text("2");
            $("#exerciseTestPart1Span").removeClass("hide");
        }else if(num==3){
            play_sound("js/1.mp3");
        }else if(num==4){
            play_sound("js/2.mp3");
        }
    }else {
        if(num == 1){
            $("#exerciseTestArea").text("1");
            $("#exerciseTestArea").removeClass("hide");
        }else if(num==2){
            $("#exerciseTestArea").text("2");
            $("#exerciseTestArea").removeClass("hide");
        }else if(num==3){
            play_sound("js/1.mp3");
        }else if(num==4){
            play_sound("js/2.mp3");
        }
    }
}
function exerciseTimerFun1(){
    exerciseTimer=setInterval(function () {
        $("#exerciseTestPart1H6").removeClass("visbili-hide");

        clearInterval(exerciseTimer);
        exerciseTimer=null;
        exerciseTimerFun2()
    },instructionTime.time1)
}
function exerciseTimerFun2(){
    exerciseTimer=setInterval(function () {
        $("#exerciseTestPartTipsPart1").removeClass("visbili-hide");

        clearInterval(exerciseTimer);
        exerciseTimer=null;
        exerciseShowFun()
    },instructionTime.time2)
}
function exerciseTimerFun3(){
    exerciseTimer=setInterval(function () {
        $("#exerciseTestPartTipsPart2").removeClass("visbili-hide");

        clearInterval(exerciseTimer);
        exerciseTimer=null;
        exerciseTimerFun4()
    },instructionTime.time5)
}
function exerciseTimerFun4(){
    exerciseTimer=setInterval(function () {
        $("#exerciseTestPartTipsPart3").removeClass("visbili-hide");

        clearInterval(exerciseTimer);
        exerciseTimer=null;
        exerciseTimerFun5()

    },instructionTime.time6)
}
function exerciseTimerFun5(){
    exerciseTimer=setInterval(function () {
        $("#exerciseTestPartTipsPart4").removeClass("visbili-hide");

        clearInterval(exerciseTimer);
        exerciseTimer=null;
        PKeyTest=true;
    },instructionTime.time7)
}
function exerciseTestFun() {
    $("#exerciseTestPart1").addClass("hide");
    $("#exerciseTestStart").removeClass("hide");
    exerciseCount=0;
    exerciseClickSwitch=true;
    exciteTestSwitch=true;
    exerciseShowFun()
}
function exerciseStartFun() {
    clearInterval(exerciseTimer);
    exerciseTimer=null;
    $("#exerciseTestPart1").removeClass("hide");
    $("#exerciseTestStart").addClass("hide");
    PKeyTest=true;
    OOPSCount=0;
}
function exerciseHideFun(){
    exerciseTimer=setInterval(function () {

        if(!exciteTestSwitch){
            $("#exerciseTestPart1Span").addClass("hide");
        }else {
            $("#exerciseTestArea").addClass("hide");
        }

        clearInterval(exerciseTimer);
        exerciseTimer=null;


        if(!exciteTestSwitch){
            if(exerciseCount<=exerciseCountNum1){
                exerciseShowFun()
            }else {
                exerciseTimerFun3()
            }
        }else {
            if(exerciseCount<=exerciseCountNum2){
                exerciseShowFun()
            }else {
                isExercise=true;
                exerciseShowFun();

            }
        }



    },instructionTime.time3)
}
function exerciseShowFun(){
    exerciseTimer=setInterval(function () {


        if(!exciteTestSwitch){
            exciteFun(exerciseTestExcite[exerciseCount]);
            exerciseCount++
        }else {
            if(isExercise){
                clearInterval(exerciseTimer);
                exerciseTimer=null;
                /*练习阶段结束*/
                targetInterfereFun();
                // alert("练习阶段结束");
                return;
            }
            if(exerciseCount>0){
                if(exerciseClickCount==0){
                    if(exerciseExcite[exerciseCount-1] ==2 || exerciseExcite[exerciseCount-1] ==4){

                    }else {
                        OOPSCount++;
                        if(OOPSCount == 4){
                            exerciseStartFun();
                            return;
                        }
                        OOPSTimerFun();
                    }
                }
            }
            exerciseClickCount=0;
            exciteFun(exerciseExcite[exerciseCount]);
            exerciseCount++
        }
        clearInterval(exerciseTimer);
        exerciseTimer=null;
        exerciseHideFun()

    },instructionTime.time4)
}
function OOPSTimerFun() {
    $("#oopsTips").removeClass("hide");
    OOPSTimer=setInterval(function () {
        $("#oopsTips").addClass("hide");

        clearInterval(OOPSTimer);
        OOPSTimer=null;

    },500)
}


// 目标测试 + 干扰测试函数
function targetInterfereFun(){
    $("#exerciseTest").addClass("hide");
    $("#blendTest").removeClass("hide");
    DKeyTest=true;
}

function targetInterfere(num){
    if(num == 1){
        $("#blendTestAreaSpan").text("1");
        $("#blendTestAreaSpan").removeClass("hide");
    }else if(num==2){
        $("#blendTestAreaSpan").text("2");
        $("#blendTestAreaSpan").removeClass("hide");
    }else if(num == 3){
        play_sound("js/1.mp3");
    }else if(num==4){
        play_sound("js/2.mp3");
    }
}
function targetInterfereHideFun(){
    targetInterfereTimer=setInterval(function () {

        $("#blendTestAreaSpan").addClass("hide");

        clearInterval(targetInterfereTimer);
        targetInterfereTimer=null;


        if(targetInterfereIndex % targetInterfereCountNum != 0){
            targetInterfereShowFun()
        }else {
            targetInterfereTotal++;
            if(targetInterfereTotal>targetInterfereTotalNum){
                targetInterfereSwitch=true;
            }

            if(targetSwitch){
                targetSwitch=false;
                interfereSwitch=true;
            }else {
                targetSwitch=true;
                interfereSwitch=false;
            }

            if(targetSwitch){
                targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
            }
            if(interfereSwitch){
                targetInterfereTestArr.push.apply(targetInterfereTestArr,interfereTest);
            }

            targetInterfereShowFun()


        }




    },instructionTime.time3)
}
function targetInterfereShowFun(){
    targetInterfereTimer=setInterval(function () {

        if(targetInterfereIndex>0){
            if(targetInterfereClickCount == 0){
                if(targetInterfereTestArr[targetInterfereIndex-1] == 2
                    || targetInterfereTestArr[targetInterfereIndex-1] == 4){

                    targetInterfereData[targetInterfereIndex-1] = 1;

                }else {

                    targetInterfereData[targetInterfereIndex-1] = 0;
                }
            }
        }

        if(targetInterfereSwitch){
            console.log(targetInterfereData);
            clearInterval(targetInterfereTimer);
            targetInterfereTimer=null;
            targetInterfereClick=false;
            alert("测验完成");
            visualRestorationTestFun();
            return;
        }
        targetInterfereIndex++;
        targetInterfereClickCount=0;

        targetInterfere(targetInterfereTestArr[targetInterfereIndex-1]);


        clearInterval(targetInterfereTimer);
        targetInterfereTimer=null;



        targetInterfereHideFun()

    },instructionTime.time4)
}



//恢复视觉测试
function visualRestorationTestFun(){
    $("#blendTest").addClass("hide");
    $("#recoveryTest").removeClass("hide");
    $("#recoveryViewTest").removeClass("hide");
    $("#recoveryViewTestPart1").removeClass("hide");
    visualRestorationTestTimerFun1();
}
function visualRestorationTestTimerFun1(){
    visualRestorationTestTimer=setInterval(function () {

        $("#recoveryViewTestPart1H6").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPart1H6.m4a");
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;
        convert=instructionTime.time4;
        instructionTime.time4=instructionTime.time8;
        visualRestorationTestShowFun()

    },instructionTime.time1)
}
function visualRestorationTestTimerFun2(){
    visualRestorationTestTimer=setInterval(function () {

        $("#recoveryViewTestPartTipsPart1").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart1.m4a");
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;

        visualRestorationTestTimerFun3()
    },instructionTime.time2)
}
function visualRestorationTestTimerFun3(){
    visualRestorationTestTimer=setInterval(function () {

        $("#recoveryViewTestPartTipsPart2").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart2.m4a");
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;
        visualRestorationTestTimerFun4()
    },instructionTime.time9)
}
function visualRestorationTestTimerFun4(){
    visualRestorationTestTimer=setInterval(function () {

        $("#recoveryViewTestPartTipsPart3").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart3.m4a");
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;
        visualRestorationTestTimerFun5();
    },instructionTime.time11)
}
function visualRestorationTestTimerFun5(){
    visualRestorationTestTimer=setInterval(function () {

        $("#recoveryViewTestPartTipsPart4").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart4.m4a");
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;

        visualRestorationTestSKey=true;

    },instructionTime.time10)
}

function visualRestorationTestShowFun(){
    visualRestorationTestTimer=setInterval(function () {
        if(!visualRestorationTestSwitch){
            instructionTime.time4=convert;
        // 测试
            if(visualRestorationTestCount == visualRestorationTestCountTotal){
                //测试结束

                clearInterval(visualRestorationTestTimer);
                visualRestorationTestTimer=null;

                visualRestorationTestSwitch=true;
                visualRestorationTestTimerFun2();
                return;
            }
            visualRestorationTestCount++;

            $("#recoveryViewTestPart1Span").removeClass("hide")
        }else {
        //正式
            if(visualRestorationCount == visualRestorationCountTotal){

                clearInterval(visualRestorationTestTimer);
                visualRestorationTestTimer=null;
                // alert("恢复视觉结束");
                hearingRestorationTestFun();
                return;
            }

            visualRestorationCount++;

            $("#recoveryViewTestAreaSpan").removeClass("hide");

        }
        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;

        visualRestorationTestHideFun();

        if(!visualRestorationTestSwitch){
            // 测试
        }else {
            //正式
        }

    },instructionTime.time4)
}
function visualRestorationTestHideFun(){
    visualRestorationTestTimer=setInterval(function () {
        if(!visualRestorationTestSwitch){
            // 测试
            $("#recoveryViewTestPart1Span").addClass("hide");
        }else {
            //正式
            $("#recoveryViewTestAreaSpan").addClass("hide");
        }


        clearInterval(visualRestorationTestTimer);
        visualRestorationTestTimer=null;

        visualRestorationTestShowFun();

        if(!visualRestorationTestSwitch){
            // 测试
        }else {
            //正式
        }

    },instructionTime.time3)
}






//恢复听觉测试
function hearingRestorationTestFun(){
    $("#recoveryViewTest").addClass("hide");
    $("#recoverySoundTest").removeClass("hide");
    $("#recoverysoundhottestPart1").removeClass("hide");
    hearingRestorationTestTimerFun1()
}
function hearingRestorationTestTimerFun1(){
    hearingRestorationTestTimer=setInterval(function () {
        $("#recoverysoundhottestPart1H6").removeClass("visbili-hide");
        play_sound("js/recoverysoundhottestPartTipsPart2.m4a");
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;
        convert=instructionTime.time4;
        instructionTime.time4=instructionTime.time8;
        hearingRestorationTestShowFun()
    },instructionTime.time1)
}
function hearingRestorationTestTimerFun2(){
    hearingRestorationTestTimer=setInterval(function () {

        $("#recoverysoundhottestPartTipsPart1").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart1.m4a");
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;

        hearingRestorationTestTimerFun3()
    },instructionTime.time2)
}
function hearingRestorationTestTimerFun3(){
    hearingRestorationTestTimer=setInterval(function () {

        $("#recoverysoundhottestPartTipsPart2").removeClass("visbili-hide");
        play_sound("js/recoverysoundhottestPart1H6.m4a");
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;
        hearingRestorationTestTimerFun4()
    },instructionTime.time9)
}
function hearingRestorationTestTimerFun4(){
    hearingRestorationTestTimer=setInterval(function () {

        $("#recoverysoundhottestPartTipsPart3").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart3.m4a");
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;
        hearingRestorationTestTimerFun5();
    },instructionTime.time11)
}
function hearingRestorationTestTimerFun5(){
    hearingRestorationTestTimer=setInterval(function () {

        $("#recoverysoundhottestPartTipsPart4").removeClass("visbili-hide");
        play_sound("js/recoveryViewTestPartTipsPart4.m4a");
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;

        hearingRestorationTestSKey=true;

    },instructionTime.time10)
}





function hearingRestorationTestShowFun(){
    hearingRestorationTestTimer=setInterval(function () {
        if(!hearingRestorationTestSwitch){
            instructionTime.time4=convert;
            // 测试 hearingRestorationTestCount=0,hearingRestorationTestCountTotal=3
            if(hearingRestorationTestCount == hearingRestorationTestCountTotal){
                //测试结束

                clearInterval(hearingRestorationTestTimer);
                hearingRestorationTestTimer=null;

                hearingRestorationTestSwitch=true;
                hearingRestorationTestTimerFun2();
                return;
            }
            hearingRestorationTestCount++;
            play_sound("js/1.mp3");
            // $("#recoverysoundhottestPart1Span").removeClass("hide")
        }else {
            //正式 hearingRestorationCount=0,hearingRestorationCountTotal=10;//10
            if(hearingRestorationCount == hearingRestorationCountTotal){

                clearInterval(hearingRestorationTestTimer);
                hearingRestorationTestTimer=null;
                // alert("恢复听觉结束");
                // hearingRestorationTestFun();
                $("#recoveryTest").addClass("hide");
                $("#completeAllTest").removeClass("hide");
                return;
            }

            hearingRestorationCount++;
            play_sound("js/1.mp3");
            // $("#recoverystarHotTestSoundArea").removeClass("hide");

        }
        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;

        hearingRestorationTestHideFun();

        if(!hearingRestorationTestSwitch){
            // 测试
        }else {
            //正式
        }

    },instructionTime.time4)
}
function hearingRestorationTestHideFun(){
    hearingRestorationTestTimer=setInterval(function () {
        if(!hearingRestorationTestSwitch){
            // 测试
            $("#recoverysoundhottestPart1Span").addClass("hide");
        }else {
            //正式
            $("#recoverystarHotTestSoundArea").addClass("hide");
        }


        clearInterval(hearingRestorationTestTimer);
        hearingRestorationTestTimer=null;

        hearingRestorationTestShowFun();

        if(!hearingRestorationTestSwitch){
            // 测试
        }else {
            //正式
        }

    },instructionTime.time3)
}

// 点击事件
$("#pages").click(function (event) {
    // console.log(event.Button);
    // 热身阶段点击事件
    if(clickSwitch){
        clickCount++;
        if(viewSoundSwitch){
            if(clickCount == 1){
                hotTestViewResult[test-1] ="1";
            }else {
                hotTestViewResult[test-1] ="9";
                hintTimerFun()
            }
            // console.log(hotTestViewResult);
        }else {
            if(clickCount == 1){
                hotTestSoundResult[test-1] ="1";
            }else {
                hotTestSoundResult[test-1] ="9";
                hintTimerFun()
            }
            // console.log(hotTestSoundResult);
        }

    }

    // 练习阶段点击事件

    if(exerciseClickSwitch){
        exerciseClickCount++;
        if(exerciseClickCount != 1){
            OOPSCount++;
            if(OOPSCount == 4){
                exerciseStartFun();
                return;
            }
            OOPSTimerFun();
        }else {
            if(exerciseExcite[exerciseCount-1] ==2 || exerciseExcite[exerciseCount-1] ==4){
                OOPSCount++;
                if(OOPSCount == 4){
                    exerciseStartFun();
                    return;
                }
                OOPSTimerFun();
            }
        }
    }

    // 目标测试 + 干扰测试点击事件
    if(targetInterfereClick){
        targetInterfereClickCount++;
        if(targetInterfereClickCount == 1){
            //结束时间
            if(targetInterfereTestArr[targetInterfereIndex-1] == 1
                || targetInterfereTestArr[targetInterfereIndex-1] == 3){

                targetInterfereData[targetInterfereIndex-1] = 1;

            }else {

                targetInterfereData[targetInterfereIndex-1] = 0;
            }
        }else {
            targetInterfereData[targetInterfereIndex-1] = 9;
        }
    }




});
$("#pages").mousedown(function(e){

    // console.log(e.button)

    if(clickSwitch){
        if(viewSoundSwitch){
            if(e.button == 2){
                exerciseClickCount=3;
                hotTestViewResult[test-1] ="9";
            }
        }else {
            if(e.button == 2){
                exerciseClickCount=3;
                hotTestSoundResult[test-1] ="9";
            }
        }

    }
});
document.oncontextmenu = function(){
    return false;
};

// 监听键盘按键
document.onkeydown = function (ev) {
    var pressKeyCpde = parseInt(ev.keyCode);
    var oEvent = window.event;
    if (oEvent.keyCode == 90 && oEvent.ctrlKey) {
        BtestOnoff = false;
    };
    // console.log(DKeyTest)
    // console.log(pressKeyCpde);
    switch (pressKeyCpde) {
        case 87:
            // W按键
            BtestOnoff = true;

            if (hotViewTest.isSysTest) {
                // 第一次 w 按键
                hotViewTest.sysTestDesc();
            } else {
                hotViewTest.isHotViewTest && hotViewTest.startTestDesc();

                hotViewTest.isHotViewTest = false;

            };
            break;
        case 83:
            //S 按键
            if(SKeyTest){
                SKeyTest=false;
                if(viewSoundSwitch){
                    clickSwitch=true;
                    $("#hottestPart1").addClass("hide");
                    $("#starHotTestView").removeClass("hide");
                    startTestShowFun()
                }else {
                    clickSwitch=true;
                    $("#soundhottestPart1").addClass("hide");
                    $("#starHotTestSound").removeClass("hide");
                    startTestShowFun()
                }
            }
            if(visualRestorationTestSKey){
                visualRestorationTestSKey=false;
                $("#recoveryViewTestPart1").addClass("hide");
                $("#recoveryViewTestArea").removeClass("hide");

                visualRestorationTestShowFun();
            }

            if(hearingRestorationTestSKey){
                hearingRestorationTestSKey=false;
                $("#recoverysoundhottestPart1").addClass("hide");
                $("#recoverystarHotTestSound").removeClass("hide");

                hearingRestorationTestShowFun();
            }

            break;
        case 80:
            if(PKeyTest){
                PKeyTest=false;
                exerciseTestFun();
            }
            break;
        case 68:
            // 混合测试
            if(DKeyTest){
                DKeyTest=false;
                targetSwitch=true;
                targetInterfereClick=true;
                $("#blendTestDesc").addClass("hide");
                $("#blendTestArea").removeClass("hide");
                targetInterfereTestArr.push.apply(targetInterfereTestArr,targetTest);
                targetInterfereShowFun();

            }
            break;
    }
};
