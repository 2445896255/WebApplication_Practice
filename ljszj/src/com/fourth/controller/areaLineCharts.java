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

@WebServlet(name = "areaLineCharts")
public class areaLineCharts extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String city=request.getParameter("tarCity");
        String area=request.getParameter("tarArea");
        System.out.println("areaLineCharts参数"+city+area);


        //绘制区域折线图
        String sql="select distinct month,aprice_month from price_month where cityname='" + city + "' and areaname='" + area + "';";

        JSONObject json= Check.alcJson(sql);


        String data=json.toString();
        System.out.println(data);
        out.append(data);
        out.flush();
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
