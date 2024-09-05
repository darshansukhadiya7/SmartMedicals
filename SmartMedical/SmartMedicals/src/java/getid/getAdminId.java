package getid;

import java.sql.Connection;
import java.sql.SQLException;
import Connection.ConnectionProvider;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class getAdminId 
{
    public static int fetchAdminId(String uname)
    {
        int aid = 0;
        try
        {
            Connection con = ConnectionProvider.getcon();
            String que = "select aid from admin where username = '"+uname+"'";
            PreparedStatement stmt = con.prepareStatement(que);
            ResultSet rs = stmt.executeQuery();
            if(rs.next())
            {
                aid = rs.getInt("aid");
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return aid;
    }
    public static int checkAdminExist(String uname)
    {
        
        int aid = 0;
        try
        {
            Connection con = ConnectionProvider.getcon();
            String que = "select * from admin where username = '"+uname+"'";
            PreparedStatement stmt = con.prepareStatement(que);
            ResultSet rs = stmt.executeQuery();
            if(rs.next())
            {
                aid = 1;
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return aid;
    }
}
