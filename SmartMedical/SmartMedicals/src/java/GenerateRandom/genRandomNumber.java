package GenerateRandom;

import java.util.Random;
public class genRandomNumber 
{
    public static int id;
    public static int genRanNumber()
    {
        Random r = new Random();
        id = 10000 + r.nextInt(99999);
        return id;
    }   
}
