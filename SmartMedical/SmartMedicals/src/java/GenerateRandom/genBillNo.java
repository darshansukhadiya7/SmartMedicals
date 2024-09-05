package GenerateRandom;

import java.util.Random;

public class genBillNo {

    public int generateBillNumber() 
    {
        Random random = new Random();
        
        int num = random.nextInt(900000) + 1000; 
        int billNo = num;
        return billNo;
    }
}
