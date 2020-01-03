/**
 * @file js文件主入口
 * @author datura_lj@163.com
 * @createDate 2018-12-15 09:40:11
 */


// 鼠标长按事件
var timeStart, timeEnd, time; // 申明全局变量
// 获取此刻时间
function getTimeNow() {
    var now = new Date();
    return now.getTime();
};
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
/**
 * 语音播放 对象
 */
var soundSpeak = {
    speak1: function() {
        // 语音播放”1“
        document.querySelector('#speak1').play();
    }
};

/*前台调用 选择器*/
(function() {
    window.$ = function () {
        return new Base();
    };
    
    function Base() {//创建一个对象 也是构造函数
        //创建一个数组,来保存获取的节点(ID)和节点数组(name,tagName等)
        this.elements = [];
    };
    
    /*获取元素节点*/
    
    //获取ID节点
    Base.prototype.getId = function (id) {
        /*push() 方法可向数组的末尾添加一个或多个元素,并返回新的长度。*/
        this.elements.push(document.getElementById(id));
        return this;
    };
    
    //获取tagName
    Base.prototype.getTagName = function (tag) {
        //tagName是一个集合 所有要在遍历
        var tag = document.getElementsByTagName(tag);
        for (var i = 0; i < tag.length; i++) {
            this.elements.push(tag[i]);
        }
        return this;
    };
    
    //获取Name
    Base.prototype.getName = function (nmae) {
        //tagName是一个集合 所有要在遍历
        var names = document.getElementsByName(nmae);
        for (var i = 0; i < names.length; i++) {
            this.elements.push(names[i]);
        }
        return this;
    };
    
    /*添加方法*/
    
    //获取CLASS节点方法(所有的class节点,或某个区域的节点)
    Base.prototype.getClass = function (className, idName) {//添加获取ID某个区域
        var node = null;//定义一个节点对象
        if (arguments.length == 2) {
            node = document.getElementById(idName);
        } else {
            node = document;
        }
        var all = node.getElementsByTagName('*');
        for (var i = 0; i < all.length; i++) {
            //判断 如果你传过来的class==class
            if (all[i].className == className) {
                //那么久返回摸传过来的所有className
                this.elements.push(all[i]);
            }
        }
        return this;
    };
    
    //获取一个元素节点(只需获取一个)
    Base.prototype.getElement = function (number) {
        //获取某一个元素节点 参数为number数字
        var element = this.elements[number];//得到元素的对象
        this.elements = [];//再清空元素
        this.elements[0] = element;//得到一个元素
        return this;//返回
    };
    
    //添上(设置)CSS方法 
    Base.prototype.css = function (attr, value) {//两个参数 属性和值
        for (var i = 0; i < this.elements.length; i++) {
            //获取样式行内和外链都可以获取
            if (arguments.length == 1) {
                if (typeof window.getComputedStyle != 'undefined') {//W3C标准
                    return window.getComputedStyle(this.elements[i], null)[attr];
                    //调用属性
                } else if (typeof this.elements[i].currentStyle != 'undefined') {//IE浏览器
                    return this.elements[i].style[attr];
                }
            }
            this.elements[i].style[attr] = value;
        }
        return this
    };
    
    //添加CLASS方法
    Base.prototype.addClass = function (className) {
        for (var i = 0; i < this.elements.length; i++) {//遍历
            //判断不重复添加样式 用正则表示判断添加在第一个还是最后一个
            if (!this.elements[i].className.match(new RegExp('(\\s|^)' + className + '(\\s|^)'))) {
                this.elements[i].className += ' ' + className;//添加做个cass样式
            }
        }
        return this;//返回再次调用 否则只能调用一次
    };
    
    //移除CLASS方法
    Base.prototype.removeClass = function (classsName) {
        for (var i = 0; i < this.elements.length; i++) {//遍历 如果有多个
            //判断该样式是否添加重复
            if (this.elements[i].className.match(new RegExp('(\\s|^)' + classsName + '(\\s|$)'))) {
                this.elements[i].className = this.elements[i].className.replace(new RegExp('(\\s|^)' + classsName + '(\\s|$)'), '');//+=''+累加多个样式之间 用空格隔开
            }
        }
        return this;//返回实现连缀
    };
    
    //添加(设置)innerHTML方法
    Base.prototype.html = function (str) {
        for (var i = 0; i < this.elements.length; i++) {
            if (arguments.length == 0) {//获取innerHTML的值
                return this.elements[i].innerHTML;
            }
            this.elements[i].innerHTML = str;
        }
        return this;
    };
    
    //触发点击事件
    Base.prototype.click = function (fn) {
        for (var i = 0; i < this.elements.length; i++) {
            this.elements[i].onclick = fn;
        }
        return this;
    };
})();

