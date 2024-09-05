package fetchData;

import Connection.ConnectionProvider;
import java.sql.*;

public class fetchCountProduct 
{
    public static int getTotalProducts()
    {
        int countProduct = 0;
        Connection conn = null;
        PreparedStatement stmtgpc = null;
        ResultSet rsgpc = null;
        
        try
        {
            conn = ConnectionProvider.getcon();
            String quegpc = "select sum(totalpack) as totalpack from medicine";
            stmtgpc = conn.prepareStatement(quegpc);
            rsgpc = stmtgpc.executeQuery();
            if(rsgpc.next())
            {
                String totalPackStr = rsgpc.getString("totalpack");
                if (totalPackStr != null) 
                {
                    countProduct = Integer.parseInt(totalPackStr);
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
                if (rsgpc != null) rsgpc.close();
                if (stmtgpc != null) stmtgpc.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }
        
        return countProduct;
    }
    

    
    public static void main(String[] args)
    {
        getTotalProducts();
    }
}
