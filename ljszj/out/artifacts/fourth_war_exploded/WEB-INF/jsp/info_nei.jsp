
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>--%>

<html>
<head>

    <%--<base href="<%=basePath%>">--%>
    <script>

        if(window.addEventListener){
            window.addEventListener("load",ajaxHouse,false);
        }
        else{
            window.attachEvent("onload",ajaxHouse());
        }

        var tarProvince = '<%=request.getParameter("province")%>';
        var tarCity = '<%=request.getParameter("city")%>';
        var tarArea = '<%=request.getParameter("area")%>';
        var keyWords = '<%=request.getParameter("keywords")%>';

        function ajaxHouse() {
            <%--var tarProvince = '<%=request.getParameter("province")%>';--%>
            <%--var tarCity = '<%=request.getParameter("city")%>';--%>
            <%--var tarArea = '<%=request.getParameter("area")%>';--%>
            <%--var keyWords = '<%=request.getParameter("keywords")%>';--%>
            var priceRa=document.getElementsByName("price");
            priceRa[0].checked=true;
            var typeRa=document.getElementsByName("type");
            typeRa[0].checked=true;
            var squareRa=document.getElementsByName("square");
            squareRa[0].checked=true;



            //TODO pageNum从本页面获取
            var pageNum = '<%=request.getParameter("pageNum")%>';
            //TODO test
            //alert("info_nei参数：" + tarProvince.value + tarCity.value + tarArea.value + keyWords.value+pageNum.value);
            alert("info_nei参数：" + tarProvince + tarCity + tarArea + keyWords + pageNum);

            if (tarCity.value != "城市") {//用户已经选择到了城市

                 $.ajax({
                    dataType: "json",
                    type: "POST",
                    data: {
                        province: tarProvince,
                        city: tarCity,
                        area: tarArea,
                        keywords: keyWords,
                        startPage: "1",
                        price: "all",
                        type: "all",
                        square: "all"
                    },
                    url: "/searchPage",
                    success: function (data) {
                        //TODO test
                        //TODO 获取第一页，含有十组值的json数组
                        //alert(data.toString());
                        alert("进入success语句");

                        var i=0;
                        $.each(data.list,function (index,item) {
                                //alert("进入each语句");
                                var name=item.name;
                                var price=item.price;
                                var total_price=item.total_price;
                                var square=item.square;
                                var type1=item.type1;
                                var type2=item.type2;
                                var avg_price=item.avg_price;
                                var info=item.info;
                                var build_time=item.build_time;

                                //TODO test
                                //alert(name+price+total_price+square+type1+type2+avg_price+info+build_time);
                                var html="";
                                html += "<div class='name'>" + name + "</div>"
                                    + "<div class='price_all'>" +"<div class='total'>"+ total_price +"</div> "+"<div class=''>元</div>"+"</div>"
                                    + "<div class='price_unit'>"+"<div class='one'>" + price+ "</div>" + "<div class='wanping '>万/平</div>"+"</div>"
                                    + "<div class='square'>"+"<div class='square_num'>" + square + "</div>" + "<div class='ping'>平</div>"+"</div>"
                                    + "<div class='type1'>" + type1 + "</div>"
                                    + "<div class='type2'>" + type2 + "</div>"
                                    + "<div>" + avg_price + "</div>"
                                    + "<div class='info'>" + info + "</div>"
                                    + "<div class='buildtime'>" + build_time + "</div>";

                                //alert("show"+i);
                                //alert(html);
                                //$(".show12").eq(index).html(html);//动s态插入html
                                $(".show12").eq(index).html(html);//动s态插入html

                        //alert("成功匹配");
                        //跳转城市图表页面，传参
                        //window.location.href='/info_city.jsp?target='+chartsCity.value;
                        });
                    },
                    error: function () {
                        alert("请求出错");
                    }

                });
            } else {
                //用户没有选择到城市
                alert("请选择城市");
            }
        }

        //TODO 绑定到筛选栏
        function selHouse() {

            var tempP=document.getElementsByName("price");
            var tempT=document.getElementsByName("type");
            var tempS=document.getElementsByName("square");
            var price;
            var type;
            var square;
            for(var i=0;i<tempP.length;i++){
                if(tempP[i].checked){
                    price = tempP[i].value;
                    break;
                }
            }
            for(var i=0;i<tempT.length;i++){
                if(tempT[i].checked){
                    type = tempT[i].value;
                    break;
                }
            }
            for(var i=0;i<tempS.length;i++){
                if(tempS[i].checked){
                    square = tempS[i].value;
                    break;
                }
            }

                $.ajax({
                    dataType: "json",
                    type: "POST",
                    data: {
                        province: tarProvince,
                        city: tarCity,
                        area: tarArea,
                        keywords: keyWords,
                        startPage: "-1",
                        price: price,
                        type: type,
                        square: square
                    },
                    url: "/searchPage",
                    success: function (data) {
                        //TODO test
                        //TODO 获取第一页，含有十组值的json数组，和当前页数

                    },
                    error: function () {
                        alert("请求出错");
                    }

                });

        }

        function changeHouse(page) {

            var tempP=document.getElementsByName("price");
            var tempT=document.getElementsByName("type");
            var tempS=document.getElementsByName("square");
            var price;
            var type;
            var square;
            for(var i=0;i<tempP.length;i++){
                if(tempP[i].checked){
                    price = tempP[i].value;
                    break;
                }
            }
            for(var i=0;i<tempT.length;i++){
                if(tempT[i].checked){
                    type = tempT[i].value;
                    break;
                }
            }
            for(var i=0;i<tempS.length;i++){
                if(tempS[i].checked){
                    square = tempS[i].value;
                    break;
                }
            }

            $.ajax({
                dataType: "json",
                type: "POST",
                data: {
                    province: tarProvince,
                    city: tarCity,
                    area: tarArea,
                    keywords: keyWords,
                    startPage: page,
                    price: price,
                    type: type,
                    square: square
                },
                url: "/searchPage",
                success: function (data) {
                    //TODO test
                    //TODO 获取对应页数，含有十组值的json数组

                },
                error: function () {
                    alert("请求出错");
                }

            });

        }
    </script>


    <title>搜索房源</title>
    <link rel="stylesheet" href="../../css/info_nei.css" media="all">
    <script type="text/javascript" src="../../Jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src='../../Jquery/info_city.js'></script>
    <script type="text/javascript" src="../../Jquery/echarts.min.js"></script>
