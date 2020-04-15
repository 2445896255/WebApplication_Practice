package com.fourth.controller;

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

@WebServlet(name = "getPredict")
public class getPredict extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        String city=request.getParameter("city");
        String year=request.getParameter("year");
        String month=request.getParameter("month");

        System.out.println("getPredict获得参数"+city+year+month);

        String predict=null;

        try {
            predict=execPy(city,year,month);
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("predict",predict);
            String data=jsonObject.toString();
            out.append(data);
            out.flush();
            out.close();
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public static String execPy(String city,String year,String month) throws Exception {

        Process process = null;

        String result=null;

        System.out.println("python参数"+city+year+month);

        try {
            System.out.println("开始执行脚本");
            //TODO 改路径
            String script = "E:\\Tomcat\\webapps\\open.py";
            String[] args = new String[]{"python", script, city, year, month};
            process = Runtime.getRuntime().exec(args);
            System.out.println("脚本执行完毕开始读取");
            InputStreamReader ir = new InputStreamReader(process.getInputStream(), "utf-8");
            BufferedReader in = new BufferedReader(ir);
            System.out.println("开始循环读取控制台信息");

//            for(int i = 0; (result = in.readLine()) != null; ++i) {
//                System.out.println("循环输出脚本执行结果");
//                String change = new String(result.getBytes("iso-8859-1"), "utf-8");
//                System.out.println(change);
//            }
            result=in.readLine();
            System.out.println(result);
            in.close();
            process.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            return result;
        }
    }
}
