package com.fourth.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONReader;
import org.junit.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.HashMap;
import java.util.Scanner;

@WebServlet(name = "getPreCharts")
public class getPreCharts extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        String city=request.getParameter("city");
        String year=request.getParameter("year");
        String month=request.getParameter("month");

        System.out.println("预测画图"+city+year+month);

        String[] time=new String[26];
        String[] real=new String[26];
        String[] calcu=new String[26];

        JSONReader reader = new JSONReader(new FileReader("E:\\Tomcat\\webapps\\预测json\\"+city+".json"));
        reader.startObject();
        System.out.println("start fastjson");

        while (reader.hasNext())
        {
            String key = reader.readString();
            System.out.println("key" + key);
            if(key.equals("date"))
            {
                System.out.println("预测画图进入ifdate分支");
                reader.startObject();
                System.out.println("start " + key);
                int i=0;
                while (reader.hasNext())
                {
                    String objectKey = reader.readString();
                    String objectValue = reader.readObject().toString();
                    time[i]=objectValue;
                    i++;
                }
                    reader.endObject();
                    System.out.print("ifdate分支结束");
            }
            else if(key.equals("predictprice")) {
                System.out.println("预测画图进入predict分支");
                reader.startObject();
                int i=0;
                while (reader.hasNext())
                {
                    String objectKey = reader.readString();
                    String objectValue = reader.readObject().toString();
                    calcu[i]=objectValue;
                    i++;
                }
                reader.endObject();
                System.out.print("predict分支结束");
            }
            else if(key.equals("now"))
            {
                System.out.print("进入now分支");
                reader.startObject();
                int i=0;
                while (reader.hasNext())
                {
                    String objectKey = reader.readString();
                    String objectValue = reader.readObject().toString();
                    real[i]=objectValue;
                    i++;
                }
                reader.endObject();
                System.out.print("now分支结束");
            }
        }

        reader.endObject();
        HashMap<String,String[]> result=new HashMap<>();
        result.put("time",time);
        result.put("predict",calcu);
        result.put("real",real);
        Object json=JSON.toJSON(result);
        String data=json.toString();
        System.out.println(data);
        out.println(json);
        out.flush();
        out.close();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request,response);
    }

//    @Test
//    public void test()
//    {
//        HashMap<String,String[]> asa=new HashMap<>();
//        String [] vv={"faf","412"};
//        asa.put("a",vv);
//        Object o = JSON.toJSON(asa);
//        System.out.println(o);
//    }

    @Test
    public void test2()
    {
        String[] time=new String[26];
        String[] real=new String[26];
        String[] calcu=new String[26];
        System.out.println("输入城市");
        //Scanner scanner=new Scanner(System.in);
        String city="北京";
        //city=scanner.next();

        try {
            JSONReader reader = new JSONReader(new FileReader("E:\\Tomcat\\webapps\\预测json\\" + city + ".json"));
            reader.startObject();
            System.out.println("start fastjson");

            while (reader.hasNext())
            {
                String key = reader.readString();
                System.out.print("key " + key);
                if(key.equals("date"))
                {
                    reader.startObject();
                    System.out.print("start object item");
                    int i=0;
                    while (reader.hasNext())
                    {
                        String objectKey = reader.readString();
                        String objectValue = reader.readObject().toString();
                        //System.out.print("key " + objectKey);
                        //System.out.print("value " + objectValue);
                        time[i]=objectValue;
                        i++;
                    }
                    reader.endObject();
                    System.out.print("end object item");
                }
                else if(key.equals("predictprice")) {
                        reader.startObject();
                        System.out.print("start object item");
                        int i=0;
                        while (reader.hasNext())
                        {
                            String objectKey = reader.readString();
                            String objectValue = reader.readObject().toString();
                            calcu[i]=objectValue;
                            i++;
                        }
                        reader.endObject();
                        System.out.print("end object item");
                    }
                else if(key.equals("now"))
                {
                        reader.startObject();
                        System.out.print("start object item");
                        int i=0;
                        while (reader.hasNext())
                        {
                            String objectKey = reader.readString();
                            String objectValue = reader.readObject().toString();
                            //System.out.print("key " + objectKey);
                            //System.out.print("value " + objectValue);
                            real[i]=objectValue;
                            i++;
                        }
                        reader.endObject();
                        System.out.print("end object item");

                }
            }

            reader.endObject();
            HashMap<String,String[]> result=new HashMap<>();
            result.put("time",time);
            result.put("predict",calcu);
            result.put("real",real);
            Object json=JSON.toJSON(result);
            String data=json.toString();
            System.out.println(data);
            }
        catch (Exception e)
        {
            e.printStackTrace();
        }


    }

    @Test
    public void ReadWithFastJson()
    {
        String jsonString = "{\"array\":[1,2,3],\"arraylist\":[{\"a\":\"b\",\"c\":\"d\",\"e\":\"f\"},{\"a\":\"b\",\"c\":\"d\",\"e\":\"f\"},{\"a\":\"b\",\"c\":\"d\",\"e\":\"f\"}],\"object\":{\"a\":\"b\",\"c\":\"d\",\"e\":\"f\"},\"string\":\"HelloWorld\"}";

        // 如果json数据以形式保存在文件中，用FileReader进行流读取！！
        // path为json数据文件路径！！
        // JSONReader reader = new JSONReader(new FileReader(path));

        // 为了直观，方便运行，就用StringReader做示例！
        JSONReader reader = new JSONReader(new StringReader(jsonString));
        reader.startObject();
        System.out.print("start fastjson");
        while (reader.hasNext())
        {
            String key = reader.readString();
            System.out.print("key " + key);
            if (key.equals("array"))
            {
                reader.startArray();
                System.out.print("start " + key);
                while (reader.hasNext())
                {
                    String item = reader.readString();
                    System.out.print(item);
                }
                reader.endArray();
                System.out.print("end " + key);
            }
            else if (key.equals("arraylist"))
            {
                reader.startArray();
                System.out.print("start " + key);
                while (reader.hasNext())
                {
                    reader.startObject();
                    System.out.print("start arraylist item");
                    while (reader.hasNext())
                    {
                        String arrayListItemKey = reader.readString();
                        String arrayListItemValue = reader.readObject().toString();
                        System.out.print("key " + arrayListItemKey);
                        System.out.print("value " + arrayListItemValue);
                    }
                    reader.endObject();
                    System.out.print("end arraylist item");
                }
                reader.endArray();
                System.out.print("end " + key);
            }
            else if (key.equals("object"))
            {
                reader.startObject();
                System.out.print("start object item");
                while (reader.hasNext())
                {
                    String objectKey = reader.readString();
                    String objectValue = reader.readObject().toString();
                    System.out.print("key " + objectKey);
                    System.out.print("value " + objectValue);
                }
                reader.endObject();
                System.out.print("end object item");
            }
            else if (key.equals("string"))
            {
                System.out.print("start string");
                String value = reader.readObject().toString();
                System.out.print("value " + value);
                System.out.print("end string");
            }
        }
        reader.endObject();
        System.out.print("start fastjson");
    }
}
