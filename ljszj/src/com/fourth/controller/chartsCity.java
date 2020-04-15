package com.fourth.controller;

import com.fourth.model.Check;
import net.sf.json.JSONObject;
import org.junit.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "chartsCity")
public class chartsCity extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    //响应城市图表页ajax请求，接受参数城市，从数据库中取出数据，转为json格式返回
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String city=request.getParameter("aimCity");
        System.out.println("chartsCity页面获得参数"+city);

        //检查数据

        JSONObject jsonObject=new JSONObject();
        jsonObject=Check.cpriceMonth(city);
        String data=jsonObject.toString();
        out.append(data);
        out.flush();
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
