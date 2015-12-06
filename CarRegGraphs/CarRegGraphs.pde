import controlP5.*;
ControlP5 cp5;
Accordion accordion;
DropdownList d1;

//Declare ArrayLists to hold all the data needed to create the graphs
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();
ArrayList<MarqueData> sortedData = new ArrayList<MarqueData>();
ArrayList<Integer> yearlyTotals = new ArrayList<Integer>();

//Objects to hold every graph that is to be created
ArrayList<Graph> marqueGraph;
Graph yearTotalGraph;
Graph marqueTotalGraph;
Graph sortedTotalGraph;
Graph slopegraph;

//Border variables
float borderW;
float borderH;

//Initialising values for finding the max and min total values
int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int slopeMin = 3000;
int slopeMax = 25000;

//All colours that are to be used when drawing the graphs
color bgColor = color(50);
color[] marqueColors;
color[] sortedColors;
color[] yearColors;

//Variables to control which graph to show
int mode = 1;
int marqueInd = 0;

void setup()
{
  //Setting the size of the presentation and the border width and height
  size(900, 900);
  borderW = width*0.1f;
  borderH = height*0.1f; //<>// //<>//
  //Loading the data from the .csv file
  loadData();
  
  //Initialising arrays to hold the colors for each graph
  marqueColors = new color[marqueData.size()];
  sortedColors = new color[marqueData.size()];
  yearColors = new color[marqueData.get(0).regNums.size()];
  
  //Creating a copy of the data that will be sorted
  sortedData.addAll(marqueData);
  
  //Sorting the copied data using a quicksort algorithm
  quicksort(sortedData, 0, marqueData.size()-1);
  
  //Setting the colours to be equal to the relevant colour for the Marque at index i in the ArrayList
  for(int i=0; i< marqueColors.length; i++)
  {
    marqueColors[i] = marqueData.get(i).c;
    sortedColors[i] = sortedData.get(i).c;
  }
  
  //Setting a random colour for each bar of the Yearly Totals bar chart
  for(int i=0; i< yearColors.length; i++)
  {
    yearColors[i] = color(random(127, 255), random(127, 255), random(127, 255));
  }
  
  //Creating a slopegraph using the top 10 marques in the sortedData ArrayList
  slopegraph = new Graph("Top 10 Marques", sortedData, slopeMax, slopeMin, borderW, borderH, sortedColors);
  
  //Calling methods used to create the graphs needed for the visualisation
  createYearlyTotalGraph();
  createMarqueGraphs();
  createTotalsGraph();
  
  //Creating a ControlP5 control panel used to swap between the various graphs
  gui();
}//end setup()

void draw()
{
  //Refreshing the screen
  background(bgColor);
  
  //Using a switch statement to determine which graph to draw
  switch(mode)
  {
    //Case 0 shows a barchart for each marque's total registrations between 2006 and 2015
    //The graph is sorted in alphabetical order relating to the marque name
    case 0:
    {
      d1.hide();
      marqueTotalGraph.drawBarChart();
      break;
    }
    
    //Case 1 shows a barchart for each marque's total registrations between 2006 and 2015
    //The graph is sorted in ascending order relating to the total registrations
    case 1:
    {
      d1.hide();
      sortedTotalGraph.drawBarChart();
      break;
    }
    
    //Case 2 shows a slopegraph that displays the average values sold by the
    //top 10 marques before and after the recession
    case 2:
    {
      d1.hide();
      slopegraph.drawSlopeGraph();
      
      break;
    }
    
    //Case 3 shows a barchart showing the total number of registered cars
    //overall for each year between 2006 and 2015
    case 3:
    {
      d1.hide();
      yearTotalGraph.drawBarChart();
      break;
    }
    
    //Case 4 allows the user to show a trendline for the total number of registered cars for
    //each marque between 2006 and 2015. 
    case 4:
    {
      //A dropdown list is shown to allow the user to choose which marque's data to show
      d1.show();
      marqueInd = int(d1.getValue());
      marqueGraph.get(marqueInd).drawTrendLine();
      marqueGraph.get(marqueInd).drawRegAmount();
      break;
    }
  }
}//end draw()

void gui()
{
  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("Choose Graph").setBackgroundColor(color(255, 50)).setBackgroundHeight(150);
  cp5.addRadioButton("radio")
    .setPosition(10, 20)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Marque Totals", 0)
    .addItem("Sorted Totals", 1)
    .addItem("Top 10 Marques", 2)
    .addItem("Yearly Totals", 3)
    .addItem("Single Marque Yearly Totals", 4)
    .setColorLabel(color(255))
    .activate(1)
    .moveTo(g1)
    ;
    
  d1 = cp5.addDropdownList("Pick which marque data to show")
    .setPosition(width-160, 20)
    .setWidth(150)
    .setItemHeight(10)
    .setBackgroundColor(color(255, 50))
    .close()
    .hide()
    ;
  
  for(int i=0; i< marqueData.size(); i++)
  {
    d1.addItem(marqueData.get(i).marqueName, i);
  }
  accordion = cp5.addAccordion("acc")
                  .setPosition(10, 20)
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
    
    case 3:
    {
      mode = 3;
      break;
    }
    
    case 4:
    {
      mode = 4;
      break;
    }
    
    default:
    {
      mode = 1;
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
  
  yearTotalGraph = new Graph("Yearly Totals", yearlyTotals, marqueData.get(0).years, maxYearly, minYearly, borderW, borderH, yearColors);
  
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
    marqueGraph.add(new Graph(marqueData.get(i).marqueName, marqueData.get(i).regNums, marqueData.get(0).years, maxTotal, minTotal, borderW, borderH, marqueData.get(i).c));
  }
}

void createTotalsGraph()
{
  ArrayList<String> marqueNames = new ArrayList<String>();
  ArrayList<Integer> marqueTotals = new ArrayList<Integer>();
  ArrayList<String> sortedNames = new ArrayList<String>();
  ArrayList<Integer> sortedTotals = new ArrayList<Integer>();
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
  
  for(MarqueData data: sortedData)
  {
    sortedNames.add(data.marqueName);
    sortedTotals.add(data.total);
  }
  
  marqueTotalGraph = new Graph("Alphabetical Marque Totals", marqueTotals, marqueNames, maxTotal, minTotal, borderW, borderH, marqueColors);
  sortedTotalGraph = new Graph("Sorted Marque Totals", sortedTotals, sortedNames, maxTotal, minTotal, borderW, borderH, sortedColors);
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