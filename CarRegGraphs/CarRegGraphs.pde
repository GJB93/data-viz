void setup()
{
  size(500, 500);
  loadData();
  println(data.get(0).getYearRegNums());
}//end setup()

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> data = new ArrayList<MarqueData>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

void draw()
{
}//end draw()

//Method to read the data from the file and place it into the
//respective ArrayList
void loadData()
{
  //Load a String array with each line of the dataset file
  String[] lines = loadStrings(filename);
  for(String s:lines)
  {
    //Splitting each line at the comma
    String[] elements = s.split(",");
    String temp = "";
    
    //Declare an Integer ArrayList to hold each value
    ArrayList<Integer> values = new ArrayList<Integer>();
    
    //Boolean variable used to check if the first element is being read
    //so that it can be allocated to the marque ArrayList
    boolean first = true;
    
    //For each value on the line
    for(String e:elements)
    {
      //If the value read isn't the marque
      if(!first)
      {
        //Read the string value as an Int and add it to the ArrayList
        values.add(parseInt(e));
      }//end if
      else
      {
        temp = e;
        first = false;
      }//end else
    }//end foreach
    //Load the current line into the data ArrayList
    data.add(new MarqueData(temp, values));
  }//end foreach
}//end loadData()