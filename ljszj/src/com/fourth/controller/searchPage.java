package com.fourth.controller;

import com.fourth.model.Check;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "searchPage")
public class searchPage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //响应index.jsp ajax请求，接受参数调用python脚本，返回数据
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String province=request.getParameter("province");//不为空
        String city=request.getParameter("city");//不为空
        String area=request.getParameter("area");
        String keywords=request.getParameter("keywords");
        String startPage=request.getParameter("startPage");//一页10个
        String price=request.getParameter("price");
        String type=request.getParameter("type");
        String square=request.getParameter("square");

        System.out.println(province+city+area+keywords+startPage+price+type+square);


        int flag=0;

        if(startPage=="-1")
        {
            flag=1;
            startPage="1";
        }

        int page=Integer.parseInt(startPage);
        page=(page-1)*10;

        float startPrice=0;
        float endPrice=0;

        switch (price)
        {
            case "all":
                break;
            case "le80":
                endPrice=80;
                break;
            case "80100":
                startPrice=80;
                endPrice=100;
                break;
            case "100150":
                startPrice=100;
                endPrice=150;
                break;
            case "150200":
                startPrice=150;
                endPrice=200;
                break;
            case "200300":
                startPrice=200;
                endPrice=300;
                break;
            case "mo300":
                startPrice=300;
                break;
        }//如果选择全部，则开始与结束价格都为0

        String finType=null;
        switch (type)
        {
            case "all":
                finType="1|2|3|4|5|6|7|8|9";
                break;
            case "1":
                finType="1";
                break;
            case "2":
                finType="2";
                break;
            case "3":
                finType="3";
                break;
            case "4":
                finType="4";
                break;
            case "mo5":
                finType="5|6|7|8|9";
                break;
        }

        float startSqu=0;
        float endSqu=0;
        switch (square)
        {
            case "all":
                break;
            case "le60":
                endSqu=60;
                break;
            case "6090":
                startSqu=60;
                endSqu=90;
                break;
            case "90120":
                startSqu=90;
                endSqu=120;
                break;
            case "120140":
                startSqu=120;
                endSqu=140;
                break;
            case "140200":
                startSqu=140;
                endSqu=200;
                break;
            case "200300":
                startSqu=200;
                endSqu=300;
                break;
            case "mo300":
                startSqu=300;
                break;
        }

        String sql="";

        //sql="select distinct wuhan_community.type from wuhan_community";

        if(area!="区域")
        {//选择了区域
            System.out.println("进入选了区域的分支"+area);
            //判断条件价位、房型、面积

            if(price.equals("all")&&square.equals("all"))
            {
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname and city.area ='"+area+"')  limit "+page+",10;";
            }else if(!price.equals("all")&&square.equals("all")){
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and tttt_a.total_price  between "+startPrice+" and "+endPrice+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname and city.area ='"+area+"') limit "+page+",10;";
            }else if(price.equals("all")&&!square.equals("all")){
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and cast(tttt_a.square as decimal)  between "+startSqu+" and "+endSqu+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname and city.area ='"+area+"') limit "+page+",10;";
            }else{
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and  tttt_a.total_price  between "+startPrice+" and  cast(tttt_a.square as decimal)  between "+startSqu+" and "+endSqu+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname and city.area ='"+area+"') limit "+page+",10;";
            }

        }else{
            //未选择区域
            System.out.println("进入未选择区域的分支");

            if(price.equals("all")&&square.equals("all"))
            {
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname)  limit "+page+",10;";

            }else if(!price.equals("all")&&square.equals("all")){
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and tttt_a.total_price  between "+startPrice+" and "+endPrice+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname) limit "+page+",10;";
            }else if(price.equals("all")&&!square.equals("all")){
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and cast(tttt_a.square as decimal)  between "+startSqu+" and "+endSqu+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname) limit "+page+",10;";
            }else{
                sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and cast(tttt_a.type1 as char) regexp '" + finType + "'  and  tttt_a.total_price  between "+startPrice+" and  cast(tttt_a.square as decimal)  between "+startSqu+" and "+endSqu+"  and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname) limit "+page+",10;";
            }

        }

        System.out.println("*********************************");
        System.out.println(sql);


        JSONObject json=new JSONObject();
        json= Check.searPage(sql,flag);
        String data=json.toString();
        System.out.println(data);
        out.append(data);

        System.out.println("*********************************");
        out.flush();
        out.close();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