/**
 * @页面布局 配置设置参数
 */

var layoutSet = {
    pageStyle: {
        width: 100, // 宽度 百分比
        height: 100, // 视口的相对大小
        backGroundColor: '#232225', // 背景颜色
        fontSize: '20px' 

    }
};

/**
 * 练习测试刺激 的数据 20次的视听混合
 * 听 听 听 看 看   看 听 听 看 看   听 看 看  听 看    听 看 听 看 听
 * 1  2  1 2  1    2 1  2  2 1    2  1  2  2  1    1  2  1  2  1
 */
var exerciseTestingData = '121ba b12ba 2ab2a 1b1b1';
var exerciseTestingDataArr = ['121ba', 'b12ba', '2ab2a', '1b1b1'];

/**
 * 目标测试刺激 的数据 50次的视听混合 主要是1
 * 听视听听视  视视视听听   视听听视听      视视听视听      听听视听视
 * 1 1 1 1 1  2 1 1 1 1  1 2 1 1 1     1 1 1 2 1     1 1 1 1 1
 * 听视视视听       视听听听视      视听听视视     听视听听听      视听视视视
 * 2 1 1 1 1      2 1 1 1 1     1 1 2 1 1     1 1 1 2 1     1 1 1 2 1
 */
var targetTestingData = '1a11a baa11 a21a1 aa1b1 11a1a 2aaa1 b111a a12aa 1a121 a1aba';
var targetTestingDataArr = ['1a11a', 'baa11', 'a21a1', 'aa1b1', '11a1a', '2aaa1', 'b111a', 'a12aa', '1a121', 'a1aba'];

/**
 * {干扰}测试刺激 的数据 50次的视听混合 主要是2
 * 听视听听视  视视视听听  视听听视听  视视听视听  视视听视听
 * 2 2 2 2 2  1 2 2 2 2  2 1 2 2 2     2 2 2 1 2     2 2 2 2 2 
 * 视听听听视  听视视视听   听视视听听  视听视视视  听视听听听
 * 1 2 2 2 2  1 2 2 2 2   2 2 1 2 2     2 2 2 1 2     2 2 2 1 2
 */
var interfereTestingData = '2b22b abb22 b12b2 bb2a2 bb2b2 a222b 1bbb2 2ba22 b2bab 2b212';
var interfereTestingDataArr = ['2b22b', 'abb22', 'b12b2', 'bb2a2', 'bb2b2', 'a222b', '1bbb2', '2ba22', 'b2bab', '2b212'];

/**
 * 恢复测试
 */

 var recoveryTestingData = 'aaaaa aaaaa 11111 11111';
 var recoveryTestingDataArr = ['aaaaa', 'aaaaa', '11111', '11111'];


/**
 * 混合测试 目标 => 干扰 => 目标 。。。。 *
 */

var blendTestingData = targetTestingData + interfereTestingData + targetTestingData + interfereTestingData + targetTestingData + interfereTestingData + targetTestingData + interfereTestingData + targetTestingData + interfereTestingData;
var blendTestingDataArr = [].concat(targetTestingDataArr, interfereTestingDataArr, targetTestingDataArr, interfereTestingDataArr, targetTestingDataArr, interfereTestingDataArr, targetTestingDataArr, interfereTestingDataArr, targetTestingDataArr, interfereTestingDataArr);
blendTestingDataArr = ['aaaaa'];
/**
 * 
 */

 var BtestOnoff = true;
 var BisRecoveryTest = false;

