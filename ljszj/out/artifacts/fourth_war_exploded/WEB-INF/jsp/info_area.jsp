
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>--%>
<html>
<head>

    <%--<base href="<%=basePath%>">--%>
    <script type="text/javascript">

        //在jsp加载时调用函数
        if(window.addEventListener){
            window.addEventListener("load",getArea,false);
        }
        else{
            window.attachEvent("onload",getArea());
        }

        function getArea() {

            var area='<%=request.getParameter("area")%>';
            var city='<%=request.getParameter("city")%>';
            //TODO test
            alert("info_area界面"+city+area);
            document.getElementById("area_n").innerHTML=area.toString();
            $.ajax({
                dataType: "json",
                type: "POST",
                data: {city:city,area:area},
                url: "/areaComCharts",
                success: function(data){
                    var month=data.month;
                    var price=data.aprice_month;
                    //TODO test
                    //alert(data.toString());
                    document.getElementById("text").innerHTML=month.toString();
                    document.getElementById("price").innerHTML=price.toString();
                },
                error: function () {
                    alert("请求出错");
                }
            });

        }

        function selFun() {
            var city = document.getElementById("s_city");
            var area = document.getElementById("s_county");
            if (city.value == "城市" && area.value == "区域") {
                alert("请至少选择一项城市或区域");
            } else {
                if (area.value == "区域") {//选择了城市
                    //TODO test
                    alert("选择了城市，区域为默认"+city.value);
                    window.location.href='/info_city.jsp?target='+city.value;

                } else {
                    //选择了区域
                    //TODO test
                    //alert("选择了城市和区域"+city.value+area.value);
                    window.location.href='/info_area.jsp?area='+area.value+'&city='+city.value;
                }

            }
        }
    </script>

    <title>区域房价</title>
    <link rel="stylesheet" href="../../css/info_area.css" media="all">
    <script type="text/javascript" src="../../Jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src='../../Jquery/info_area.js'></script>
    <script type="text/javascript" src="../../Jquery/echarts.min.js"></script>
    <script type="text/javascript" src="../../Jquery/vintage.js"></script>
</head>
<body>

<!--导航栏-->
<div class="nav">
    <div class="nav_li">
        <ul>
            <li><a href="../../index.jsp">首页</a></li>
            <li><a href="info_nei.jsp">搜索房源</a></li>
            <li><a href="predict.jsp">预测分析</a></li>
            <li><a href="aboutus.jsp">关于我们</a></li>
        </ul>
    </div>
</div>

<!--大框框-->
<div class="big">
    <!--区域-->
    <div class="city_n" id="area_n">
        <!--江汉区-->
    </div>
    <div class="city_p text" id="text">
        <!--7月平均房价：-->
    </div>
    <div class="city_p price" id="price">
        <!--17266-->
    </div>
    <div class="city_p unit">
        元/平
    </div>

    <!--右侧小黑框-->
    <div style="background-color: black;opacity: 0.3;z-index: 3;width: 400px;height: 600px;float: right;">

    </div>

    <!--无色框框-->
    <div style="z-index: 4;width: 400px;height: 600px;float: right;position: absolute;margin-left: 1000px;">

        <div class="top choose" >
            Choose
        </div>
        <div class="top area" >
            Area.
        </div>
        <div class="top select">
            <button class="btn" type="button" onclick="selFun()"><span >SELECT</span></button>
        </div>

        <div class="info" style="margin-top: 0px;position: absolute;">
            <select id="s_province" name="s_province"></select>  
        </div>
        <div class="info" style="margin-top: 150px;position:absolute;">
            <select id="s_city" name="s_city" ></select>  
        </div>
        <div class="info" style="margin-top: 300px;position: absolute;">
            <select id="s_county" name="s_county"></select>
            <script class="resources library" src="../../Jquery/area.js" type="text/javascript"></script>
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
<style>
    .charlink{
        text-align: center;
        font-family: 微软雅黑;
        font-size: 24px;
        color: #3399FF;
        cursor: pointer;
        padding-top: 10px;
    }

    .link_bar{
        margin-left: 450px;
        position: absolute;
    }

    .link_line{
        margin-left: 900px;
        position: absolute;
    }

    .link_pic{
        width: 150px;height: auto
    }
</style>

<%--<div class="charlink link_bar">--%>
    <%--<a href="#bar">--%>
        <%--<img class="link_pic" src="../../images/bar.png">--%>
        <%--<br>--%>
        <%--柱状图--%>
    <%--</a>--%>

<%--</div>--%>
<%--<div class="charlink link_line">--%>
    <%--<a href="#line">--%>
        <%--<img class="link_pic" src="../../images/line.png">--%>
        <%--<br>--%>
        <%--折线图--%>
    <%--</a>--%>
<%--</div>--%>


<style type="text/css">
    #bar{
        margin-top: 300px;
        margin-left: 200px;
    }

    #line{
        margin-top: 100px;
        margin-left: 200px;
    }
</style>

<!--柱状图-->
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<!--
<div id="bar" style="width: 600px;height:400px;"></div>
<script src="Jquery/vintage.js"></script>
<script>
    var myChart = echarts.init(document.getElementById('bar'),'vintage');

    // 显示标题，图例和空的坐标轴
    myChart.setOption({
        title: {
            text: '区域平均房价'
        },
        tooltip: {},
        legend: {
            data:['房价']
        },
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [{
            name: '房价',
            type: 'bar',
            data: []
        }]
    });

    myChart.showLoading();
    // 异步加载数据（修改data.json）
    $.get('data.json').done(function (data) {
        myChart.hideLoading();
        // 填入数据
        myChart.setOption({
            xAxis: {
                data: data.categories
            },
            series: [{
                // 根据名字对应到相应的系列
                name: '房价',
                data: data.data
            }]
        });
    });
</script>
-->

<!--折线图-->
<div id="line" style="width: 1400px;height:600px;margin-left: 50px;"></div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    function loadAreaColumn() {
        var myChart = echarts.init(document.getElementById('line'),'vintage');

        // 显示标题，图例和空的坐标轴
        myChart.setOption({
            title: {
                text: '区域平均房价'
            },
            xAxis: {
                axisLabel: {
                    interval: 0,
                    formatter:function(value)
                    {
                        return value.split("").join("\n");
                    }
                },
                type: 'category',
                data: []
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [],
                type: 'line'
            }]
        });

        myChart.showLoading();
        // 异步加载数据（修改data.json）
        var names = [];    //类别数组（实际用来盛放X轴坐标值）
        var nums = [];    //销量数组（实际用来盛放Y坐标值）

        var tarCity='<%=request.getParameter("city")%>';
        var tarArea='<%=request.getParameter("area")%>';
        //TODO test
        alert("tarCity,tarArea"+tarCity+tarArea);
        $.ajax({
            type: 'get',
            data:{tarCity:tarCity,tarArea:tarArea},
            url: '/areaLineCharts',//请求数据的地址
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                $.each(result.list, function (index, item) {
                    names.push(item.time);    //挨个取出类别并填入类别数组
                    nums.push(item.price);    //挨个取出销量并填入销量数组
                });
                myChart.hideLoading();    //隐藏加载动画
                myChart.setOption({        //加载数据图表
                    xAxis: {
                        data: names
                    },
                    series: [{
                        // 根据名字对应到相应的系列
                        name: '房价',  //显示在上部的标题
                        data: nums
                    }]
                });
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        });
    }

    loadAreaColumn();
</script>








</body>
</html>
