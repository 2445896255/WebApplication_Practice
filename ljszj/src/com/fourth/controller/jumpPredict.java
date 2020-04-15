package com.fourth.controller;

import com.fourth.model.Check;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.time.Year;

@WebServlet(name = "jumpPredict")
public class jumpPredict extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        String pre=request.getParameter("pre");
        String[] predict = pre.split("\\s+");

        String message="error";

        if(predict.length==3)
        {
            System.out.println("jumpPredict获得3个参数分支");
            Check check=Check.checkmpCity(predict[0]);
            if(check!=null)
            {
                System.out.println("查找到城市");
                System.out.println("jumpPredict1:"+predict[0]);
                System.out.println("jumpPredict1:"+predict[1]);
                System.out.println("jumpPredict1:"+predict[2]);
                int year=Integer.parseInt(predict[1]);
                int month=Integer.parseInt(predict[2]);
                System.out.println("jumpPredict2:"+predict[0]+year+month);
                if(year>=1000&&year<=9999)
                {
                    if(month>=1&&month<=12)
                    {
                        System.out.println("jumpPredict三个参数都正确");
                        message="success";
                    }
                }
            }
        }

        JSONObject json=new JSONObject();
        json.put("message",message);
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
