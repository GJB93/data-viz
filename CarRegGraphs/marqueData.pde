class MarqueData
{
  //Setting the fields for the class
  String marqueName;
  int total;
  //This ArrayList holds all the yearly registration numbers for the car marque
  ArrayList<Integer> regNums;
  
  
  //Constructors for the MarqueData class
  MarqueData()
  {
    marqueName = " ";
    total = 0;
    regNums = new ArrayList<Integer>();
  }
  
  MarqueData(String s, ArrayList<Integer> a)
  {
    marqueName = s;
    regNums = new ArrayList<Integer>();
    setRegNums(a);
    total = calculateTotal(regNums);
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
}