class MarqueData
{
  //Setting the fields for the class
  String marqueName;
  //This ArrayList holds all the yearly registration numbers for the car marque
  ArrayList<Integer> regNums;
  
  //Constructors for the MarqueData class
  MarqueData()
  {
    marqueName = " ";
    regNums = new ArrayList<Integer>();
  }
  
  MarqueData(String s, ArrayList<Integer> a)
  {
    marqueName = s;
    regNums = new ArrayList<Integer>();
    setRegNums(a);
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
}