</head>
<body>
<div class="nav">
    <div class="nav_li">
        <ul>
            <li><a href="../../index.jsp">首页</a></li>
            <li><a href="info_city.jsp">信息查询</a></li>
            <li><a href="predict.jsp">预测分析</a></li>
            <li><a href="aboutus.jsp">关于我们</a></li>
        </ul>
    </div>
</div>

<!--筛选框-->
<div class="filter">
    <div class="container" id="container">
        <div class="box">
            <div class="title-h">按条件筛选</div>
            <dl>
                <dt>售价</dt>
                <dd>
                    <input type="radio" name="price" class="all on" onclick="selHouse()" value="all">全部
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="le80">80万以下
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="80100">80-100万
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="100150">100-150万
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="150200">150-200万
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="200300">200-300万
                    <input type="radio" name="price" class="sx_child" onclick="selHouse()" value="mo300">300万以上
                </dd>
            </dl>
                <dl>
                    <dt>房型</dt>
                    <dd>
                        <input type="radio" name="type" class="all on" onclick="selHouse()" value="all">全部
                        <input type="radio" name="type" class="sx_child" onclick="selHouse()" value="1">一室
                        <input type="radio" name="type" class="sx_child" onclick="selHouse()" value="2">二室
                        <input type="radio" name="type" class="sx_child" onclick="selHouse()" value="3">三室
                        <input type="radio" name="type" class="sx_child" onclick="selHouse()" value="4">四室
                        <input type="radio" name="type" class="sx_child" onclick="selHouse()" value="mo5">大于等于五室
                    </dd>
                </dl>
                    <dl>
                        <dt>面积</dt>
                        <dd>
                            <input type="radio" name="square" class="all on" onclick="selHouse()" value="all">全部</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="le60">60㎡以下</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="6090">60-90㎡</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="90120">90-120㎡</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="120140">120-140㎡</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="140200">140-200㎡</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="200300">200-300㎡</a>
                            <input type="radio" name="square" class="sx_child" onclick="selHouse()" value="mo300">大于300㎡</a>
                        </dd>
                    </dl>
        </div>
    </div>
</div>

<%--
<script src="../../Jquery/tagSelect.js"></script>
<script>
    $(function(){
        new SelectTag({
            child : ".sx_child", //所有筛选范围内的子类
            over : 'on', //选中状态样式名称
            all : ".all"
        });
    })
</script>
--%>
<style >
    .show12 {
        height: 300px;
        opacity: 0;
        margin: 20px 145px 20px 145px;
        border-bottom: 1px solid #888888;
        z-index: 4;
    }
</style>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>
<div class="show12" id="show12"></div>


<!--
<script>
    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show1").offset().top;//获取元素距离顶部的距离
            var c=a-400;
            if(c<b){
                $("#show1").animate({//标题动画
                    left:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show2").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show2").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show3").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show3").animate({//标题动画
                    left:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show4").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show4").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show5").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show5").animate({//标题动画
                    left:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show6").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show6").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show7").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show7").animate({//标题动画
                    left:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show8").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show8").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show9").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show9").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });

    $(document).ready(function(){
        $(window).on('scroll',function(){
            var b=$(window).scrollTop();//获取滚动的高度
            var a=$("#show10").offset().top;//获取元素距离顶部的距离
            var c=a-600;
            if(c<b){
                $("#show10").animate({//标题动画
                    right:'350px',
                    opacity:'1',
                },'slow');
            }
        });
    });


</script>
-->

<!--翻页
<script src="../../Jquery/myPagination.js"></script>
<script>
    window.onload = function () {
        new Page({
            id: 'pagination',
            pageTotal: '%=request.getParameter(<"pageNum")%>', //必填,总页数
            pageAmount: 10,  //每页多少条
            //dataTotal: 500, //总共多少条数据
            curPage:1, //初始页码,不填默认为1
            pageSize: 5, //分页个数,不填默认为5
            showPageTotalFlag:true, //是否显示数据统计,不填默认不显示
            showSkipInputFlag:true, //是否支持跳转,不填默认不显示
            getPage: function (page) {
                //获取当前页数
                changeHouse(e);
            }
        })

    }
</script>
-->


<%--<script src="../../Jquery/bgLine.js">  </script>--%>
</body>
</html>
