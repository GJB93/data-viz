class MarqueData
{
  //Setting the fields for the class
  String marqueName;
  int total;
  int max;
  int min;
  //This ArrayList holds all the yearly registration numbers for the car marque
  ArrayList<Integer> regNums;
  
  
  //Constructors for the MarqueData class
  MarqueData()
  {
    this("");
  }
  
  MarqueData(String line)
  {
    String[] fields = line.split(",");
    this.marqueName = fields[0];;
    this.regNums = new ArrayList<Integer>();
    for(int i=1; i<fields.length; i++)
    {
      this.regNums.add(Integer.parseInt(fields[i]));
    }
    total = calculateTotal(regNums);
    max = getMax(regNums);
    min = getMin(regNums);
  }
  
  //Accessor for the regNums ArrayList
  ArrayList getRegNums()
  {
    return regNums;
  }
  
  //Mutator for the regNums ArrayList
  void setRegNums(ArrayList<Integer> a)
  {
    regNums.addAll(a);
  }
  
  String getMarqueName()
  {
    return marqueName;
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