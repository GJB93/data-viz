import controlP5.*;
ControlP5 cp5;
Accordion accordion;
DropdownList d1;

//Declare ArrayLists to hold all the data needed to create the graphs
ArrayList<MarqueData> marqueData = new ArrayList<MarqueData>();
ArrayList<MarqueData> sortedData = new ArrayList<MarqueData>();
ArrayList<Integer> yearlyTotals = new ArrayList<Integer>();
ArrayList<Integer> preRecession = new ArrayList<Integer>();
ArrayList<Integer> postRecession = new ArrayList<Integer>();
ArrayList<String> sortedNames = new ArrayList<String>();

//Objects to hold every graph that is to be created
ArrayList<Graph> marqueGraph;
Graph yearTotalGraph;
Graph marqueTotalGraph;
Graph sortedTotalGraph;
Graph slopegraph;
Graph preRecessionPresence;
Graph postRecessionPresence;

//Border variables
float borderW;
float borderH;

//Initialising values for finding the max and min total values
int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int slopeMin = 2300;
int slopeMax = 23000;

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
  borderH = height*0.1f; //<>//
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
  
  //Calling methods used to create the graphs needed for the visualisation
  createSlopegraph();
  preRecessionPresence = new Graph("Pre-Recession Presence", preRecession, sortedNames, slopeMax, slopeMin, borderW, borderH, sortedColors);
  postRecessionPresence = new Graph("Post-Recession Presence", postRecession, sortedNames, 11000, slopeMin, borderW, borderH, sortedColors);
  createYearlyTotalGraph();
  createMarqueGraphs();
  createAvgsGraph();
  
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
    //Case 0 shows a barchart for each marque's average registrations between 2006 and 2015
    //The graph is sorted in alphabetical order relating to the marque name
    case 0:
    {
      d1.hide();
      marqueTotalGraph.drawBarChart();
      break;
    }
    
    //Case 1 shows a barchart for each marque's average registrations between 2006 and 2015
    //The graph is sorted in ascending order relating to the average registrations
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
    
    //Case 4 shows a square graph, in which the area shows the presence of the top
    //10 marque pre-recession
    case 4:
    {
      d1.hide();
      preRecessionPresence.drawSquareGraph();
      break;
    }
    
    //Case 5 is the same as case 4, except using post-recession averages
    case 5:
    {
      d1.hide();
      postRecessionPresence.drawSquareGraph();
      break;
    }
    
    //Case 6 allows the user to show a trendline for the total number of registered cars for
    //each marque between 2006 and 2015. 
    case 6:
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


/*
  This method is used to create the ControlP5 menu that is used to
  switch between the different graphs
*/
void gui()
{
  //Creating a new ControlP5 object
  cp5 = new ControlP5(this);
  
  /*
    Creating an accordion group that will hold radio buttons
    to allow the user to switch between the different groups
    of graphs
  */
  Group g1 = cp5.addGroup("Choose Graph").setBackgroundColor(color(255, 50)).setBackgroundHeight(180);
  
  /*
    Creating the radio buttons for switching graphs
  */
  cp5.addRadioButton("radio")
    .setPosition(10, 20)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Marque Averages", 0)
    .addItem("Sorted Averages", 1)
    .addItem("Top 10 Marques", 2)
    .addItem("Yearly Totals", 3)
    .addItem("Pre-Recession Presence", 4)
    .addItem("Post-Recession Presence", 5)
    .addItem("Single Marque Yearly Totals", 6)
    .setColorLabel(color(255))
    .activate(1)
    .moveTo(g1)
    ;
  
  /*
    Creating a dropdown list to allow the user to choose
    which car marque's yearly data to show
  */
  d1 = cp5.addDropdownList("Pick which marque data to show")
    .setPosition(width-160, 20)
    .setWidth(150)
    .setItemHeight(10)
    .setBackgroundColor(color(255, 50))
    .close()
    .hide()
    ;
  
  /*
    Adding each marque name to the dropdown list
    and giving them a value equal to that of their
    position in the ArrayList
  */
  for(int i=0; i< marqueData.size(); i++)
  {
    d1.addItem(marqueData.get(i).marqueName, i);
  }
  /*
    Creating an accordion that holds the menu options
  */
  accordion = cp5.addAccordion("acc")
                  .setPosition(10, 20)
                  .setWidth(200)
                  .addItem(g1)
                  ;
  //Allowing multiple accordion groups to be open
  accordion.setCollapseMode(Accordion.MULTI);
  //Setting the accordion to be open by default
  accordion.open(0);
}

