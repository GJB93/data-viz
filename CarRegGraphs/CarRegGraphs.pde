void setup()
{
  size(900, 900);
  for(int i=0; i<y.length;i++)
  {
    years.add(y[i]);
  }
  loadData();
  graph = new Graph[marqueData.size()];
  lineColours = new color[marqueData.size()];
  
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
  
  for(int i=0; i<graph.length; i++)
  {
    graph[i] = new Graph(marqueData.get(i).getRegNums(), years, maxTotal, minTotal, width*0.1f, height*0.1f, lineColours[i]);
  }
  
  background(0);
  for(int i=0; i<graph.length; i++)
  {
    graph[i].drawTrendLine();
  }
  
}//end setup()

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();
ArrayList<String> marques = new ArrayList<String>();
color[] lineColours;
Graph[] graph;

String[] y = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"};
ArrayList<String> years = new ArrayList<String>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int maxTotal = maxInit;
int minTotal = minInit;

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