/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fetchData;

import Connection.ConnectionProvider;
import java.sql.*;

public class fetchAdmin 
{
    static Connection conn = null;
    public static String getAdminName()
    {
        String aname = null;
        PreparedStatement stmtfan = null;
        ResultSet rsfan = null;
        
        try
        {
            conn = ConnectionProvider.getcon();
            String queryfan = "select username from admin where special='y'";
            stmtfan = conn.prepareStatement(queryfan);
            rsfan = stmtfan.executeQuery();
            if(rsfan.next())
            {
                aname = rsfan.getString("username");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            try 
            {
                if (rsfan != null) rsfan.close();
                if (stmtfan != null) stmtfan.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }
        return aname;
    }
    
    public static int getCountUser()
    {
        int usercount = -1;
        PreparedStatement stmtfac = null;
        ResultSet rsfac = null;
        
        try
        {
            conn = ConnectionProvider.getcon();
            String queryfan = "select count(*) as countuser from admin where special='N'"; 
            stmtfac = conn.prepareStatement(queryfan);
            rsfac = stmtfac.executeQuery();
            if(rsfac.next())
            {
                usercount = rsfac.getInt("countuser");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            try 
            {
                if (rsfac != null) rsfac.close();
                if (stmtfac != null) stmtfac.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }
        return usercount;
    }
    public static void main(String args[])
    {
        getAdminName();
        getCountUser();
    }
}
