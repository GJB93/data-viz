void setup()
{
  size(900, 900);
  
  //Adding each year to the year ArrayList
  for(int i=0; i<y.length;i++)
  {
    years.add(y[i]);
  }
  
  //Loading the data from the .csv file
  loadData();
  
  //Setting the size for the colour array
  lineColours = new color[marqueData.size()];
  
  //Finding the maximum and minimum total values across all marques, as well as
  //setting the colour for each trend line
  for(int i=0; i<marqueData.size(); i++)
  {
    if(marqueData.get(i).max > maxTotal)
    {
      maxTotal = marqueData.get(i).max;
    }
    
    if(marqueData.get(i).min < minTotal)
    {
      minTotal = marqueData.get(i).min;
    }
    lineColours[i] = color(random(255), random(255), random(255));
  }
  
  //Creating the graph for each marque, and scaling it according to the maximum and
  //minimum totals found earlier
  for(int i=0; i<marqueData.size(); i++)
  {
    graph.add(new Graph(marqueData.get(i).getRegNums(), years, maxTotal, minTotal, width*0.1f, height*0.1f, lineColours[i]));
  }
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(0);
  for(int i=0; i<graph.size(); i++)
  {
    graph.get(i).drawTrendLine();
  }
}//end setup()

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();

//Declare an ArrayList to hold a graph for each car marque
ArrayList<Graph> graph = new ArrayList<Graph>();

//Create an array of colours for the trend lines
color[] lineColours;

//Creating a string array to copy into the years ArrayList
String[] y = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"};
ArrayList<String> years = new ArrayList<String>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

//Initialising values for finding the max and min total values
int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int maxTotal = maxInit;
int minTotal = minInit;

void draw()
{
  
}//end draw()

//Method to read the data from the file and place it into the MarqueData ArrayList
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
        temp = e;
        first = false;
      }//end else
    }//end foreach
    //Load the marque data into the data ArrayList
    marqueData.add(new MarqueData(temp, values));
  }//end foreach
}//end loadData()