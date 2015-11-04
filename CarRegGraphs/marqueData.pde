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
    yearRegNums.addAll(a);
  }
  
  ArrayList getYearRegNums()
  {
    return yearRegNums;
  }
}