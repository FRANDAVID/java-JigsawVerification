<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet"
          href="http://m1.lefile.cn/myStatic/slidingVerification/css/jquery.slider.css?v=1520492823591">
    <script src="js/jquery-1.12.1.min.js"></script>
    <script src="js/drag.js"></script>
    <script type="text/javascript"
            src="http://m1.lefile.cn/??myStatic/slidingVerification/js/aes.js,myStatic/slidingVerification/js/jquery.slider.js,myStatic/slidingVerification/js/uc.js?v=2"></script>
    <script src="http://m1.lefile.cn/cerpglobal/zh_CN/passport/1.0.5/passport.js"></script>
    <script src="http://m1.lefile.cn??/cerpglobal/zh_CN/regist/0.0.11/regist.js"></script>

    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/jquery.slider.css"/>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
    <script src="js/jquery.slider.min.js" type="text/javascript"></script>

    <script src="js/login.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/captcha.css">

    <script type="text/javascript"
            src="js/fingerprint2.js"></script>
    <style>
        *{
            margin:0;
            padding:0;
            border:0;
        }
        .track-monitor{

            background-color:orange;
        }
        .track-pad{

            height:400px;
            background-color:navajowhite;
        }
        .track-coordinate{

            background-color:purple;
            color:white;
            height:25px;
            line-height:25px;
            font-size:12px;
        }
        .track-coordinate-list{
            font-size:12px;
            width:100%;
            word-break:break-word;
        }
    </style>
    <script>
      window.addEventListener('load', function () {
        var pad = document.getElementsByClassName('track-pad')[0];
        var monitor = document.getElementsByClassName('track-monitor')[0];
        var coordinate = document.getElementsByClassName('track-coordinate')[0];
        var clist = document.getElementsByClassName('track-coordinate-list')[0];
        var reset = document.getElementsByTagName('button')[0];
        var context = monitor.getContext('2d');
        var cset = [];
        var startx = 0, starty = 0;
        $('div').mousedown(mouseState).mouseup(mouseState);

        function fixSize() {
          monitor.width = window.innerWidth;
        };

        function log(e) {
          if (cset.length == 0) {
            context.moveTo(e.x, e.y);
          } else {
            context.strokeStyle = 'white';
            context.lineTo(e.x, e.y);
            context.stroke();
          }
          if (e.x - startx == e.x && e.y - starty == e.y) {
            startx = e.x;
            starty = e.y;
          }
          coordinate.innerHTML = '(' + (e.x - startx) + ', ' + (e.y - starty) + ')';
          cset.push(coordinate.innerHTML);
          clist.innerHTML = cset.join(', ');
        }

        function mouseState(e) {
          if (e.type == "mouseup") {
            $('#logs').append('<br/>' + cset.join(', '));
            clist.innerHTML = cset.join('');
            cset = [];
            pad.removeEventListener("mousemove", log);
          }
          if (e.type == "mousedown") {
            startx = 0;
            starty = 0;
            pad.addEventListener('mousemove', log);
          }
        }

        reset.addEventListener('click', function () {
          fixSize();
          cset = [];
          clist.innerHTML = '';
          coordinate.innerHTML = '在绿色的方块中滑动鼠标';
        });

        fixSize();
      });

    </script>
</head>
<body>
<div class="track-pad">
    <div id="slider_person" class="slider">
        <div class="ui-slider-wrap"
             style="width: 358px; height: 50px; background-color: rgba(255, 255, 255, 0);">
            <div class="ui-slider-text ui-slider-no-select add-img"
                 style="line-height: 50px; font-size: 14px; color: rgb(66, 66, 66);">请按住滑块，拖动到指定位置
            </div>
            <div class="ui-slider-btn init ui-slider-no-select"
                 style="width: 50px; height: 50px; line-height: 50px; left: 0px;"></div>
            <div class="ui-slider-bg"
                 style="height: 50px; background-color: rgb(51, 204, 0); width: 0px;"></div>
        </div>
    </div>
    <div class="sliderBox">
        <div id="slider2" class="slider">
            <!--<div id="slider_bg"></div>
            <span id="label"><i class="rightRow"></i></span>
            <span id="labelTip">请按住滑块，拖动到最右边</span>-->
        </div>
    </div>
    <div >
        <div class="yzm">
            <!--展示原图-->
            <div id="yzm_image_source" class="yzm_image_source"></div>
            <!--展示凹图-->
            <div id="yzm_image_cut_big" class="yzm_image_cut_big"></div>
            <!--加载中..-->
            <div id="yzm_image_cut_loading" class="yzm_image_cut_loading"></div>
            <!--拼图-->
            <div id="yzm_image_cut_small" class="yzm_image_cut_small"></div>
            <div style="top: 37px; left: 0px;display: none;"
                 id="xy_img"></div>
            <img id="refreshyzm" src="img/refresh.png"
                 style="position:relative;top: -60px;/* top:120px; */left: 280px;width: 20px;height: 20px;cursor: pointer;"
                 onclick="initYzm()">
        </div>
        <div id="drag" style="width: 260px;"></div>
    </div>
</div>
<div class="track-coordinate">在绿色的方块中滑动鼠标</div>
<button>重置</button>
<canvas width="900" height="200" class="track-monitor"></canvas>
<div id="logs"></div>
<div class="track-coordinate-list"></div>
<script >

    //初始化图形验证码
    initYzm();
    //注册验证码拖动事件
    $('#drag').drag(null, null, initYzm);

  function initYzm() {
    //加载中
    $("#xy_img").css("display", "none");
    $("#yzm_image_source").css("display", "none");
    $(".yzm_image_cut_big").css("display", "none");
    $(".yzm_image_cut_loading").show();
    $.ajax({
      type: "POST",
      async: true,
      url: "captcha/captchaImage",
      dataType: 'json',
      success: function (result) {
        if (result) {
          //设置大图，小图，及其位置
          $(".yzm_image_source").css("background-image",
              "url(captcha/image/" + result.sourceImgName + ")");
          $(".yzm_image_cut_big").css("background-image",
              "url(captcha/image/" + result.bigImgName + ")");
          $("#xy_img").css("background-image", "url(captcha/image/" + result.smallImgName + ")");
          $("#xy_img").css("top", Number(result.location_y) + "px");
          $(".yzm_image_cut_loading").css("display", "none");
          $(".yzm_image_source").show();
          $(".yzm_image_cut_big").css("display", "none");
        } else {
          $.ligerDialog.error('获取图形验证码失败！');
        }
      },
      error: function (errormsg) {
        $.ligerDialog.error("获取图形验证码失败！");
      }
    });
  }
</script>
</body>
</html>