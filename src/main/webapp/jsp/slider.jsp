<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script type="text/javascript"
            src="https://m4.lefile.cn/memberstaticinc/static/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet"
          href="http://m1.lefile.cn/myStatic/slidingVerification/css/jquery.slider.css?v=1520492823591">
    <script type="text/javascript"
            src="http://m1.lefile.cn/??myStatic/slidingVerification/js/aes.js,myStatic/slidingVerification/js/jquery.slider.js,myStatic/slidingVerification/js/uc.js?v=2"></script>
    <script src="http://m1.lefile.cn/cerpglobal/zh_CN/passport/1.0.5/passport.js"></script>
    <script src="http://m1.lefile.cn??/cerpglobal/zh_CN/regist/0.0.11/regist.js"></script>
    <script>
      window.addEventListener('load', function () {
        var pad = document.getElementsByClassName('track-pad')[0];
        var monitor = document.getElementsByClassName('track-monitor')[0];
        var coordinate = document.getElementsByClassName('track-coordinate')[0];
        var clist = document.getElementsByClassName('track-coordinate-list')[0];
        // var reset = document.getElementsByTagName('button')[0];
        // var context = monitor.getContext('2d');
        var cset = [];
        var startx = 0, starty = 0;
        $('div').mousedown(mouseState).mouseup(mouseState);

        // function fixSize() {
        //   monitor.width = window.innerWidth;
        // };

        // function log(e) {
        //   if (cset.length == 0) {
        //     context.moveTo(e.x, e.y);
        //   } else {
        //     context.strokeStyle = 'white';
        //     context.lineTo(e.x, e.y);
        //     context.stroke();
        //   }
        //   if (e.x - startx == e.x && e.y - starty == e.y) {
        //     startx = e.x;
        //     starty = e.y;
        //   }
        //   coordinate.innerHTML = '(' + (e.x - startx) + ', ' + (e.y - starty) + ')';
        //   cset.push(coordinate.innerHTML);
        //   clist.innerHTML = cset.join(', ');
        // }

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

        // reset.addEventListener('click', function () {
        //   // fixSize();
        //   cset = [];
        //   clist.innerHTML = '';
        //   // coordinate.innerHTML = '在绿色的方块中滑动鼠标';
        // });

        // fixSize();
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
</div>
<div id="logs"></div>
</body>
</html>