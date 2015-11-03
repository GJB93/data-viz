void setup()
{
  size(500, 500);
  loadData();
  calculateMarqueTotals();
  topMarque = marques.get(topInd);
  bottomMarque = marques.get(botInd);
}//end setup()

//Declare an ArrayList to hold each array of integer values
ArrayList<MarqueData> data = new ArrayList<MarqueData>();

//Declare an ArrayList of strings to hold the Marque of each car
ArrayList<String> marques = new ArrayList<String>();
ArrayList<Integer> marqueTotal = new ArrayList<Integer>();
ArrayList<Float> marqueAvg = new ArrayList<Float>();

//Initialising a string with the name of the dataset file
String filename = "carData20062015.csv";

//Variables needed for calculations
int yearMax, yearMin;
int totalOverall = 0;
float overallAverage = 0;
int topInd, botInd;
String topMarque, bottomMarque;


//Variables for maximum and minimum values, as well as initial values for these variables
int maxInit=Integer.MIN_VALUE, minInit=Integer.MAX_VALUE;
int maxTotal = maxInit, minTotal = minInit;

void draw()
{
  drawBarChart(marqueTotal, marques, minTotal, maxTotal);
  text("Top marque is " + topMarque + ", bottom marque is " + bottomMarque, width/2, 20);
}//end draw()

//Method to calculate marque totals, and to find the average, max and min values
void calculateMarqueTotals()
{
  int m = 0;
  //For each integer arraylist
  for(ArrayList<Integer> values: data.getYearRegNums())
  {
    //Reset total to zero
    int total = 0;
    
    //For each value
    for(int v:values)
    {
      //Add to the total marque value
      total += v;
    }//end for
    
    //Add the total to the marqueTotal array
    marqueTotal.add(total);
    
    getMaxInd(total, maxTotal, m);
    getMinInd(total, minTotal, m);
    
    maxTotal = getMax(total, maxTotal);
    minTotal = getMin(total, minTotal);
    
    m++;
    println(m + " " + maxTotal);
  }
}//end calculateYearlyValues()

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
void getMaxInd(int num, int currMax, int m)
{
  int temp = m;
  if(num > currMax)
  {
     topInd = temp;
  }//end if
}//end getMaxInd()

//Method for checking the min value
void getMinInd(int num, int currMin, int m)
{
  if(num < currMin)
  {
    botInd = m;
  }//end if
}//end getMinInd()

//Method to draw the axis for the trend and bar graphs
void drawAxis(ArrayList<Integer> d, ArrayList<String> text, float w, int min, int max)
{
  stroke(255);
  fill(255);
  
  //Setting variables for scaling and drawing the axis
  float borderW = width*0.1f; 
  float borderH = height*0.1f;
  float graphW = width - (borderW*2.0f);
  float graphH = height - (borderH*2.0f);
  float tickW = borderW*0.1;
  float textIntW = borderW*0.5;
  
  //Drawing the axis lines
  line(borderW, (height-borderH) - graphH, borderW, height-borderH);
  line(borderW, (height-borderH), borderW+graphW, height-borderH);
  
  //Aligning and sizing the text for years
  textSize(10);
  
  //For every element, draw a tick and the related year
  for(int i=0; i<d.size(); i++)
  {
    line(borderW+(w*i), (height-borderH)+tickW, borderW+(w*i), height-borderH);
    translate(borderW+(i*w+(w/2)-1), (height-borderH)+textIntW);
    rotate(-PI/2);
    fill(255);
    text((text.get(i)).substring(0,3), 0, 0);
    rotate(PI/2);
    translate(-(borderW+(i*w+(w/2)-1)), -((height-borderH)+textIntW));
  }//end for
  
  //Variables relating to drawing the ticks on the vertical axis
  //as well as the values to allocate to each tick
  float textIntH = borderH*0.2;
  float verticalIncrement = 15;
  int dataRange = max-min;
  int numberInc = int(dataRange/ verticalIncrement);
  float tickIncrement = graphH/ verticalIncrement;
  
  //Aligning the text properly for the vertical axis
  textAlign(RIGHT, CENTER);
  
  //For each tick increment, draw a tick and the rainfall value
  for(float i=0; i<= verticalIncrement; i++)
  {
    line(borderW, (height-borderH)-(tickIncrement*i), borderW-tickW, (height-borderH)-(tickIncrement*i));
    text(int((numberInc*i)+min), borderW-textIntH, (height-borderH)-(tickIncrement*i));
  }//end for
  
  //Reset the text alignment
  textAlign(CENTER);
}//end drawAxis

//Method to draw a bar chart for the given data
void drawBarChart(ArrayList<Integer> d, ArrayList<String> text, int min, int max)
{
  //Variables relating to scaling the graph and bar lengths
  float borderW = width*0.1f; 
  float borderH = height*0.1f;
  float graphW = width - (borderW*2.0f);
  float graphH = height - (borderH*2.0f);
  float rectWidth = graphW/ (float) (d.size());
  
  //Refresh the screen
  background(0);
  stroke(255);
  fill(127);
  
  //For each element of data
  for(int i=0; i<d.size(); i++)
  {
    //Use the map method to determine the scale of the bar relevant to the graph width and height
    float x = map(i, 0, d.size(), borderW, borderW+graphW);
    float y = map(d.get(i), min, max, height-borderH, (height-borderH) - graphH);
    
    //Draw the bar
    rect(x, y, rectWidth, (height-borderH)-y);
  }//end for 
  
  //Draw the axis for the bar chart
  drawAxis(d, text, rectWidth, min, max);
}//end drawBarChart()

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
    String temp;
    
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