/*
  The radio method controls what happens when
  each radio button is pressed
*/
void radio(int theC)
{
  /*
    The switch statement controls which mode the
    program enters depending on the radio button
    chosen
  */
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
    
    case 5:
    {
      mode = 5;
      break;
    }
    
    case 6:
    {
      mode = 6;
      break;
    }
  }
}

//Method to read the data from the file and place it into the MarqueData ArrayList
void loadData()
{
  //Initialising a string with the name of the dataset file
  String filename = "carData20022015.csv";
  //Load a String array with each line of the dataset file
  String[] lines = loadStrings(filename);
  
  //For each line in the file
  for(String s:lines)
  {
    //Create a new MarqueData object using the line of data
    MarqueData marque = new MarqueData(s);
    //Add the object to the ArrayList
    marqueData.add(marque);
  }//end foreach
}//end loadData()

/*
  This method creates a slopegraph using the pre-recession an post-recession
  average registration numbers for the top 10 marques
*/
void createSlopegraph()
{
  
  for(int i=sortedData.size()-1; i>sortedData.size()-11; i--)
  {
    preRecession.add(sortedData.get(i).preRecessionAvg);
    postRecession.add(sortedData.get(i).postRecessionAvg);
    sortedNames.add(sortedData.get(i).marqueName);
  }
  slopegraph = new Graph("Top 10 Marques", preRecession, postRecession, sortedNames, slopeMax, slopeMin, borderW, borderH, sortedColors);
}

/*
  This method creates the graphs that show the total number
  of cars registered for each year between 2002 and 2015
*/
void createYearlyTotalGraph()
{
  //Initialising the max and min variables
  int minYearly = minInit;
  int maxYearly = maxInit;
  
  //Initialising the yearlyTotals ArrayList with default
  //values
  for(int i=0; i<marqueData.get(0).regNums.size(); i++)
  {
      yearlyTotals.add(0);
  }
  
  /*
    This nested loop adds each marque's yearly data
    to a position correlating to that year in the
    yearlyTotals ArrayList
  */
  for(int i=0; i<marqueData.size(); i++)
  {
    int total = 0;
    for(int j=0; j<marqueData.get(i).regNums.size(); j++)
    {
      total = yearlyTotals.get(j);
      total += marqueData.get(i).regNums.get(j);
      yearlyTotals.set(j, total);
    } 
  }
  
  /*
    Getting the max and min values in the ArrayList that
    will be used to scale the graph correctly
  */
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
  
  //Calling one of the constructors in the Graph class
  yearTotalGraph = new Graph("Yearly Totals", yearlyTotals, marqueData.get(0).years, maxYearly, minYearly, borderW, borderH, yearColors);
}

void createMarqueGraphs()
{
  marqueGraph = new ArrayList<Graph>();
  /*
    This for loop creates a graph for every marque that
    will show the trend in registration numbers between
    2002 and 2015 for that marque
  */
  for(int i=0; i<marqueData.size(); i++)
  {
    int maxTotal = maxInit;
    int minTotal = minInit;
    //Max and min values for graph scaling
    if(marqueData.get(i).max > maxTotal)
    {
      maxTotal = marqueData.get(i).max;
    }
    
    if(marqueData.get(i).min < minTotal)
    {
      minTotal = marqueData.get(i).min;
    }
    //Adding the created graph to the ArrayList of graphs
    marqueGraph.add(new Graph(marqueData.get(i).marqueName, marqueData.get(i).regNums, marqueData.get(0).years, maxTotal, minTotal, borderW, borderH, marqueData.get(i).c));
  }
}

