//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();

//Declare an ArrayList to hold a graph for each car marque
ArrayList<Graph> graph = new ArrayList<Graph>();
ArrayList<Integer> yearlyTotals = new ArrayList<Integer>();
Axis axis;

//Create an array of colours for the trend lines
color[] marqueLineColours, yearLineColours;

//Creating a string array to copy into the years ArrayList
String[] y = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"};
ArrayList<String> years = new ArrayList<String>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

float borderW;
float borderH;

//Initialising values for finding the max and min total values
int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int maxTotal = maxInit;
int minTotal = minInit;
int minYearly = minInit;
int maxYearly = maxInit;

void setup()
{
  size(900, 900);
  borderW = width*0.1f;
  borderH = height*0.1f;
  
  //Adding each year to the year ArrayList
  for(int i=0; i<y.length;i++)
  {
    years.add(y[i]);
  }
  
  //Loading the data from the .csv file
  loadData();
  
  //Setting the size for the colour array
  marqueLineColours = new color[marqueData.size()];
  yearLineColours = new color[years.size()];
  
  drawYearlyTotalGraph();
  
  //drawMarqueGraphs();
}//end setup()

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
    MarqueData marque = new MarqueData(s);
    marqueData.add(marque);
  }//end foreach
}//end loadData()

void drawYearlyTotalGraph()
{
  int total;
  
  for(int i=0; i<marqueData.get(0).regNums.size(); i++)
  {
      yearlyTotals.add(0);
  }
  
  for(int i=0; i<marqueData.size(); i++)
  {
    total = 0;
    for(int j=0; j<marqueData.get(i).regNums.size(); j++)
    {
      total = yearlyTotals.get(j);
      total += marqueData.get(i).regNums.get(j);
      yearlyTotals.set(j, total);
    } 
  }
  
  for(int i=0; i<yearlyTotals.size(); i++)
  {
    if(yearlyTotals.get(i) > maxYearly)
    {
      maxYearly = yearlyTotals.get(i);
    }
    
    if(yearlyTotals.get(i) < minYearly)
    {
      minYearly = yearlyTotals.get(i);
    }
    yearLineColours[i] = color(random(255), random(255), random(255));
  }
  
  for(int i=0; i<yearlyTotals.size(); i++)
  {
    graph.add(new Graph(yearlyTotals, years, maxYearly, minYearly, borderW, borderH, yearLineColours[i]));
  }
  
  axis = new Axis(yearlyTotals, years, maxYearly, minYearly, borderW, borderH, (width - (borderW*2.0f))/(marqueData.get(0).regNums.size()));
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(0);
  
  for(int i=0; i<graph.size(); i++)
  {
    graph.get(i).drawBarChart();
  }
  axis.drawAxis();
}

void drawMarqueGraphs()
{
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
    marqueLineColours[i] = color(random(255), random(255), random(255));
  }
  
  
  
  //Creating the graph for each marque, and scaling it according to the maximum and
  //minimum totals found earlier
  for(int i=0; i<marqueData.size(); i++)
  {
    graph.add(new Graph(marqueData.get(i).regNums, years, maxTotal, minTotal, borderW, borderH, marqueLineColours[i]));
  }
  
  axis = new Axis(marqueData.get(0).regNums, years, maxTotal, minTotal, borderW, borderH, (width - (borderW*2.0f))/(marqueData.get(0).regNums.size() -1)); 
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(0);
  
  for(int i=0; i<graph.size(); i++)
  {
    graph.get(i).drawTrendLine();
  }
  axis.drawAxis();
}