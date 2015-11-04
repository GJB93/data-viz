class MarqueData
{
  String marqueName;
  ArrayList<Integer> yearRegNums;
  
  MarqueData()
  {
    marqueName = " ";
    yearRegNums = new ArrayList<Integer>();
  }
  
  MarqueData(String s, ArrayList<Integer> a)
  {
    marqueName = s;
    yearRegNums = new ArrayList<Integer>();
    yearRegNums.addAll(a);
  }
  
  ArrayList getYearRegNums()
  {
    return yearRegNums;
  }
  
  void setYearRegNums(ArrayList<Integer> a)
  {
    yearRegNums.addAll(a);
  }
}