class Graph
{
  //Creating fields needed for drawing a graph
  Axis axis;
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
  color[] carray;
  String title;
  
  Graph()
  {
    this("", 0, 0, 0, 0, 0);
  }
  
  Graph(String title, int dataSize, int max, int min, float borderW, float borderH)
  {
    this.title = title;
    this.borderW = borderW; 
    this.borderH = borderH;
    this.max = max;
    this.min = min;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (dataSize);
  }
  
  Graph(String title, ArrayList<Integer> data, ArrayList<String> names, int max, int min, float borderW, float borderH, color c)
  {
    this(title, data.size(), max, min, borderW, borderH);
    this.data = new ArrayList<Integer>();
    this.names = new ArrayList<String>();
    this.data.addAll(data);
    this.names.addAll(names);
    this.c = c;
  }
  
  //Constructor recieves the data, the value to map the data against, the maximum and minimum values for scaling the graph,
  //the border values for the graph and the colour to use for the trend lines
  Graph(String title, ArrayList<Integer> data, ArrayList<String> names, int max, int min, float borderW, float borderH, color[] carray)
  {
    this(title, data.size(), max, min, borderW, borderH);
    this.data = new ArrayList<Integer>();
    this.names = new ArrayList<String>();
    this.data.addAll(data);
    this.names.addAll(names);
    this.carray = carray;
  }
  
  Graph(String title, ArrayList<MarqueData> data, int max, int min, float borderW, float borderH, color[] carray)
  {
    this(title, data.size(), max, min, borderW, borderH);
    this.mData = new ArrayList<MarqueData>();
    this.mData.addAll(data);
    this.carray = carray;
  }
  
  //Method to draw a bar chart using the data input
  void drawBarChart()
  {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    stroke(255);
    //For each element of data
    for(int i=0; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the bar relevant to the graph width and height
      float x = map(i, 0, data.size(), borderW, borderW+graphW);
      float y = map(data.get(i), min, max, height-borderH, (height-borderH) - graphH);
      
      fill(carray[i]);
      //Draw the bar
      rect(x, y, rectWidth, (height-borderH)-y);
    }//end for 
    
    
    //Create a new axis for the bar chart
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the bar chart
    axis.drawAxisLines();
    axis.drawBarXTicks();
    axis.drawYTicks();
    
  }
  
  void drawTrendLine()
  {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    //There is one less line than there is data values when drawing a trend line graph
    rectWidth = graphW/ (float)(data.size()-1);
    //Set the colour for the line
    
    //For each data value
    for(int i=1; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the line relevant to the graph width and height
      float x1 = map(i-1, 0, data.size()-1, borderW, borderW+graphW);
      float y1 = map(data.get(i-1), min, max, height-borderH, (height-borderH) - graphH);
      float x2 = map(i, 0, data.size()-1, borderW, borderW+graphW);
      float y2 = map(data.get(i), min, max, height-borderH, (height-borderH) - graphH);
      
      stroke(c);
      //Draw the line from the element before to the current element
      line(x1, y1, x2, y2);
      
      if(mouseX >= x1 && mouseX <= x2)
      {
        textAlign(LEFT, CENTER);
        stroke(211, 255, 255, 50);
        fill(211, 255, 255, 50);
        rect(mouseX+10, y1, 90, 30);
        stroke(255, 0, 0);
        fill(255, 0, 0);
        line(mouseX, borderH, mouseX, height - borderH);
        ellipse(x1, y1, 10, 10);
        fill(200);
        textSize(9);
        text("Year: " + names.get(i-1), mouseX+12, y1+10);
        text("Sold: " + data.get(i-1), mouseX+12, y1+20);
      }//end if
    }//end for
    
    
    //Create a new axis for the trend line graph
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the trend line graph
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
    
  }
  
  void drawSlopeGraph()
  {
    int numYearsPre = 3;
    int numYearsPost = 7;
    float x1 = map(width*0.25f, 0, width, borderW, borderW+graphW);
    float x2 = map(width-(width*0.25f), 0, width, borderW, borderW+graphW);
    float tWidth = 50;
    axis = new Axis();

    axis.drawSlopeAxis();
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    textSize(8);
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
      
      float y1 = map(preRecessionAvg, min, max, height-borderH, (height-borderH) - graphH);
      float y2 = map(postRecessionAvg, min, max, height-borderH, (height-borderH) - graphH);
      
      stroke(carray[i]);
      fill(carray[i]);
      text(mData.get(i).marqueName + " : " + preRecessionAvg, x1-tWidth, y1);
      if((mData.get(i).marqueName).equals("RENAULT"))
      {
        text(mData.get(i).marqueName + " : " + postRecessionAvg, x2+(tWidth*2.2f), y2);
      }
      else
      {
        text(mData.get(i).marqueName + " : " + postRecessionAvg, x2+tWidth, y2);
      }
      
      line(x1, y1, x2, y2);
    }
  }
}