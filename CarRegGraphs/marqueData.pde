class MarqueData
{
  //Setting the fields for the class
  String marqueName;
  int total;
  int max;
  int min;
  //This ArrayList holds all the yearly registration numbers for the car marque
  ArrayList<Integer> regNums;
  ArrayList<String> years;
  
  //Each marque has its own colour
  color c;
  
  
  //Constructors for the MarqueData class
  MarqueData()
  {
    this("");
  }
  
  MarqueData(String line)
  {
    String[] fields = line.split(",");
    this.marqueName = fields[0];
    this.regNums = new ArrayList<Integer>();
    //Filling the regNums ArrayList with each value on the
    //line of data
    for(int i=1; i<fields.length; i++)
    {
      this.regNums.add(Integer.parseInt(fields[i]));
    }
    
    //Filling the years ArrayList with appropriate values
    this.years = new ArrayList<String>();
    for(int i=0; i<regNums.size();i++)
    {
      if((i+2)<10)
      {
        years.add("200" + (i+2));
      }
      else
      {
        years.add("20" + (i+2));
      }
    }
    total = calculateTotal(regNums);
    max = getMax(regNums);
    min = getMin(regNums);
    //Setting the marque's colour
    this.c = color(random(127, 255), random(127, 255), random(127, 255));
  }
  
  //Method to calculate the total registration numbers
  int calculateTotal(ArrayList<Integer> a)
  {
    int total = 0;
    //For each value
    for(int v:a)
    {
      //Add to the total marque value
      total += v;
    }//end for
    
    return total;
  }//end calculateYearlyValues()
  
  //Method to find the highest value across all years
  int getMax(ArrayList<Integer> a)
  {
    int maxInit=Integer.MIN_VALUE;
    int mx = maxInit;
    //For each value
    for(int v:a)
    {
      if(v > mx)
      {
        mx = v;
      }
    }//end for
    return mx;
  }
  
  //Method to find the lowest value across all years
  int getMin(ArrayList<Integer> a)
  {
    int minInit=Integer.MAX_VALUE;
    int mn = minInit;
    //For each value
    for(int v:a)
    {
      if(v < mn)
      {
        mn = v;
      }
    }//end for
    return mn;
  }
}