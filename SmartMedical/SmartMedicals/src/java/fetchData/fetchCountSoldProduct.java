package fetchData;

import Connection.ConnectionProvider;
import java.sql.*;

public class fetchCountSoldProduct {
    public static int getSoldProducts() 
    {
        int countSoldProduct = 0;
        Connection conn = null;
        PreparedStatement stmtgpsc = null;
        ResultSet rsgpsc = null;
        
        try 
        {
            conn = ConnectionProvider.getcon();
            String quegpsc = "select sum(quantity) as quantity from bill_details";
            stmtgpsc = conn.prepareStatement(quegpsc);
            rsgpsc = stmtgpsc.executeQuery();
            if (rsgpsc.next()) 
            {
                String totalSoldStr = rsgpsc.getString("quantity");
                if (totalSoldStr != null) 
                {
                    countSoldProduct = (int) Double.parseDouble(totalSoldStr);
                }
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        } 
        finally 
        {
            try 
            {
                if (rsgpsc != null) rsgpsc.close();
                if (stmtgpsc != null) stmtgpsc.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }
        
        return countSoldProduct;
    }
    
    public static void main(String args[]) {
       getSoldProducts();
    }
}
