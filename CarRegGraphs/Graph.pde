class Graph
{
  //Creating fields needed for drawing a graph
  //Axis axis;
  ArrayList<Integer> data;
  ArrayList<String> names;
  ArrayList<MarqueData> mData;
  int max;
  int min;
  float borderW = width*0.1f; 
  float borderH;
  float graphW;
  float graphH;
  float rectWidth;
  color c;
  
  Graph()
  {
    this(new ArrayList<Integer>(), new ArrayList<String>(), 0, 0, 0, 0, 0);
  }
  
  //Constructor recieves the data, the value to map the data against, the maximum and minimum values for scaling the graph,
  //the border values for the graph and the colour to use for the trend lines
  Graph(ArrayList<Integer> data, ArrayList<String> names, int max, int min, float borderW, float borderH, color c)
  {
    this.data = new ArrayList<Integer>();
    this.names = new ArrayList<String>();
    this.data.addAll(data);
    this.names.addAll(names);
    this.borderW = borderW; 
    this.borderH = borderH;
    this.max = max;
    this.min = min;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (data.size());
    this.c = c;
  }
  
  Graph(ArrayList<MarqueData> data, int max, int min, float borderW, float borderH, color c)
  {
    this.mData = new ArrayList<MarqueData>();
    this.mData.addAll(data);
    this.borderW = borderW; 
    this.borderH = borderH;
    this.max = max;
    this.min = min;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (data.size());
    this.c = c;
  }
  
  //Method to draw a bar chart using the data input
  void drawBarChart()
  {
    stroke(255);
    fill(c);
    //For each element of data
    for(int i=0; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the bar relevant to the graph width and height
      float x = map(i, 0, data.size(), borderW, borderW+graphW);
      float y = map(data.get(i), min, max, height-borderH, (height-borderH) - graphH);
      
      //Draw the bar
      rect(x, y, rectWidth, (height-borderH)-y);
    }//end for 
    
    /*
    //Create a new axis for the bar chart
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the bar chart
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
    */
  }
  
  void drawTrendLine()
  {
    //There is one less line than there is data values when drawing a trend line graph
    rectWidth = graphW/ (float)(data.size()-1);
    
    //Set the colour for the line
    stroke(c);
    
    //For each data value
    for(int i=1; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the line relevant to the graph width and height
      float x1 = map(i-1, 0, data.size()-1, borderW, borderW+graphW);
      float y1 = map(data.get(i-1), min, max, height-borderH, (height-borderH) - graphH);
      float x2 = map(i, 0, data.size()-1, borderW, borderW+graphW);
      float y2 = map(data.get(i), min, max, height-borderH, (height-borderH) - graphH);
      
      //Draw the line from the element before to the current element
      line(x1, y1, x2, y2);
    }//end for
    
    /*
    //Create a new axis for the trend line graph
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the trend line graph
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
    */
  }
  
  void drawSlopeGraph()
  {
    stroke(c);
    int numYearsPre = 3;
    int numYearsPost = 7;
    
    for(int i=mData.size()-1; i>mData.size()-11; i--)
    {
      int preRecessionTotal = 0;
      int postRecessionTotal = 0;
      for(int j=0; j<3; j++)
      {
        preRecessionTotal += mData.get(i).regNums.get(j);
      }
      int preRecessionAvg = preRecessionTotal/numYearsPre;
      for(int j=numYearsPre; j<mData.get(0).regNums.size(); j++)
      {
        postRecessionTotal += mData.get(i).regNums.get(j);
      }
      int postRecessionAvg = postRecessionTotal/numYearsPost;
      
      float x1 = map(width*0.25f, 0, width, borderW, borderW+graphW);
      float y1 = map(preRecessionAvg, 3000, 25000, height-borderH, (height-borderH) - graphH);
      float x2 = map(width-(width*0.25f), 0, width, borderW, borderW+graphW);
      float y2 = map(postRecessionAvg, 3000, 25000, height-borderH, (height-borderH) - graphH);
      textAlign(LEFT, CENTER);
      textSize(8);
      line(x1, height-borderH, x1, (height-borderH) - graphH);
      line(x2, height-borderH, x2, (height-borderH) - graphH);
      text(mData.get(i).marqueName, x1-70, y1);
      text(mData.get(i).marqueName, x2+10, y2);
      line(x1, y1, x2, y2);
    }
  }
}