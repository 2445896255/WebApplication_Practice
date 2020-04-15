
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <script>
        if(window.addEventListener){
            window.addEventListener("load",getPre,false);
        }
        else{
            window.attachEvent("onload",getPre());
        }

        function getPre() {
            var pre='<%=request.getParameter("pre")%>';
            var array=pre.split(" ");
            var city=array[0];
            var year=array[1];
            var month=array[2];
            //TODO test
            alert("predict.jsp:city"+city+"  year:"+year+"  month:"+month);
            //TODO 获取城市参数，js读取json文件并绘图

            document.getElementById("city").innerHTML=city;
            document.getElementById("year").innerHTML=year;
            document.getElementById("month").innerText=month;
            //获取预测值
            $.ajax({
                dataType: "json",
                type: "POST",
                data: {city:city,year:year,month:month},
                url: "/getPredict",
                success:function (data) {
                    //TODO 返回预测的该城市该年该月的值
                    document.getElementById("price").innerHTML=data.predict;
                },
                error:function () {
                    alert("请求出错");
                }
            });
        }
    </script>

    <title>预测分析</title>
    <link rel="stylesheet" href="css/predict.css">
    <script type="text/javascript" src="Jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Jquery/predict.js"></script>
    <script type="text/javascript" src="Jquery/echarts.min.js"></script>
    <script type="text/javascript" src="Jquery/easying.js"></script>
    <script type="text/javascript" src="Jquery/jquery.beattext.js"></script>

    <script type="text/javascript">

        $(document).ready(function() {
            /*
             *  参数详解:
             *	upTime			上移的时间
             *	downTime		下落的时间
             *	beatHeight		上移高度
             *	isAuth			是否自动
             *	isRotate		是否旋转
            */
            $('#beatText').beatText({isAuth:false,isRotate:false});


        });

    </script>


</head>
<body>
<div class="nav">
    <div class="nav_li">
        <ul>
            <li><a href="index.jsp">首页</a></li>
            <li><a href="info_city.jsp">信息查询</a></li>
            <li><a href="predict.jsp">预测分析</a></li>
            <li><a href="aboutus.jsp">关于我们</a></li>
        </ul>
    </div>
</div>
<div class="clear" style="width: 1400px;height: 50px;"></div>


<style>
    #container{

        width: 1400px;
        height: 400px;
        font-family: 微软雅黑;
        padding-left: 200px;
        position: relative;
        color: #ffffff;
        background-color: #ff9900;
    }
    #city{
        font-size: 100px;
        position: absolute;
        padding-left: 0px;
    }
    #year{
        font-size: 45px;
        position: absolute;
        padding-left: 220px;
        padding-top: 47px;
    }
    #month{
        font-size: 35px;
        position: absolute;
        padding-left: 350px;
        padding-top: 55px;
    }
    #pre{
        position: absolute;
        font-size:60px ;
        padding-top: 200px;
        padding-left: 200px;
    }
    #price{
        position: absolute;
        font-size:100px ;
        padding-top: 180px;
        padding-left: 750px;
    }
    #line{
        padding-top: 10px;
    }
</style>

<div  id="container">
    <p id="city"></p><br>
    <p id="year"></p><p>     </p>
    <p id="month"></p><br>
    <p id="pre">预测价格（元/平）：</p>
    <p id="price"></p>

</div>


<!--折线图-->
<div id="line" style="width: 1400px;height:400px;"></div>
<script type="text/javascript">
    function loadOneColumn() {
        var myChart = echarts.init(document.getElementById('line'),'vintage');
        // 显示标题，图例和空的坐标轴
        myChart.setOption({
            title: {
                text: '城市平均房价（元/平）'
            },
            tooltip: {},
            legend: {
                data: ['房价']
            },
            xAxis: {
                axisLabel: {
                    interval: 0,
                    formatter:function(value)
                    {
                        return value.split("").join("\n");
                    }
                },
                data: []
            },
            yAxis: {
                splitLine: { show: false },//去除网格线
                name: ''
            },
            series: [{
                barWidth: "30px",
                name: '预测房价',
                type: 'line',
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            position: 'top',
                            textStyle: {
                                color: '#333'
                            }
                        }
                    }
                },
                data: []
            },
                {
                    barWidth: "30px",
                    name: '实际房价',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            label: {
                                show: true,
                                position: 'top',
                                textStyle: {
                                    color: '#333'
                                }
                            }
                        }
                    },
                    data: []
                }
            ]
        });
        myChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
        // var names = [];    //类别数组（实际用来盛放X轴坐标值）
        // var nums = [];    //销量数组（实际用来盛放Y坐标值）

        var pre='<%=request.getParameter("pre")%>';
        var array=pre.split(" ");
        var city=array[0];
        var year=array[1];
        var month=array[2];
        $.ajax({
            type: 'get',
            url: '/getPreCharts',//请求数据的地址
            dataType: "json", //返回数据形式为json
            data: {city:city,year:year,month:month},
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                var time=eval(result.time);
                var pre=eval(result.predict);
                var real=eval(result.real);
                alert(time+pre+real);

                // $.each(result.list, function (index, item) {
                //     names.push(item.time);    //挨个取出类别并填入类别数组
                //     nums.push(item.price);    //挨个取出销量并填入销量数组
                // });

                myChart.hideLoading();    //隐藏加载动画
                myChart.setOption({        //加载数据图表
                    xAxis: {
                        data: time
                    },
                    series: [{
                        // 根据名字对应到相应的系列
                        name: '预测房价',  //显示在上部的标题
                        data: pre
                    },{
                        // 根据名字对应到相应的系列
                        name: '实际房价',  //显示在上部的标题
                        data: real
                    }
                    ]
                });
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        });
    };
    loadOneColumn();

</script>










</body>
</html>
