package com.fourth.model;

import java.sql.*;

public class DB {

    //获取数据库连接
    public static Connection getConn()
    {
        Connection conn=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //conn= DriverManager.getConnection("jdbc:mysql://192.168.153.12:3306/first?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8","root","password");
            //conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/testcity?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8","root","hd13048526917435");
            conn=DriverManager.getConnection("jdbc:mysql://47.102.115.129:3306/first?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8","root","");
        }
        catch (ClassNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return conn;
    }
    //获取连接状态
    public static Statement getStatement(Connection conn)
    {
        Statement stmt=null;
        try {
            if(conn!=null)
            {
                stmt=conn.createStatement();
                //System.out.println("获取连接状态");
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
        return stmt;
    }
    //根据SQL语句获取查询结果
    public static ResultSet getResultset(Statement stmt, String sql)
    {
        ResultSet rs=null;
        try {
            if(stmt!=null)
            {
                rs=stmt.executeQuery(sql);
                //System.out.println("获取查询结果");
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
        /*****
        try {
            if(rs!=null&&rs.next()){

                System.out.println("rs不为空");

            }else{

                System.out.println("rs为空");

            }
        }catch (Exception e)
        {
            e.printStackTrace();
        }
         *****/

        return rs;
    }
    //关闭数据库连接
    public static void close(Connection conn)
    {
        try{
            if(conn!=null)
            {
                conn.close();
                conn=null;
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
    //关闭连接状态
    public static void close(Statement stmt)
    {
        try{
            if(stmt!=null)
            {
                stmt.close();
                stmt=null;
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
    //关闭查询
    public static void close(ResultSet rs)
    {
        try{
            if(rs!=null)
            {
                rs.close();
                rs=null;
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
}
