class MarqueData
{
  //Setting the fields for the class
  String marqueName;
  int total;
  int max;
  int min;
  int preRecessionAvg;
  int postRecessionAvg;
  //This ArrayList holds all the yearly registration numbers for the car marque
  ArrayList<Integer> regNums;
  ArrayList<String> years;
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
    this.years = new ArrayList<String>();
    //Creating a string array to copy into the years ArrayList
    String[] y = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"};
    for(int i=0; i<y.length;i++)
    {
      years.add(y[i]);
    }
    this.regNums = new ArrayList<Integer>();
    for(int i=1; i<fields.length; i++)
    {
      this.regNums.add(Integer.parseInt(fields[i]));
    }
    total = calculateTotal(regNums);
    max = getMax(regNums);
    min = getMin(regNums);
    calculateAvg();
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
  
  void calculateAvg()
  {
    int numYearsPre = 3;
    int numYearsPost = 7;
    int preRecessionTotal = 0;
    int postRecessionTotal = 0;
    for(int i=0; i<numYearsPre; i++)
    {
      preRecessionTotal += regNums.get(i);
    }
    this.preRecessionAvg = preRecessionTotal/numYearsPre;
    for(int i=numYearsPre; i<regNums.size(); i++)
    {
      postRecessionTotal += regNums.get(i);
    }
    this.postRecessionAvg = postRecessionTotal/numYearsPost;
  }
  
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