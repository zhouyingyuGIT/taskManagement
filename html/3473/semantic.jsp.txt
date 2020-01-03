<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*"%>
<%@ page language="java" import="com.lattice.dao.*,java.util.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>semantic</title>
  <link rel='stylesheet' href='./css/semantic.css' />
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


  Vector<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
  if (ots.size()==0)
  {
    response.sendRedirect("/lattice/"+targetpagename);
    return; 
  }
  ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
  request.getSession().setAttribute("ot",ots.get(0));

%>

<body>
  <div class='con-word' id='con-word'>
    <p class='word_1' id='word_1'></p>
    <p><span class='word_2' id='word_2'></span><span class='word_3' id='word_3'></span></p>
  </div>
  <div class='con-pic' id='con-pic'>
    <img class='pic_1' id='pic_1' src='' />
    <p><img class='pic_2' id='pic_2' src='' /><img class='pic_3' id='pic_3' src='' /></p>
  </div>
  <div class='pause-30' id='pause-30'>
    <h1>屏幕上将同时出现三个词语（图片），请判断下方的两个词语（图片）中，哪一个与上方的一个词语（图片）意思更接近，如果是左边的词语（图片），请用左手按Q，如果是右边的词语（图片），请用右手按P。请尽量快、尽量准确地反应！请按任意键继续。</h1>
    <progress value="0" max="100" id="progress"></progress>
  </div>
  <script src="material.json"></script>
  <script src="/lattice/js/Statistics/Statistics.js" type=text/javascript></script>
  <script src="/lattice/js/jquery-1.8.2.min.js"></script>
  <script src="/lattice/js/oneui/opes_post_result_util.js"></script>	
  <script>  
  $(function(){
     
    function Sd(uid, sum) {
      this.data = []; 
      this.data_pic = [];
      this.data_word = [];     
      this.i = 0; 
      this.start_time = 0; 
      // 每次的间隔
      this.interval_b = false;
      // 15 30s 的间隔 1:不考虑 2:处于15 30s内 3:15 30s结束 开始之前 4:游戏开始之前
      this.interval_15 = 4;
      this.uid = uid;
      this.type = '';
      this.emptyFun = '';
      this.assignFun = '';
      this.sum = sum;
      this.start_time_main = 0;
      this.timeaverage = 0;

      this.duration = 0;  
      this.rtset = '';
      this.correctanswerset = '';
      this.type4set = '';
      this.stimidset = '';
      this.buttonset = '';
    };       

    Sd.prototype.init = function() {
      
      this._25in50('living_p');
      this._25in50('living_q');
      this._25in50('noliving_p');
      this._25in50('noliving_q');

      // 打乱data顺序
      this.data_pic.sort(this.randomsort);
      this.data_word.sort(this.randomsort);

      if(this.uid % 2 == 1){
        this.type = 'pic';
        this.data = this.data_pic.concat(this.data_word);
      }else{
        this.type = 'word';
        this.data = this.data_word.concat(this.data_pic);
      }
      this.switchFun();

      // debugger

      this.start();
      
    };

    // 捕获键盘时间
    $('html').keydown(function(event){      

      if(sd.interval_15 === 2){
        return false;
      }else if(sd.interval_15 === 3){
        sd.interval_15 = 1;
        sd.interval_b = false;
        $('#con-'+sd.type).show();
        $('#pause-30').hide();

        sd.start(++sd.i);
        return false;
      }

      if(sd.interval_15 === 4){
        $('#pause-30').hide();
        sd.interval_15 = 1;
        sd.start_time_main = new Date();
        sd.init();
        return false;
      }

      
      // q 81
      // p 80
      if(event.which !== 81 && event.which !== 80){
        return false;
      }

      if(!sd.interval_b){

        if(event.which === 81){
          sd.buttonset += "q;";
        }else if(event.which === 80){
          sd.buttonset += "p;";
        }

        clearTimeout(sd.intervalFunAll);

        if(event.which === 81 && sd.data[sd.i]["4"] === 'q'){
          // sd.correctanswerset += 'q';
        }else if(event.which === 81 && sd.data[sd.i]["4"] === 'p'){

        }else if(event.which === 80 && sd.data[sd.i]["4"] === 'q'){
          
        }else if(event.which === 80 && sd.data[sd.i]["4"] === 'p'){
          // sd.correctanswerset += 'p';
        }else{
          console.log('按键错误和结果异常');
        }
        
        var end_time = new Date();
      
        sd.rtset += end_time - sd.start_time+';';
        sd.timeaverage += end_time - sd.start_time;
        sd.interval(sd);
      }
      
    });

    Sd.prototype.start = function() {

      console.log(this.type);

      this.correctanswerset += this.data[this.i]["4"]+';';
      this.start_time = new Date();       
      var that = this;
      this.intervalFunAll = setTimeout(function(){
        that.rtset += '5000;';
        sd.timeaverage += 5000;
        that.buttonset += ";";
        clearTimeout(that.intervalFunAll);
        
        that.interval(that);
      }, 5000); 

      this.assignFun();
    };

    // 回合 的 间隔
    Sd.prototype.interval = function(obj) {        

        obj.interval_b = true;
        obj.emptyFun();
        // stimidset
        obj.stimidsetFun();
        // type4set
        obj.type4setFun();        

        //test
        console.log(obj.i+': buttonset :'+obj.buttonset);
        console.log(obj.i+': rtset :'+obj.rtset);
        console.log(obj.i+': correctanswerset :'+obj.correctanswerset);
        console.log(obj.i+': type4set :'+obj.type4set);
        console.log(obj.i+': stimidset :'+obj.stimidset);

        // 未结束
        if(obj.i < (obj.sum - 1)){
          
          // 如果是50次 需要 暂停
          if((obj.i === (obj.sum / 4) - 1) || (obj.i === (obj.sum / 4) * 3 - 1)){
            $('#con-word').hide();
            $('#con-pic').hide();
            $('#pause-30 h1').text('请休息一下');
            $('#pause-30').show();
            $('#pause-30').css('display', 'flex');
            this.interval_15 = 2;
            $('#progress').val(0);
            $('#progress').show();
            var setinterval_1 = setInterval(function(){
              $('#progress').val($('#progress').val()+1);
            }, 15 * 1000 / 100);
            // 刺激间隔为15s
            setTimeout(function(){
              clearInterval(setinterval_1);
              obj.interval_15 = 3;
              $('#progress').hide();
              $('#pause-30 h1').text('请按任意键继续');
            }, 15 * 1000);

            return false;
          }          

          // i = 99 30s暂停
          if(obj.i === (obj.sum / 2) - 1){
            $('#con-word').hide();
            $('#con-pic').hide();
            $('#pause-30 h1').text('请休息一下');
            $('#pause-30').show();
            $('#pause-30').css('display', 'flex');
            this.interval_15 = 2;
            $('#progress').val(0);
            $('#progress').show();
            var setinterval_2 =  setInterval(function(){
              $('#progress').val($('#progress').val()+1);
            }, 30 * 1000 / 100);
            // 刺激间隔为30s
            setTimeout(function(){
              clearInterval(setinterval_2);
              obj.interval_15 = 3;
              // 根据id做一些判断
              obj.type = obj.type === 'pic' ? 'word' : 'pic';
              obj.switchFun();
              $('#con-word').hide();
              $('#con-pic').hide();
              $('#progress').hide();
              $('#pause-30 h1').text('请按任意键继续');
            }, 30 * 1000);

            return false;
          }

          // 刺激间隔为1000ms
          setTimeout(function(){
            obj.interval_b = false;
            obj.start(++obj.i);
          }, 1000);
                    
        }else{
          this.duration = new Date() - this.start_time_main;
          this.timeaverage = this.timeaverage / this.sum;
          console.log('duration:'+this.duration);
          console.log('timeaverage:'+this.timeaverage);
          // 提交          
          this.post_result();
        }       
    };

    // 长度为25，元素在50以内，数组
    Sd.prototype._25in50 = function(prop) {

      var number_a = [];
      var sum = this.sum;

      var a_50 = [];
      for(var i=0; i< sum / 4; i++){
        a_50.push(i);
      }

      for(var i=0; i< (this.sum / 8); i++){
        var _ran = Math.floor(Math.random() * a_50.length);
        number_a.push(a_50[_ran]);
        a_50.splice(_ran, 1);
      }

      for(var i=0; i<number_a.length; i++){
        this.data_pic.push(material[prop][number_a[i]]);
      }

      for(var i=0; i<a_50.length; i++){
        this.data_word.push(material[prop][a_50[i]]);
      }

    };

    Sd.prototype.switchFun = function() {
      if(this.type === 'pic'){
        $('#con-word').hide();
        $('#con-pic').show();
        this.emptyFun = this.picEmptyFun;
        this.assignFun = this.picAssignFun;
      }else{
        $('#con-word').show();
        $('#con-pic').hide();
        this.emptyFun = this.wordEmptyFun;
        this.assignFun = this.wordAssignFun;
      }
    };

    // this.data 随机排序
    Sd.prototype.randomsort = function(a, b) {
     return Math.random()>.5 ? -1:1;
    };

    // 文字版 清空内容
    Sd.prototype.wordEmptyFun = function() {
      $('#word_1').text('');
      $('#word_2').text('');
      $('#word_3').text('');
    };

    // 文字版 赋值
    Sd.prototype.wordAssignFun = function() {
      $('#word_1').text(this.data[this.i]["1"]);
      $('#word_2').text(this.data[this.i]["2"]);
      $('#word_3').text(this.data[this.i]["3"]);
    };

    // 图片版 清空内容
    Sd.prototype.picEmptyFun = function() {
      $('#pic_1').attr('src', '');
      $('#pic_2').attr('src', '');
      $('#pic_3').attr('src', '');
    };

    // 图片版 赋值
    Sd.prototype.picAssignFun = function() {
      $('#pic_1').attr('src', ''+this.data[this.i]["6"]+'.png');
      $('#pic_2').attr('src', ''+this.data[this.i]["7"]+'.png');
      $('#pic_3').attr('src', ''+this.data[this.i]["8"]+'.png');
    };

    // stimidset
    Sd.prototype.stimidsetFun = function() {

      var data = this.data[this.i];

      if(data["5"] === 'living' && this.type === 'pic'){
        this.stimidset += (+data["9"]+1)+';';
      }else if(data["5"] === 'nonliving' && this.type === 'pic'){
        this.stimidset += (+data["9"]+101)+';';
      }else if(data["5"] === 'living' && this.type === 'word'){
        this.stimidset += (+data["9"]+201)+';';
      }else{
        this.stimidset += (+data["9"]+301)+';';
      }

    };

    // type4set
    Sd.prototype.type4setFun = function() {
      
      var data = this.data[this.i];
      if(data["5"] === 'living' && data["4"] === 'q' && this.type === 'pic'){
        this.type4set += '1;';
      }else if(data["5"] === 'living' && data["4"] === 'p' && this.type === 'pic'){
        this.type4set += '1;';
      }else if(data["5"] === 'nonliving' && data["4"] === 'q' && this.type === 'pic'){
        this.type4set += '2;';
      }else if(data["5"] === 'nonliving' && data["4"] === 'p' && this.type === 'pic'){
        this.type4set += '2;';
      }else if(data["5"] === 'living' && data["4"] === 'q' && this.type === 'word'){
        this.type4set += '3;';
      }else if(data["5"] === 'living' && data["4"] === 'p' && this.type === 'word'){
        this.type4set += '3;';
      }else if(data["5"] === 'nonliving' && data["4"] === 'q' && this.type === 'word'){
        this.type4set += '4;';
      }else{
        this.type4set += '4;';
      }

    };

    // 去掉最后一个;
    Sd.prototype.cancelLast = function(str) {
      
      return str.slice(0, str.length-1);

    };

    Sd.prototype.post_result = function() {
      console.log('post-result');
      var opes_result_data={};

      opes_result_data.taskid=<%=taskid%>;
      opes_result_data.sumitcoids=<%=sumitcoids%>;
      opes_result_data.targetpagename="<%=targetpagename%>";
      opes_result_data.codematerial=<%=codematerial%>;
      opes_result_data.uid=<%=uid%>;
      opes_result_data.lan="<%=lan%>";
      opes_result_data.projectid=<%=projectid%>;
        
      //////////////////////////////////////////////////////////////////
      opes_result_data.duration=this.duration;
      opes_result_data.timeaverage=Math.round(this.timeaverage); 
      ///////////////////////////////////////////////////////////////////
      opes_result_data.type4set = this.cancelLast(this.type4set);
      opes_result_data.stimidset = this.cancelLast(this.stimidset);
      opes_result_data.correctanswerset = this.cancelLast(this.correctanswerset);
      opes_result_data.numset="";
      opes_result_data.timeset= this.cancelLast(this.rtset);      
      opes_result_data.radioset="";    
      opes_result_data.buttonset = this.cancelLast(this.buttonset); 
      opes_result_data.commentset=""; 

      opes_post_result_util_js_opes_post_result(opes_result_data);
      return;
    };

    // java userid
    var sd = new Sd(<%=uid%>, 200);
    $('#pause-30').css('height', window.innerHeight);
    // sd.init();


  });
  </script>
</body>
</html>