;(function () {

    window.onload = function () {
        /**
         *  页面元素 布局设置
         */
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
        layout.layoutPages()
        // Dom元素获取
        // 开关变量
        var bMainTestDesc = true;
        var bSatrtHotTest = false;
        var bStartHotTest = false;
        var bHotTestView = true; // 视觉热身训练开关
        // var hotTestViewCountDemo = 0;
        var hotTestViewCount = 0;
        var hotTestViewTimer = null;
        var hotTestViewResult = []; // 记录 热身测试视觉的结果;
        var hotTestSoundResult = []; // 记录 热身测试的测试结果

        var canClickHotTestView = 0;
        /**
         * 测试练习
         */
        var exerciseTestDataStrPart1 = "ab12";
        var soudTipsSpeak1 = new SpeechSynthesisUtterance("1");
        var soudTipsSpeak2 = new SpeechSynthesisUtterance("2");
        var soudTipsSpeakOops = new SpeechSynthesisUtterance("oops");
        var bExerciseTest = false; // 练习测试 正式开始的开关 在demo演示后开始
        var exerciseTestOopsCount = 0; // 练习测试oops错误统计

        var viewTestPart1Sound = new SpeechSynthesisUtterance("你会在屏幕上看到闪的数字，就像这样");
        var viewTestPart2Sound = new SpeechSynthesisUtterance("数字始终是1");
        var viewTestPart3Sound = new SpeechSynthesisUtterance("当你看到数字时，请点击鼠标左键一次");
        var viewTestPart4Sound = new SpeechSynthesisUtterance("请尽量快速并准确地点击鼠标");
        var viewTestPart5Sound = new SpeechSynthesisUtterance("准备好后，按下S键开始");
        var soudTipsPart1 = new SpeechSynthesisUtterance("现在你会听到一个数字，就像这样");
        
        ;(function(){
            // 开始热身视觉测试
            document.ondblclick = function () {
                alert('只要点击一下鼠标')
            };
            // 鼠标长按事件&提示
            document.onmousedown = function() {
                holdDown();
            };
            document.onmouseup = function() {
                holdUp();
            };
        })();
        
        // 监听键盘按键
        document.onkeydown = function (ev) {
            var pressKeyCpde = parseInt(ev.keyCode);
            var oEvent = window.event; 
            if (oEvent.keyCode == 90 && oEvent.ctrlKey) {
                BtestOnoff = false;
            };
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
                    if (!recoveryTest.isRecoveryTest) {

                        BtestOnoff = true;
                        hotViewTest.startTest();
                   } else {
                       // 开始恢复测试
                       ecoveryTest.isRecoveryTest = false;
                       recoveryTest.startViewTest();
                   };
                    
                    break;
                case 80:
                    BtestOnoff = true;
                    // console.log('按下P键');
                    if (bExerciseTest) {
                        exerciseTest.startTest();
                    }
                    break;
                case 68:
                    // 混合测试
                    BtestOnoff = true;
                    if (!blendTest.BcanStartTest) return;
                    blendTest.init();
                    break;
            }
        };

        var hotTestViewCb = function() {
            var clikHotTestView = new Date().getTime();
            hotTestViewResult[hotTestViewCount].time = clikHotTestView - canClickHotTestView;
            hotTestViewResult[hotTestViewCount].count += 1;
            hotTestViewResult[hotTestViewCount].status = 1;
        };
        
        /**
         * 视觉测试 对象
         */

        var hotViewTest = {
            isSysTest: true,
            isHotViewTest: false,
            init: function() {

            },
            sysTestDesc: function() {
                $().getId('mainTestDesc').addClass('hide');
                $().getId('AudiovisualIntegrationPractice').removeClass('hide');
                // 系统测试描述开关 关掉
                this.isSysTest = false;
                // 热身测试描述开关 关掉
                this.isHotViewTest = true;
            },
            startTestDesc: function() {
                // 热身测试 文字描述
                $().getId("hottestPart1P").removeClass('hide');
                $().getId('AudiovisualIntegrationPractice').addClass('hide');
                $().getId('hottestPart1').removeClass('hide');
                // 你会在屏幕上看到闪的数字，就像这样
                showPart.part1('hottestPart1H6');
                showPart.part2('hottestPart1Span', 'hottestPartTipsPart1',  'hottestPartTipsPart2',  'hottestPartTipsPart3',  'hottestPartTipsPart4', false);
            },
            startTest: function() {
                if (bStartHotTest) {
                   
                    if (bHotTestView) {
                        // 视觉测试
                        $().getId('hottestPart1').addClass('hide');
                        $().getId('starHotTestView').removeClass('hide');
                        showPart.part3('starHotTestViewArea', function(){}, true, hotTestViewResult), false;
                        
                    } else {
                        // 听觉测试
                        $().getId('soundhottestPart1').addClass('hide');
                        $().getId('starHotTestSound').removeClass('hide');
                        showPart.part3('starHotTestSoundArea',function(){
                            window.speechSynthesis.speak(soudTipsSpeak1);
                        }, false, hotTestSoundResult, true);
                    }
                }
            }
        };
        
        /**
         * 听觉测试
         */
        var hotSoundTest = function() {
            // 听觉测试 
            // 初始化提示语
            // objSoundMsg();
           
            // 视觉测试结束后 隐藏视觉测试区域
            $().getId('viewTest').addClass('hide');
            // 听觉测试开始后 显示听觉测试区域
            $().getId('soundhottestPart1').removeClass('hide');
            $().getId('soundTest').removeClass('hide');
            // 你会在听到的数字，就像这样
            showPart.part1('soundhottestPart1H6', true);
            // window.speechSynthesis.speak(soudTipsPart1);
            showPart.part2('soundhottestPart1Span', 'soundhottestPartTipsPart1',  'soundhottestPartTipsPart2',  'soundhottestPartTipsPart3',  'soundhottestPartTipsPart4', true);
            //
           

        };

        var showHotTimeshow = 1000; // 热身测试 隐藏1的时间 单位毫秒
        var showHotTimehide = 500;
        /**
         * showPart 显示
         * @params {TestResult}  测试结果的数组 Array
         */
        var showPart = {
            part1: function(elId, isSoundTest) {
                setTimeout(function () {
                    // 你会在屏幕上看到(听到)闪的数字，就像这样
                    if (BisRecoveryTest) {
                        if (isSoundTest) {
                            // 听
                            window.speechSynthesis.speak(soudTipsPart1);
                        } else {
                            window.speechSynthesis.speak(viewTestPart1Sound);
                        }
                    }
                    $().getId(elId).removeClass('visbili-hide');
                }, 1000);
            },
            part2: function(elIdShow1, elIdPart1, elIdPart2, elIdPart3, elIdPart4, BisSoundTest) {
                setTimeout(function () {
                    // 1 elIdShow1
                    $().getId(elIdShow1).removeClass('hide');
                    // 循环 显示隐藏1
                    function showAndHide(n){
                        if (BisSoundTest) {
                            if ( n == 4 ) {
                                // 测试演示3次，清除定时器后还原次数，便于听觉使用
                                // 测试演示3次，清除定时器后还原次数，便于听觉使用
                                // hotTestViewCountDemo = 0;
                                setTimeout(function(){
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart2Sound);
                                    }
                                    $().getId(elIdPart1).removeClass('visbili-hide');
                                }, 1000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart3Sound);
                                    }
                                    $().getId(elIdPart2).removeClass('visbili-hide');
                                }, 2000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart4Sound);
                                    }
                                    $().getId(elIdPart3).removeClass('visbili-hide');
                                }, 4000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart5Sound);
                                    }
                                    $().getId(elIdPart4).removeClass('visbili-hide');
                                    // 打开热身测试的开关
                                    bStartHotTest = true;
                                }, 5000);
                            } else { 
                                $().getId(elIdShow1).addClass('hide');
                                    setTimeout(function(){
                                        n ++;
                                        window.speechSynthesis.speak(soudTipsSpeak1);
                                        showAndHide(n); // 递归调用
                                    } , 1500);
                            }
                        } else {
                            if ( n == 3 ) {
                                // 测试演示3次，清除定时器后还原次数，便于听觉使用
                                // 测试演示3次，清除定时器后还原次数，便于听觉使用
                                // hotTestViewCountDemo = 0;
                                setTimeout(function(){
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart2Sound);
                                    }
                                    $().getId(elIdPart1).removeClass('visbili-hide');
                                }, 1000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart3Sound);
                                    }
                                    $().getId(elIdPart2).removeClass('visbili-hide');
                                }, 2000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart4Sound);
                                    }
                                    $().getId(elIdPart3).removeClass('visbili-hide');
                                }, 4000);
                                setTimeout(function () {
                                    if (BisRecoveryTest) {
                                        window.speechSynthesis.speak(viewTestPart5Sound);
                                    }
                                    $().getId(elIdPart4).removeClass('visbili-hide');
                                    // 打开热身测试的开关
                                    bStartHotTest = true;
                                }, 5000);
                            } else {
                            // 视觉测试
                            setTimeout(function(){
                                $().getId(elIdShow1).addClass('hide');
                                setTimeout(function(){
                                    n ++;
                                    $().getId(elIdShow1).removeClass('hide');
                                    showAndHide(n); // 递归调用
                                } ,showHotTimehide)
                            }, showHotTimeshow);
                            }
                        }
                    }
                    showAndHide(1);
                }, 2000)
            },
            part3: function(elIdShowArea ,cb, isSound, TestResult, BisSoundTest) {
                setTimeout(function () {
                    !BisSoundTest && $().getId(elIdShowArea).removeClass('hide');
                    hotTestViewTimer = setInterval(function () {
                        !BisSoundTest && $().getId(elIdShowArea).removeClass('hide');
                        cb && cb();
                        canClickHotTestView = new Date().getTime();
                        TestResult[hotTestViewCount] = {
                            id: hotTestViewCount,
                            time: -9999,
                            count: 0,
                            status: 0
                        }
                        // 视觉显示1 用户的点击反应
                        document.addEventListener('click', hotTestViewCb,false);
                        // 视觉显示 用户按右键
                        // document.addEventListener('oncontextmenu', hotTestRightClickViewCb,false);
                        document.oncontextmenu = function(event) {
                            event.returnValue = false;
                            // console.log('鼠标右键点击');
                            var clikHotTestView = new Date().getTime();
                            TestResult[hotTestViewCount].time = clikHotTestView - canClickHotTestView;
                            TestResult[hotTestViewCount].count += 1;
                            TestResult[hotTestViewCount].status = 9;
                        };
                        setTimeout(function () {
                            document.removeEventListener('click', hotTestViewCb,false);
                            // document.removeEventListener('oncontextmenu', hotTestRightClickViewCb,false);
                            document.oncontextmenu = function(event) {
                                event.returnValue = false;
                            }
                            hotTestViewCount++;
                            !BisSoundTest && $().getId(elIdShowArea).addClass('hide');
                            if (hotTestViewCount === 10) {
                                clearInterval(hotTestViewTimer)
                                hotTestViewCount = 0;
                                bHotTestView = false;
                                // 10次听觉测试后隐藏
                                $().getId('soundTest').addClass('hide');
                                // 10次测试结束后 延迟3s后 执行回调 如果是听觉结束 那么久进行热身测试 否则进行 听觉测试
                                if (BisSoundTest) {
                                    if (!BisRecoveryTest) {
                                        exerciseTest.init()
                                    } else {
                                       // completeAllTest();
                                    }
                                    
                                } else {
                                    setTimeout(function() { 
                                        $().getId("hottestPart1P").addClass('hide');
                                        isSound && hotSoundTest();
                                    }, 3000);
                                };
                            }
                        }, 1000);
                    }, 1500);
                }, 1000);
            }
        };

        /**
         * 测试练习
         */
        var startExerciseTestTimes = 0;
        var clikExerciseTestTimes = 0;
        var isContinue = true;
        var index = 0;
        var exerciseTest = {
            exerciseResultData: [],
            init: function() {
                this.showDemo();
            },
            endTest: function () {
                $().getId('exerciseTest').addClass('hide');
            },
            showDemo: function() {
                var self = this;
                $().getId('exerciseTest').removeClass('hide');
                // 现在你会看到或听到数字(1)或(2),数字将会以不同的方式混合出现.就像这样:
                setTimeout(function() {
                    $().getId('exerciseTestPart1H6').removeClass('visbili-hide');
                    $().getId('exerciseTestPart1Span').removeClass('hide');
                    for (var i=0;i<exerciseTestDataStrPart1.length;i++) {
                        switch(exerciseTestDataStrPart1[i]) {
                            case 'a':
                                // $().getId('exerciseTestPart1Span').addClass('hide');
                                setTimeout(function() {
                                    $().getId('exerciseTestPart1Span').removeClass('hide');
                                    $().getId('exerciseTestPart1Span').html('1');
                                    if (i == exerciseTestDataStrPart1.length-1) {
                                        // 读取完最后一个单词
                                        self.showDescTips();
                                    }
                                }, 1000);
                            break;
                            case 'b':
                                setTimeout(function(){
                                    $().getId('exerciseTestPart1Span').addClass('hide');
                                    setTimeout(function() {
                                        $().getId('exerciseTestPart1Span').removeClass('hide');
                                        $().getId('exerciseTestPart1Span').html('2');
                                        if (i == exerciseTestDataStrPart1.length-1) {
                                            self.showDescTips();
                                        }
                                    }, 2000);
                                }, 1500);
                            break;
                            case '1':
                               
                                setTimeout(function() {
                                    $().getId('exerciseTestPart1Span').addClass('hide');
                                    $().getId('exerciseTestPart1Span').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak1);
                                    if (i == exerciseTestDataStrPart1.length-1) {
                                        self.showDescTips();
                                    }
                                }, 4500);
                            break;
                            case '2':
                                // $().getId('exerciseTestPart1Span').addClass('hide');
                                setTimeout(function() {
                                    $().getId('exerciseTestPart1Span').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak2);
                                    setTimeout(function() {
                                        if (i == exerciseTestDataStrPart1.length) {
                                            console.log(2)
                                            self.showDescTips();
                                        }
                                    },200);
                                }, 5500);
                            break;
                            
                        }
                        
                    }
                }, 1000);
            },
            showDescTips: function() {
                setTimeout(function(){
                    $().getId('exerciseTestPartTipsPart2').removeClass('visbili-hide');
                    setTimeout(function() {
                        $().getId('exerciseTestPartTipsPart3').removeClass('visbili-hide');
                        setTimeout(function() {
                            $().getId('exerciseTestPartTipsPart4').removeClass('visbili-hide');
                            bExerciseTest = true;
                        },1000);
                    },1000);
                }, 15);
            },
            startTest: function() {
                var self = this;
                self.exerciseResultData = [];
                // 开始测试demo演示隐藏
                $().getId('exerciseTestPart1').addClass('hide');
                $().getId('exerciseTestStart').removeClass('hide');
                $().getId('exerciseTestArea').removeClass('hide');
               
                var timesInter =  1000;
                for (var i=0; i<exerciseTestingDataArr.length; i++) {
                    for (var j=0; j<exerciseTestingDataArr[i].length; j++) {
                        timesInter += 1000;   
                        (function(i, j) {
                            setTimeout(function() {
                                index += 1;     
                                if (!isContinue) return;
                                self.intermissionTime();
                                self.exerciseResultData[index] = {
                                    id: index,
                                    time: -9999,
                                    count: 0,
                                    status: 0
                                }
                                var SneedShowData = exerciseTestingDataArr[i][j];
                                if (SneedShowData === 'a') {
                                    // 用户的点击反应
                                    document.addEventListener('click', self.clickRecordCb, false);
                                    $().getId('exerciseTestArea').removeClass('hide').html('1');
                                    startExerciseTestTimes = new Date().getTime();
                                    exerciseTestOopsCount += 1;
                                } else if (SneedShowData === 'b') {
                                    $().getId('exerciseTestArea').removeClass('hide').html('2');
                                    startExerciseTestTimes = new Date().getTime();
                                    exerciseTestOopsCount += 1;
                                } else if (SneedShowData === '1') { 
                                    $().getId('exerciseTestArea').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak1);
                                    startExerciseTestTimes = new Date().getTime();
                                    exerciseTestOopsCount += 1;
                                } else if (SneedShowData === '2') {
                                    $().getId('exerciseTestArea').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak2);
                                    startExerciseTestTimes = new Date().getTime();
                                    exerciseTestOopsCount += 1;
                                };
                                console.log(self.exerciseResultData);
                                // setTimeout(function() {
                                //     document.removeEventListener('click', self.clickRecordCb, false)
                                //     if (isClick) return;
                                //     isClick = false;
                                //     console.log('1234321');
                                //     window.speechSynthesis.speak(soudTipsSpeakOops);
                                //     $().getId('oopsTips').removeClass('hide');
                                //     setTimeout(function() {
                                //         $().getId('oopsTips').addClass('hide');
                                //     }, 1000);
                                //     if (exerciseTestOopsCount == 4) {
                                //         isContinue = false;
                                //         // 输出3次oops alert('不要继续了');
                                //         $().getId('exerciseTestPart1').removeClass('hide');
                                //         $().getId('exerciseTestStart').addClass('hide');
                                //     }
                                // },510);
                                // 练习测试结束进行 
                               ;(exerciseTestingDataArr.length * 5) == (i+1) * (j+1) && setTimeout(function(){$().getId('exerciseTestArea').removeClass('hide');self.endTest(); blendTest.satrtTestDesc()}, 1000);
                            }, timesInter);
                        })(i, j);
                       
                    }
                };

            },

            intermissionTime: function() { // 显示隐藏元素1 span的 间隔时间
                var self = this;
                setTimeout(function() {
                    // document.removeEventListener('click', self.clickRecordCb, false);
                    $().getId('exerciseTestArea').addClass('hide');
                }, 500);
            },

            clickRecordCb: function() {
                isClick = true;
                exerciseTestOopsCount -= 1;
                clikExerciseTestTimes = new Date().getTime();
                return;
                if (clikExerciseTestTimes - startExerciseTestTimes > 500) {
                    window.speechSynthesis.speak(soudTipsSpeakOops);
                    $().getId('oopsTips').removeClass('hide');
                    setTimeout(function() {
                        $().getId('oopsTips').addClass('hide');
                    }, 1000);
                    exerciseTestOopsCount += 1;
                    if (exerciseTestOopsCount == 3) {
                        isContinue = false;
                        document.removeEventListener('click', self.clickRecordCb, false);
                        $().getId('exerciseTestPart1').removeClass('hide');
                        $().getId('exerciseTestStart').addClass('hide');
                        // alert('不要继续了');
                    }
                } else {
                    this.exerciseResultData[index] = {
                        id: index,
                        time: clikExerciseTestTimes - startExerciseTestTimes,
                        count: 1,
                        status: 1
                    }
                }
            }
        };
       
        
        /**
         * 混合测试
         */
        var blendTest = {
            BcanStartTest: false, 
            blendTestResultData: [],
            startTestTime: new Date().getTime(),
            index: 0,
            OopsCount: 0,
            init: function() {
                this.satrtTest();
            },
            satrtTestDesc: function() {
                $().getId('blendTest').removeClass('hide');
                this.BcanStartTest = true;
            },
            satrtTest: function() {
                var self = this;

                $().getId('blendTestDesc').addClass('hide');
                $().getId('blendTestArea').removeClass('hide');
                
                self.blendTestResultData = [];
                var timesInter =  1000;
                for (var i=0; i < blendTestingDataArr.length; i++) {
                    for (var j=0; j < blendTestingDataArr[i].length; j++) {
                        timesInter += 1000;   
                        (function(i, j) {
                            setTimeout(function() {
                                if (!BtestOnoff) return;
                                self.index += 1; 
                                // 3次 oops 
                                //if (!isContinue) return;
                                self.intermissionTime();
                                self.blendTestResultData[self.index] = {
                                    id: self.index,
                                    time: -9999,
                                    count: 0,
                                    status: 0
                                }
                                var SneedShowData = blendTestingDataArr[i][j];
                                console.log(`混合测试每次的数据：${SneedShowData}`)
                                if (SneedShowData === 'a') {
                                    // 用户的点击反应
                                    document.addEventListener('click', self.clickRecordCb, false);
                                    $().getId('blendTestAreaSpan').removeClass('hide').html('1');
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === 'b') {
                                    $().getId('blendTestAreaSpan').removeClass('hide').html('2');
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === '1') { 
                                    $().getId('blendTestAreaSpan').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak1);
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === '2') {
                                    $().getId('blendTestAreaSpan').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak2);
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                };
                            ;(blendTestingDataArr.length * 5) == (i+1) * (j+1) && self.endTest();
                            }, timesInter);
                        })(i, j);
                    
                    }
                };
            },
            endTest: function() {
                // BisRecoveryTest = true;
                bHotTestView = true;
                bMainTestDesc = false;
                bSatrtHotTest = true;
                $().getId('blendTest').addClass('hide');
                // hotViewTest.isHotViewTest = true;
                //hotViewTest.startTestDesc();
                // 进行恢复测试
                recoveryTest.init();
            },
            intermissionTime: function() { // 显示隐藏元素1 span的 间隔时间
                setTimeout(function() {
                    $().getId('blendTestAreaSpan').addClass('hide');
                }, 500);
            },
            clickRecordCb: function() {
                isClick = true;
                exerciseTestOopsCount -= 1;
                clikExerciseTestTimes = new Date().getTime();
                return;
                if (clikExerciseTestTimes - startExerciseTestTimes > 500) {
                    window.speechSynthesis.speak(soudTipsSpeakOops);
                    $().getId('oopsTips').removeClass('hide');
                    setTimeout(function() {
                        $().getId('oopsTips').addClass('hide');
                    }, 1000);
                    exerciseTestOopsCount += 1;
                    if (exerciseTestOopsCount == 3) {
                        isContinue = false;
                        document.removeEventListener('click', self.clickRecordCb, false);
                        $().getId('exerciseTestPart1').removeClass('hide');
                        $().getId('exerciseTestStart').addClass('hide');
                        // alert('不要继续了');
                    }
                } else {
                    this.exerciseResultData[index] = {
                        id: index,
                        time: clikExerciseTestTimes - startExerciseTestTimes,
                        count: 1,
                        status: 1
                    }
                }
            }
        };

        /**
         * 恢复测试 包括恢复视觉与恢复听觉
         */
        var recoveryViewTestArr = ['aaaaa', 'aaaaa'];
        var recoveryTest = {
            isRecoveryTest: false,
            recoveryViewTestResultData: [],
            index: 1,
            isRecoverSoundTest: false,
            init: function() {
                this.isRecoveryTest = true;
                $().getId('recoveryTest').removeClass('hide');
                this.satrtTestDesc();
            },
            startViewDesc: function() {
                $().getId('recoveryViewTest').removeClass('hide');
                $().getId('recoveryViewTestPart1').removeClass('hide');
                showPart.part1('recoveryViewTestPart1H6', true);
                showPart.part2('recoveryViewTestPart1Span', 'recoveryViewTestPartTipsPart1',  'recoveryViewTestPartTipsPart2',  'recoveryViewTestPartTipsPart3',  'recoveryViewTestPartTipsPart4', false);
            },
            startViewTest: function() {
                var self = this;
                $().getId('recoveryViewTestArea').removeClass('hide');
                self.recoveryViewTestResultData = [];
                var timesInter =  1000;
                for (var i=0; i < recoveryViewTestArr.length; i++) {
                    for (var j=0; j < recoveryViewTestArr[i].length; j++) {
                        timesInter += 1000;   
                        (function(i, j) {
                            setTimeout(function() {
                                if (!BtestOnoff) return;
                                self.index += 1; 
                                // 3次 oops 
                                //if (!isContinue) return;
                                self.ViewintermissionTime();
                                self.recoveryViewTestResultData[self.index] = {
                                    id: self.index,
                                    time: -9999,
                                    count: 0,
                                    status: 0
                                }
                                var SneedShowData = recoveryViewTestArr[i][j];
                                if (SneedShowData === 'a') {
                                    // 用户的点击反应
                                    document.addEventListener('click', self.clickRecordCb, false);
                                    $().getId('recoveryViewTestArea').removeClass('hide').html('1');
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === 'b') {
                                    $().getId('recoveryViewTestArea').removeClass('hide').html('2');
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === '1') { 
                                    $().getId('recoveryViewTestArea').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak1);
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                } else if (SneedShowData === '2') {
                                    $().getId('recoveryViewTestArea').removeClass('hide').html('');
                                    window.speechSynthesis.speak(soudTipsSpeak2);
                                    self.startTestTime = new Date().getTime();
                                    self.OopsCount += 1;
                                };
                            ;(recoveryViewTestArr.length * 5) == (i+1) * (j+1) && self.startSoundDesc();
                            }, timesInter);
                        })(i, j);
                    
                    }
                };
                
            },
            startSoundDesc: function() {
                
                $().getId('recoveryViewTest').addClass('hide');
                $().getId('recoverySoundTest').removeClass('hide');
                

                this.isRecoverSoundTest = true;
                this.startSoundTest();
            },
            startSoundTest: function() {
                 // 你会在听到的数字，就像这样
                window.speechSynthesis.speak(soudTipsPart1);
            //
            },
            ViewintermissionTime: function() { // 显示隐藏元素1 span的 间隔时间
                setTimeout(function() {
                    $().getId('recoveryViewTestArea').addClass('hide');
                }, 500);
            },
            clickRecordCb: function() {
                isClick = true;
                exerciseTestOopsCount -= 1;
                clikExerciseTestTimes = new Date().getTime();
                return;
                if (clikExerciseTestTimes - startExerciseTestTimes > 500) {
                    window.speechSynthesis.speak(soudTipsSpeakOops);
                    $().getId('oopsTips').removeClass('hide');
                    setTimeout(function() {
                        $().getId('oopsTips').addClass('hide');
                    }, 1000);
                    exerciseTestOopsCount += 1;
                    if (exerciseTestOopsCount == 3) {
                        isContinue = false;
                        document.removeEventListener('click', self.clickRecordCb, false);
                        $().getId('exerciseTestPart1').removeClass('hide');
                        $().getId('exerciseTestStart').addClass('hide');
                        // alert('不要继续了');
                    }
                } else {
                    this.exerciseResultData[index] = {
                        id: index,
                        time: clikExerciseTestTimes - startExerciseTestTimes,
                        count: 1,
                        status: 1
                    }
                }
            },
            endTest: function(){}
        };
    };

    /**
     * 完成所有测试内容
     */
    var completeAllTest = function  () {
        $().getId('soundTest').addClass('hide');
        $().getId('completeAllTest').removeClass('hide');
    };
   
})();