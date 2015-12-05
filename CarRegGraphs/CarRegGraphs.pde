import controlP5.*;
ControlP5 cp5;
Accordion accordion;

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();

ArrayList<Integer> yearlyTotals = new ArrayList<Integer>();
ArrayList<Integer> totals2007 = new ArrayList<Integer>();
ArrayList<Integer> totals2015 = new ArrayList<Integer>();
ArrayList<Graph> marqueGraph;
Graph yearTotalGraph;
Graph marqueTotalGraph;
Graph slopegraph;
Axis axis;

float borderW;
float borderH;

//Initialising values for finding the max and min total values
int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int slopeMin = 3000;
int slopeMax = 25000;
int topNumber = 10;


color bgColor = color(50);
color[] slopeColors = new color[topNumber];
int mode = 1;

void setup()
{
  size(900, 900);
  borderW = width*0.1f;
  borderH = height*0.1f;
  //Loading the data from the .csv file
  loadData();
  
  quicksort(marqueData, 0, marqueData.size()-1);
  
  for(int i=0; i< topNumber; i++)
  { //<>//
    slopeColors[i] = color(random(127, 255), random(127, 255), random(127, 255));
  }
  slopegraph = new Graph("Top 10 Marques", marqueData, slopeMax, slopeMin, borderW, borderH, slopeColors);
  
  createYearlyTotalGraph();
  createMarqueGraphs();
  createTotalsGraph();
  gui();
}//end setup()

void draw()
{
  background(bgColor);
  switch(mode)
  {
    case 0:
    {
      marqueTotalGraph.drawBarChart();
      break;
    }
    
    case 1:
    {
      slopegraph.drawSlopeGraph();
      break;
    }
    
    case 2:
    {
      yearTotalGraph.drawBarChart();
      break;
    }
  }
}//end draw()

void gui()
{
  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("Choose Graph").setBackgroundColor(color(bgColor, 50)).setBackgroundHeight(150);
  cp5.addRadioButton("radio")
    .setPosition(10, 20)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Marque Totals", 0)
    .addItem("Top 10 Marques", 1)
    .addItem("Yearly Totals", 2)
    .setColorLabel(color(255))
    .activate(1)
    .moveTo(g1)
    ;
  accordion = cp5.addAccordion("acc")
                  .setPosition(width-(width*0.25f), borderH*0.5f)
                  .setWidth(200)
                  .addItem(g1)
                  ;
  accordion.setCollapseMode(Accordion.MULTI);
  accordion.open(0);
}

void radio(int theC)
{
  switch(theC)
  {
    case 0:
    {
      mode = 0;
      break;
    }
    
    case 1:
    {
      mode = 1;
      break;
    }
    
    case 2:
    {
      mode = 2;
      break;
    }
  }
}

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

void createYearlyTotalGraph()
{
  int total;
  int minYearly = minInit;
  int maxYearly = maxInit;
  color yearBarColour = color(random(127, 255), random(127, 255), random(127, 255));
  
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
  
  yearTotalGraph = new Graph("Yearly Totals", yearlyTotals, marqueData.get(0).years, maxYearly, minYearly, borderW, borderH, yearBarColour);
  
  //Drawing every graph, to show how the trend lines compare to one another
  background(bgColor);
  yearTotalGraph.drawBarChart();
}

void createMarqueGraphs()
{
  marqueGraph = new ArrayList<Graph>();
  //Finding the maximum and minimum total values across all marques, as well as
  //setting the colour for each trend line
  for(int i=0; i<marqueData.size(); i++)
  {
    int maxTotal = maxInit;
    int minTotal = minInit;
    if(marqueData.get(i).max > maxTotal)
    {
      maxTotal = marqueData.get(i).max;
    }
    
    if(marqueData.get(i).min < minTotal)
    {
      minTotal = marqueData.get(i).min;
    }
    color marqueLineColours = color(random(127, 255), random(127, 255), random(127, 255));
    marqueGraph.add(new Graph(marqueData.get(i).marqueName, marqueData.get(i).regNums, marqueData.get(0).years, maxTotal, minTotal, borderW, borderH, marqueLineColours));
  }
}

void createTotalsGraph()
{
  ArrayList<String> marqueNames = new ArrayList<String>();
  ArrayList<Integer> marqueTotals = new ArrayList<Integer>();
  int maxTotal = maxInit;
  int minTotal = minInit;
  //Finding the maximum and minimum total values across all marques, as well as
  //setting the colour for each trend line
  for(int i=0; i<marqueData.size(); i++)
  {
    if(marqueData.get(i).total > maxTotal)
    {
      maxTotal = marqueData.get(i).total;
    }
    
    if(marqueData.get(i).total < minTotal)
    {
      minTotal = marqueData.get(i).total;
    }
  }
  
  for(MarqueData data: marqueData)
  {
    marqueNames.add(data.marqueName);
    marqueTotals.add(data.total);
  }
  
  marqueTotalGraph = new Graph("Marque Totals", marqueTotals, marqueNames, maxTotal, minTotal, borderW, borderH, color(random(127, 255), random(127, 255), random(127, 255)));
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