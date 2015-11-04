void setup()
{
  size(900, 900);
  for(int i=0; i<y.length;i++)
  {
    years.add(y[i]);
  }
  loadData();
  graph = new Graph(marqueData.get(20).getRegNums(), years, marqueData.get(20).max, width*0.1f, height*0.1f);
  println(marqueData.get(10).total);
}//end setup()

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();
ArrayList<String> marques = new ArrayList<String>();
Graph graph;

String[] y = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"};
ArrayList<String> years = new ArrayList<String>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

void draw()
{
  graph.drawBarChart();
  text(marqueData.get(20).marqueName, width/2, 20);
}//end draw()

//Method for checking the max value
int getMax(int num, int currMax)
{
  int temp = currMax;
  if(num > currMax)
  {
    temp = num;
  }//end if
  
  return temp;
}//end getMax()

//Method for checking the min value
int getMin(int num, int currMin)
{
  int temp = currMin;
  if(num < currMin)
  {
    temp = num;
  }//end if
  
  return temp;
}//end getMin()

//Method for checking the max value index
void getMaxInd(int num, int currMax, int i)
{
  if(num > currMax)
  {
    //topInd = i;
  }//end if
}//end getMaxInd()

//Method for checking the min value
void getMinInd(int num, int currMin, int i)
{
  if(num < currMin)
  {
    //botInd = i;
  }//end if
}//end getMinInd()

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
    
    //String to hold the name of the marque so that it can be set using the object constructor
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
        //If the first value is read, read it as the marque name
        marques.add(e);
        temp = e;
        first = false;
      }//end else
    }//end foreach
    //Load the marque data into the data ArrayList
    marqueData.add(new MarqueData(temp, values));
  }//end foreach
}//end loadData()