/*
  This method creates a graph showing all the average registration
  numbers for every marque for the years 2002 to 2015. It creates
  both an alphabetical graph and a graph sorted by each average value
*/
void createAvgsGraph()
{
  //Creating ArrayLists to allow the graphs to be created properly
  ArrayList<String> marqueNames = new ArrayList<String>();
  ArrayList<Integer> marqueAvgs = new ArrayList<Integer>();
  ArrayList<Integer> sortedAvgs = new ArrayList<Integer>();
  int maxAvg = maxInit;
  int minAvg = minInit;
  
  //Finding the maximum and minimum average values across all marques
  for(int i=0; i<marqueData.size(); i++)
  {
    if(marqueData.get(i).avg > maxAvg)
    {
      maxAvg = marqueData.get(i).avg;
    }
    
    if(marqueData.get(i).avg < minAvg)
    {
      minAvg = marqueData.get(i).avg;
    }
  }
  
  //Filling the ArrayLists with the data from the two differently
  //sorted ArrayLists
  for(MarqueData data: marqueData)
  {
    marqueNames.add(data.marqueName);
    marqueAvgs.add(data.avg);
  }
  //sortedNames.clear();
  sortedNames = new ArrayList<String>();
  for(MarqueData data: sortedData)
  {
    sortedNames.add(data.marqueName);
    sortedAvgs.add(data.avg);
  }
  
  //Creating the sorted and alphabetical graphs
  marqueTotalGraph = new Graph("Alphabetical Marque Averages", marqueAvgs, marqueNames, maxAvg, minAvg, borderW, borderH, marqueColors);
  sortedTotalGraph = new Graph("Sorted Marque Averages", sortedAvgs, sortedNames, maxAvg, minAvg, borderW, borderH, sortedColors);
}

/*
  Quicksort is a divide-and-conquer style algorithm. It works using
  recursion.
  
  It starts by setting an index variable equal to the value returned
  by the partition method. The explanation for the partition method 
  is below.
*/
void quicksort(ArrayList<MarqueData> data, int left, int right)
{
  //Using the partition method to find which index to use when
  //dividing the elements of the ArrayList
  int index = partition(data, left, right);
 
  if(left < index-1)
  {
    //This recursive call uses the the position one
    //less than that of the partition index as the
    //right position of the divided ArrayList
    quicksort(data, left, index-1);
  }
  
  
  if(index < right)
  {
    //This recursive call uses the partition index as
    //the left postition of the divided ArrayList
    quicksort(data, index, right);
  }
}

/*
  The partition method works using a pivot value. This pivot value is set
  as the value of the 'total' field of the MarqueData object found halfway 
  between the given left and right indexes.
  
  The method loops while the left index is less than the right index.
  
  The first stage of the loop checks if the 'total' value found at the left
  index position is less than the pivot value. If it is less than the pivot
  value, the position of the left index is incremented one place to the right.
  Once the value is greater than the pivot value, the loop continues.
  
  The second stage of the loop is similar to the first, except the right value
  is decremented on place to the left if the value is greater than the pivot.
  
  The third stage of the loop checks if the left index is less than or equal to
  that of the right index. If it is, then a swap is performed between the object
  found at the left index and the object found at the right index. The position of
  the left and right indexes are incremented and decremented respectively.
  
  Once the left index is greater than the right index, the method stops looping,
  and returns the current value of the left index.
*/

int partition(ArrayList<MarqueData> data, int left, int right)
{
  //Setting two index variables equal to the position 
  //of the left and right values of the array
  int i = left;
  int j = right;
  
  //Creating an temporary object used for swapping positions
  //in the ArrayList
  MarqueData temp;
  
  //The pivot is the average value found at the index that
  //is halfway between the left and right indexes
  int pivot = data.get((left+right)/2).avg;
  
  //While the left index variable is less than or equal
  //to the value of the right index variable
  while(i <= j)
  {
    //While the average value at index i is less than the
    //average value at the pivot index
    while(data.get(i).avg < pivot)
    {
      //Increment the position of the left index
      i++;
    }
    
    //While the average value at index j is greater than the
    //value at the pivot index
    while(data.get(j).avg > pivot)
    {
      //Decrement the position of the roght index
      j--;
    }
    
    //If the left index is less than the right index
    if(i <= j)
    {
      //Set the temporary object equal to the object found
      //at index i
      temp = data.get(i);
      //Set the i-th object to be equal to the j-th object
      data.set(i, data.get(j));
      //Set the j-th object to be equal to the i-th object
      data.set(j, temp);
      //Increment the position of the left index
      i++;
      //Decrement the position of the right index
      j--;
    }
  }
  
  //Return the position of the left index
  return i;
}