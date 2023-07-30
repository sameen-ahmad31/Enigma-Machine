public class Enigma
{
    private int in;
    private int mid; 
    private int out; 
    private String given; 

    private String rin;
    private String rmid;
    private String rout;

    private char cin;
    private char cmid;
    private char cout;

    private String r1 = "#GNUAHOVBIPWCJQXDKRYELSZFMT";
    private String r2 = "#EJOTYCHMRWAFKPUZDINSXBGLQV";
    private String r3 = "#BDFHJLNPRTVXZACEGIKMOQSUWY";
    private String r4 = "#NWDKHGXZVRIFJBLMAOPSCYUTQE";
    private String r5 = "#TGOWHLIFMCSZYRVXQABUPEJKND";
  
    //create three Rotor objects
    private Rotor inner = new Rotor(" ",' ');
    private Rotor middle = new Rotor(" ", ' ');
    private Rotor outer = new Rotor(" ", ' ');


    public Enigma(int i, int m, int o, String s)
    {
        this.in = i;
        this.mid = m;
        this.out = o; 
        this.given = s;

    if(in == 1)
    {
        rin = r1;
    }
    else if (in == 2)
    {
        rin = r2;
    }
    else if (in == 3)
    {
        rin = r3;
    }
    else if (in == 4)
    {
        rin = r4;
    }
    else 
    {
        rin = r5;
    }

    if(mid == 1)
    {
        rmid = r1;
    }
    else if (mid == 2)
    {
        rmid = r2;
    }
    else if (mid == 3)
    {
        rmid = r3;
    }
    else if (mid == 4)
    {
        rmid = r4;
    }
    else {
        rmid = r5;
    }


    if(out == 1)
    {
        rout = r1;
    }
    else if (out == 2)
    {
        rout = r2;
    }
    else if (out == 3)
    {
        rout = r3;
    }
    else if (out == 4)
    {
        rout = r4;
    }
    else {
        rout = r5;
    }

    cin = given.charAt(0);
    cmid = given.charAt(1);
    cout = given.charAt(2);

    //update the Rotors with their new value
    inner = new Rotor(rin,cin);
    middle = new Rotor(rmid,cmid);
    outer = new Rotor(rout,cout);

    }


    //encrypt method 
    public String encrypt(String m)
    {
        String t = m;
        char c;
        char temp;
        int index;
        String enc = "";

        int intotal = 0;
        int midtotal = 0;
        int outotal = 0;

        for(int i = 0; i < t.length(); i++)
        {
            c = t.charAt(i);
            index = inner.getIndex(c);
            temp = outer.getCharacter(index);
            int y = middle.getIndex(temp);
            char d = outer.getCharacter(y);
            enc += Character.toString(d);

            if(intotal < 26)
            {
                inner.rotate();
                intotal++;
            }
            else if (midtotal < 26)
            {
                if(midtotal == 0)
                {
                    inner = new Rotor(rin,cin);
                }
                middle.rotate();
                midtotal++;
                if(midtotal >= 2)
                {
                    outer.rotate();
                }
                intotal = 0;
                midtotal = 0;
            }
            else if (outotal < 26)
            {
                outer.rotate();
                outotal++;
                intotal = 0;
                midtotal = 0;
            }
            else
            {
                intotal = 0; 
                midtotal = 0;
                outotal = 0;
                inner.rotate();
                intotal++;
            }

        }

        return enc;
    }



    //decrypt method 
    public String decrypt(String m)
    {
        String enc2 = "";

        char t;

        int intotal = 0;
        int midtotal = 0;
        int outotal = 0;

        for(int i = 0; i < m.length(); i++)
        {
            t = m.charAt(i);
            int index = outer.getIndex(t);
            char r = middle.getCharacter(index);
            int y = outer.getIndex(r);
            char d = inner.getCharacter(y);
            enc2 += Character.toString(d);

            if(intotal < 26)
            {
                inner.rotate();
                intotal++;
            }
            else if (midtotal < 26)
            {
                if(midtotal == 0)
                {
                    inner = new Rotor(rin,cin);
                }
                middle.rotate();
                midtotal++;
                if(midtotal >= 2)
                {
                    outer.rotate();
                }
                intotal = 0;
                midtotal = 0;
            }
            else if (outotal < 26)
            {
                outer.rotate();
                outotal++;
            }
            else
            {
                intotal = 0; 
                midtotal = 0;
                outotal = 0;
                inner.rotate();
                intotal++;
            }



        }

        return enc2;
    }


}




