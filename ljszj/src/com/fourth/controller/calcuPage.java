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

@WebServlet(name = "calcuPage")
public class calcuPage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String province=request.getParameter("province");//不为空
        String city=request.getParameter("city");//不为空
        String area=request.getParameter("area");
        String keywords=request.getParameter("keywords");

        System.out.println(province+city+area+keywords);

        int i=0;

        if(area!="区域")
        {//选择了区域
            //TODO 数据库有问题，不知道wuhan_city这个表格
            System.out.println("进入选了区域的分支"+area);
            //查询共有多少条房源信息
            String sql="select tttt_a.* from tttt_a where tttt_a.city='" + city + "' and tttt_a.com_name like '%"+keywords+"%'  and tttt_a.com_name in (select city.com_name from city,city_use where city.area=city_use.areaname and city.area ='"+area+"');";
            //String sql="select wuhan_community.name,wuhan_community.type,wuhan_community.price,wuhan_community.date,wuhan_community.square,wuhan_community.total_price,wuhan_community.info from wuhan_city,wuhan_community where wuhan_city.name like '%"+keywords+"%' and wuhan_city.area_name='"+area+"' and wuhan_community.name=wuhan_city.name;";
            System.out.println(sql);
            i= Check.calPage(sql);
        }else{
            //未选择区域

        }
        int j=i%10;
        int pageNum=0;
        if(j==0)
        {
            pageNum=i/10;
        }else {
            pageNum=i/10+1;
        }
        String data=String.valueOf(pageNum);
        System.out.println(data);
        out.append(data);
        out.flush();
        out.close();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
