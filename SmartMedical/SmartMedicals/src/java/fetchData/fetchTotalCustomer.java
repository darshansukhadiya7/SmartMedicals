/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fetchData;

import Connection.ConnectionProvider;
import java.sql.*;

public class fetchTotalCustomer 
{
    public static int getTotalCustomer()
    {
        int totalCustomer = 0;
        Connection conn = null;
        PreparedStatement stmtgtc = null;
        ResultSet rsgtc = null;
        try
        {
            conn = ConnectionProvider.getcon();
            String quegtc = "select distinct count(cusname) as cusname from bill";
            stmtgtc = conn.prepareStatement(quegtc);
            rsgtc = stmtgtc.executeQuery();
            if(rsgtc.next())
            {
                String gtcs = rsgtc.getString("cusname");
                if(gtcs != null)
                {
                    totalCustomer = (int)Integer.parseInt(gtcs);
                }
            }   
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        finally 
        {
            try 
            {
                if (rsgtc != null) rsgtc.close();
                if (stmtgtc != null) stmtgtc.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }        
        return totalCustomer;
    }
    public static void main(String[] args)
    {
        getTotalCustomer();
    }
}
