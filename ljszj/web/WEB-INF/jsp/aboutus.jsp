<%--
  Created by IntelliJ IDEA.
  User: 雷蕾
  Date: 2019/7/10
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>关于我们</title>
    <link rel="stylesheet" href="../../css/aboutus.css" media="all">
    <script type="text/javascript" src="../../Jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src='../../Jquery/info_city.js'></script>

    <script>
        $(function(){
            var $animate = $('#animate');
            var $opposite = $('#opposite');
            $(".wrap").hover(function(){
                $animate.removeClass();
                $opposite.removeClass();
                $animate.addClass("test");
                $opposite.addClass('test2');
            },function(){
                $animate.removeClass();
                $opposite.removeClass();
                $animate.addClass("test2");
                $opposite.addClass('test');
            });

            $(".well-item").hover(function(){
                $(this).find(".correct").children().removeClass();
                $(this).find(".opposite").children().removeClass();
                $(this).find(".correct").children().addClass("test");
                $(this).find(".opposite").children().addClass('test2');
            },function(){
                $(this).find(".correct").children().removeClass();
                $(this).find(".opposite").children().removeClass();
                $(this).find(".correct").children().addClass("test2");
                $(this).find(".opposite").children().addClass('test');
            });

        });
    </script>

</head>

<body>
<!--导航栏-->
<div class="nav">
    <div class="nav_li">
        <ul>
            <li><a href="index.jsp">首页</a></li>
            <li><a href="info_city.jsp">信息查询</a></li>
            <li><a href="info_nei.jsp">搜索房源</a></li>
            <li><a href="predict.jsp">预测分析</a></li>
        </ul>
    </div>
</div>
<br><br>
<style>
    @keyframes fade-in {
        0% {opacity: 0;}/*初始状态 透明度为0*/
        40% {opacity: 0;}/*过渡状态 透明度为0*/
        100% {opacity: 1;}/*结束状态 透明度为1*/
    }
    @-webkit-keyframes fade-in {/*针对webkit内核*/
        0% {opacity: 0;}
        40% {opacity: 0;}
        100% {opacity: 1;}
    }
    #luojiashan {
        animation: fade-in;/*动画名称*/
        animation-duration: 1.5s;/*动画持续时间*/
        -webkit-animation:fade-in 1.5s;/*针对webkit内核*/
    }
    #zhongjie {
        animation: fade-in;/*动画名称*/
        animation-duration: 1.5s;/*动画持续时间*/
        -webkit-animation:fade-in 1.5s;/*针对webkit内核*/
    }
    .well{
        animation: fade-in;/*动画名称*/
        animation-duration: 1.5s;/*动画持续时间*/
        -webkit-animation:fade-in 1.5s;/*针对webkit内核*/
    }
</style>
<div id="luojiashan" style="font-family: 微软雅黑;font-size: 80px;text-align: center">
    珞珈山
</div>
<div id="zhongjie" style="font-family: 微软雅黑;font-size: 70px;margin-left: 100px;text-align: center;border-bottom: 1px solid #999999;width: 1300px">
    中介
</div>
<br><br>
<div class="well xiangmujingli" style="width: 600px;margin-left: 150px;">
    <div class="well-item">
        <div class="correct"><img src="../../images/kaifarenyuan.jfif"></div>
        <div class="oppsite">
            <div class="">
                <div class="opposite-content">
                    <div class="opposite-content-text">
                        咻咻咻写代码的开发人员
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="well xiangmujingli" style="width: 600px;margin-left: 700px;">
    <div class="well-item">
        <div class="correct"><img src="../../images/jishuzongjian.jfif"></div>
        <div class="oppsite">
            <div class="">
                <div class="opposite-content">
                    <div class="opposite-content-text">
                        写bug，debug的技术总监
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="well xiangmujingli" style="width: 600px;margin-left: 150px;">
    <div class="well-item">
        <div class="correct"><img src="../../images/chanpinjingli.gif"></div>
        <div class="oppsite">
            <div class="">
                <div class="opposite-content">
                    <div class="opposite-content-text">
                        程序员天敌的产品经理
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="well xiangmujingli" style="width: 600px;margin-left: 700px;">
    <div class="well-item">
        <div class="correct"><img src="../../images/cxy.jfif"></div>
        <div class="oppsite">
            <div class="">
                <div class="opposite-content">
                    <div class="opposite-content-text">
                        英俊帅气的项目经理
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
<div style="width: 1300px;border-bottom: 1px solid #999999;margin-left: 100px;">

</div>
<br>
<div style="font-family: '微软雅黑 Light';font-size: 24px;text-align: center">
    Copyright@珞珈山中介<br>
    项目经理：雷蕾<br>
    技术总监：屠闻哲<br>
    产品经理：刘梓轩<br>
    开发人员：钟辉
</div>

<script src="../../Jquery/bgLine.js"></script>
</body>
</html>
