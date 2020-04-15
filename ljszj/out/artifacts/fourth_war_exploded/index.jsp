
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="com.fourth.model.Check" %>

<%--<%
    String path = request.getContextPath();
    System.out.println(path+"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>--%>

<html>
<head>

    <%--<base href="<%=basePath%>">--%>
    <script type="text/javascript" src="Jquery/jquery-3.3.1.min.js"></script>
    <!--<script type="text/javascript" src="ajaxFun.js"></script>-->

  <title>珞珈山中介</title>
  <link rel="stylesheet" href="css/index.css" media="all">
  <script type="text/javascript" src="Jquery/jquery-3.3.1.min.js"></script>

  <!--处理信息查询主页，根据城市跳转 -->
  <script type="text/javascript">
      function ajaxFun(){
          var chartsCity=document.getElementById("chartsCity");
          $.ajax({
              dataType: "json",
              type: "POST",
              data: $('#chartsCity').serialize(),
              url: "/mpController",
              success: function(data){
                  //$.messager.alert('信息','模板保存成功');
                  var result=data.message;
                  if(data.message=="error")
                  {
                      alert("未能匹配到该城市");
                  }
                  else
                  {
                      //alert("成功匹配");
                      //跳转城市图表页面，传参
                      window.location.href='/info_city.jsp?target='+chartsCity.value;
                  }
              },
              error: function () {
                  alert("请求出错");
              }
          });
      }
  </script>

  <!--处理搜索房源主页-->
  <script type="text/javascript">
    function ajaxHouse() {
        var tarProvince=document.getElementById("s_province");
        var tarCity=document.getElementById("s_city");
        var tarArea=document.getElementById("s_county");
        var keyWords=document.getElementById("keyWords");
        //alert(tarProvince.value+tarCity.value+tarNeibor.value+keyWords.value+keyWords+keyWords.toString()+keyWords.toString().length);
        if(tarCity.value!="城市")
        {//用户已经选择到了城市
            //TODO test
            alert("index搜索房源准备进入ajax语句"+tarProvince.value+tarCity.value+tarArea.value+keyWords.value);
            $.ajax({
            dataType: "json",
            type: "POST",
            data: {province:tarProvince.value,
                city:tarCity.value,
                area:tarArea.value,
                keywords:keyWords.value},
            url: "/calcuPage",
            success: function(data){
                //TODO test
                //alert(data);
                if(data=="0")
                {
                    alert("未能匹配到对应房源！");
                }
                else
                {
                    window.location.href='/info_nei.jsp?province='+tarProvince.value+
                        '&city='+tarCity.value+'&area='+tarArea.value+
                        '&keywords='+keyWords.value+'&pageNum='+data;
                }
                //alert("成功匹配");
                //跳转城市图表页面，传参
                //window.location.href='/info_city.jsp?target='+chartsCity.value;
            },
                error: function () {
                    alert("请求出错");
                }

            });
        }else{
            //用户没有选择到城市
            alert("请选择城市");
        }
    }

    <!--处理预测主页-->
    function ajaxPre() {
        var pre=document.getElementById("predict");
        //TODO test
        alert("predict:"+pre.value);
        $.ajax({
            dataType: "json",
            type: "POST",
            data: {pre:pre.value},
            url: "/jumpPredict",
            success:function (data) {
                if(data.message=="error")
                {
                    alert("无法做出预测");
                }
                else
                {
                    //alert("成功匹配");
                    //跳转城市图表页面，传参
                    window.location.href='/predict.jsp?pre='+pre.value;
                }
            },
            error:function () {
                alert("请求出错");
            }
        });
    }
  </script>

</head>
<body id="by" style="overflow-y: hidden;">

<script type="text/javascript" src="Jquery/index.js"></script>
<div class="menus menus3">
  <ul>
    <div class="bg"></div>
    <li><span style="font-family: '微软雅黑'">信息查询</span></li>
    <li><span style="font-family: '微软雅黑'">搜索房源</span></li>
    <li><span style="font-family: '微软雅黑'">预测分析</span></li>
  </ul>
  <div class="clear"></div>

  <!--信息查询-->
  <div class="tab tab2 show" style="position: relative">
    <div style="position: absolute;z-index:1">
      <img class="img" src="images/background3.jpg">
    </div>
    <div style="position: relative;z-index: 2;">

      <div style="width: 200px;height: 200px;position:absolute;">
        <img class="logo" src="images/logo.png" >
      </div>

      <div style="width:500px;height: 200px; margin-left:0px;margin-top: 0px;position:absolute;z-index: 3;padding-top:0;">
        <div style="margin-top: 0;margin-left: 0;width: 650px;height: 100px;font-family: 'Bradley Hand ITC';font-size: 50px">
          Open the New World.
        </div>
      </div>

      <!--搜索框-->
      <div  class="search searchBox" style="margin-top:350px;width:250px;height:350px;position:absolute;text-align:center;padding-left: 250px; vertical-align:middle;">
        <form id="cityForm">
          <input name="chartsCity" id="chartsCity" type="text" placeholder="搜索从这里开始...">
          <button id="submit" type="button" onclick="ajaxFun()"></button>
        </form>

      </div>
    </div>

  </div>

  <!--搜索房源-->
  <div class="tab tab2" style="position: relative">
    <div style="position: absolute;z-index:1">
      <img class="img" src="images/background4.jpg">
    </div>
    <div style="position: relative;z-index: 2;">

      <div style="width: 200px;height: 200px;position:absolute;">
        <img class="logo" src="images/logo.png" >
      </div>

      <div style="width:500px;height: 50px; margin-left:0px;margin-top: -40px;position:absolute;z-index: 3;padding-top:0;">
        <div style="margin-top: 0;margin-left: 290px;width: 650px;height: 50px;font-family: 'Bradley Hand ITC';font-size: 50px">
          Start your New Life.
        </div>
      </div>

      <div  class="search searchBox" style="margin-top:280px;width:580px;height:350px;position:absolute;text-align:center;padding-left: 220px; vertical-align:middle;">
        <form id="keyForm">
          <input type="text" id="keyWords" placeholder="输入关键字...">
          <button type="button" onclick="ajaxHouse()"></button>
        </form>

      </div>

      <!--右侧小黑框-->
      <div style="background-color: black;opacity: 0.3;z-index: 3;width: 400px;height: 650px;float: right;">

      </div>

      <!--无色框框-->
      <div style="z-index: 4;width: 400px;height: 650px;float: right;position: absolute;margin-left: 1000px;">
        <style type="text/css">
          a{ color:#006600; text-decoration:none;}
          a:hover{color:#990000;}
          .top{ position: absolute;width: 200px;height: 100px;color: white;font-family: 'Bradley Hand ITC';font-size: 50px}
          .choose{margin-top: 0px;}
          .area{margin-top: 150px;}
          .info select{ border-radius: 10px;border:1px #993300 solid; background:#FFFFFF;width: 190px;height:35px;overflow: hidden }
          .info{  text-align:center;z-index: 4;position: relative;width: 100px;height:100px;float:right;padding-top: 150px;}
          .info #show{ color:#3399FF; }
          .bottom{ text-align:right; font-size:12px; color:#CCCCCC; width:1000px;}
        </style>
        <div class="top choose" >
          Choose
        </div>
        <div class="top area" >
          Area.
        </div>
        <div class="top select">

          <style>
            .btn{
              margin-top: 550px;
              width: auto;
              height:auto;
              background-color: rgba(0,0,0,0.1);
              color: white;
              font-family: "Bradley Hand ITC";
              z-index: 4;
              font-size: 40px;
              padding: 4px auto;
              cursor: pointer;
              border-radius: 15px;
            }
          </style>
          <button class="btn" type="button" onclick="ajaxHouse()"><span >SELECT</span></button>
        </div>

        <div class="info" style="margin-top: 0px;position: absolute;">
          <select id="s_province" name="s_province"></select>  
        </div>
        <div class="info" style="margin-top: 150px;position:absolute;">
          <select id="s_city" name="s_city" ></select>  
        </div>
        <div class="info" style="margin-top: 300px;position: absolute;">
          <select id="s_county" name="s_county"></select>
          <script class="resources library" src="Jquery/area.js" type="text/javascript"></script>
          <script type="text/javascript">_init_area();</script>

        </div>
<%--        <script type="text/javascript">
            var Gid  = document.getElementById ;
            var showArea = function(){
                Gid('show').innerHTML = "<h3>省" + Gid('s_province').value + " - 市" +
                    Gid('s_city').value + " - 县/区" +
                    Gid('s_county').value + "</h3>"
            }
            Gid('s_county').setAttribute('onchange','showArea()');
        </script>--%>
      </div>



    </div>

  </div>
  <!--预测分析-->
    <div class="tab tab2">
        <div style="position: absolute;z-index:1">
            <img class="img" src="images/background1.jpg">
        </div>
        <div style="position: relative;z-index: 2;">

            <div style="width: 200px;height: 200px;position:absolute;">
                <img class="logo" src="images/logo.png" >
            </div>

            <div style="width:400px;height: 200px; margin-left:0px;margin-top: 0px;position:absolute;z-index: 3;padding-top:0;">
                <div style="margin-top: 0;margin-left: 0;width: 650px;height: 100px;font-family: 'Bradley Hand ITC';font-size: 50px">
                    Hello, The Future!
                </div>
            </div>

            <!--搜索框-->
            <div  class="search searchBox" style="margin-top:350px;width:250px;height:350px;position:absolute;text-align:center;padding-left: 200px; vertical-align:middle;">
                <form>
                    <input type="text" id="predict" placeholder="请输入您要预测的城市和时间（年、月，如2019 8）...">
                    <button type="button" onclick="ajaxPre()"></button>
                </form>

            </div>
        </div>

    </div>


<script src="Jquery/bgLine.js">  </script>
</div>
</body>
</html>
