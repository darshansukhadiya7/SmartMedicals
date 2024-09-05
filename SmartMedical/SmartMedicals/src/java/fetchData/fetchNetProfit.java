package fetchData;

import Connection.ConnectionProvider;
import java.sql.*;

public class fetchNetProfit 
{
    public static double getNetProfit()
    {
        double netProfit = 0;
        double discam = 0;
        Connection conn = null;
        PreparedStatement stmtnf = null;
        PreparedStatement stmtd = null;
        ResultSet rsnf = null;
        ResultSet rsd = null;
        try
        {
            conn = ConnectionProvider.getcon();
            // find profit
            String quenp = "SELECT SUM((IFNULL(m.selling_price, 0) - IFNULL(m.priceperpack, 0)) * IFNULL(bd.quantity, 0)) AS netprofit " +
                           "FROM bill_details bd " +
                           "JOIN medicine m ON bd.mname = m.mname";
            stmtnf = conn.prepareStatement(quenp);
            rsnf = stmtnf.executeQuery();
            
            // find discount
            String qued = "select sum(total - afterdtotal) as discamo from bill_total_details";
            stmtd = conn.prepareStatement(qued);
            rsd = stmtd.executeQuery();
            
            if(rsnf.next() && rsd.next())
            {
                String nfs = rsnf.getString("netprofit");
                String d = rsd.getString("discamo");
                if(nfs != null && d!=null)
                {
                    netProfit = Double.parseDouble(nfs);
                    discam = Double.parseDouble(d);
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
                if (rsnf != null) rsnf.close();
                if (stmtnf != null) stmtnf.close();
                if (conn != null) conn.close();
            } 
            catch (SQLException e) 
            {
                e.printStackTrace();
            }
        }        
        return netProfit - discam;
    }

    public static void main(String[] args)
    {
        getNetProfit();
    }
}
