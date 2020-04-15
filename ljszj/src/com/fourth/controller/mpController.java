package com.fourth.controller;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.fourth.model.Check;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

@WebServlet(name = "mpController")
public class mpController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        //String city = new String(request.getParameter("chartsCity").getBytes("iso-8859-1"), "utf-8");
        String city=request.getParameter("chartsCity");
        String message = null;
        System.out.println(city);

        //HttpSession session=request.getSession();

        try {
            Check checkCity=Check.checkmpCity(city);
            System.out.println(checkCity);
            if (city != null && !"".equals(city)) {
                if (checkCity==null) {
                    message = "error";
                    //request.setAttribute("message", message);
                    System.out.println("未匹配不跳转");
                    //return "index.jsp";
                    //request.getRequestDispatcher("/index.jsp").forward(request, response);
                } else {//匹配到城市
                    //调用python脚本获取城市信息（当前价格、参考均价、区域列表、图表数据


                    //execPy(city);

                    //TODO 从数据库获取信息
                    System.out.println("匹配到城市");

                }
            } else {
                message = "error";
                request.setAttribute("message", message);
                System.out.println("为空不跳转");
                //return "index.jsp";
                //request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            //return "index.jsp";

            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("message",message);
        String data=jsonObject.toString();
        out.append(data);
        out.flush();
        out.close();
        //System.out.println(message);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request,response);
    }

    public static void execPy(String city) throws Exception {

        Process process = null;

        try {
            System.out.println("开始执行脚本");
            String script = "E:\\Tomcat\\webapps\\java.py";
            String[] args = new String[]{"python", script, city};
            process = Runtime.getRuntime().exec(args);
            System.out.println("脚本执行完毕开始读取");
            InputStreamReader ir = new InputStreamReader(process.getInputStream(), "utf-8");
            BufferedReader in = new BufferedReader(ir);
            System.out.println("开始循环读取控制台信息");
            String result;
            for(int i = 0; (result = in.readLine()) != null; ++i) {
                System.out.println("循环输出脚本执行结果");
                String change = new String(result.getBytes("iso-8859-1"), "utf-8");
                System.out.println(change);
            }
            in.close();
            process.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
