//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();
ArrayList<String> topMarques2007 = new ArrayList<String>();
ArrayList<String> topMarques2015 = new ArrayList<String>();

ArrayList<Integer> yearlyTotals = new ArrayList<Integer>();
ArrayList<Integer> totals2007 = new ArrayList<Integer>();
ArrayList<Integer> totals2015 = new ArrayList<Integer>();
Axis axis;

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
  
  //Loading the data from the .csv file
  loadData();
  
  quicksort(marqueData, 0, marqueData.size()-1);
  
  Graph slope = new Graph(marqueData, maxYearly, minYearly, borderW, borderH, color(random(255), random(255), random(255)));
  background(0);
  slope.drawSlopeGraph();
  //drawYearlyTotalGraph();
  
  //drawMarqueGraphs(); //<>//
}//end setup()

void draw()
{
  
}//end draw()

//Method to read the data from the file and place it into the MarqueData ArrayList
void loadData()
{
  //Initialising a string with the name of the dataset file
  String filename = "carData20062015.csv";
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
  color yearBarColour = color(random(255), random(255), random(255));
  
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
    
  }
  
  Graph yearTotalGraph = new Graph(yearlyTotals, marqueData.get(0).years, maxYearly, minYearly, borderW, borderH, yearBarColour);
  
  axis = new Axis(yearlyTotals, marqueData.get(0).years, maxYearly, minYearly, borderW, borderH, (width - (borderW*2.0f))/(marqueData.get(0).regNums.size()));
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(0);
  yearTotalGraph.drawBarChart();
  axis.drawAxis();
}

void drawMarqueGraphs()
{
  ArrayList<Graph> graph = new ArrayList<Graph>();
  //Create an array of colours for the trend lines
  color[] marqueLineColours = new color[marqueData.size()];
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
    graph.add(new Graph(marqueData.get(i).regNums, marqueData.get(0).years, maxTotal, minTotal, borderW, borderH, marqueLineColours[i]));
  }
  
  axis = new Axis(marqueData.get(0).regNums, marqueData.get(0).years, maxTotal, minTotal, borderW, borderH, (width - (borderW*2.0f))/(marqueData.get(0).regNums.size() -1)); 
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(0);
  
  for(int i=0; i<graph.size(); i++)
  {
    graph.get(i).drawTrendLine();
  }
  axis.drawAxis();
}

void quicksort(ArrayList<MarqueData> array, int low, int high)
{
  int index = partition(array, low, high);
  if(low < index-1)
  {
    quicksort(array, low, index-1);
  }
  if(index < high)
  {
    quicksort(array, index, high);
  }
}

int partition(ArrayList<MarqueData> array, int low, int high)
{
  int i = low;
  int j = high;
  MarqueData temp;
  int pivot = array.get((low+high)/2).total;
  
  while(i <= j)
  {
    while(array.get(i).total < pivot)
    {
      i++;
    }
    
    while(array.get(j).total > pivot)
    {
      j--;
    }
    
    if(i <= j)
    {
      temp = array.get(i);
      array.set(i, array.get(j));
      array.set(j, temp);
      i++;
      j--;
    }
  }
  
  return i;
}