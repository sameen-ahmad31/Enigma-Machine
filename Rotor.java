public class Rotor
{
    private String str = "";
    private  char t = ' '; 
    
    public Rotor(String b, char g)
    {
        str = b;
        t = g; 
        str = str.substring(str.indexOf(t), str.length()) + str.substring(0, str.indexOf(t));
    }

    //rotate clockwise 
    public void rotate() 
    {
        str = str.substring(str.length()-1, str.length()) + str.substring(0, str.length()-1);
    }

    //return the index in the String at which a given character appears
    public int getIndex(char o)
    {
        return (str.indexOf(o));
    }

    // return the character at a given index
    public char getCharacter(int u)
    {
        return (str.charAt(u));
    }
    













}




