class Graph
{
  Axis axis;
  ArrayList<Integer> data;
  ArrayList<String> names;
  int max;
  int min;
  float borderW = width*0.1f; 
  float borderH;
  float graphW;
  float graphH;
  float rectWidth;
  color lineC;
  
  Graph(ArrayList<Integer> d, ArrayList<String> n, int mx, int mn, float bW, float bH, color c)
  {
    data = new ArrayList<Integer>();
    names = new ArrayList<String>();
    data.addAll(d);
    names.addAll(n);
    borderW = bW; 
    borderH = bH;
    max = mx;
    min = mn;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (data.size());
    lineC = c;
  }
  
  void drawBarChart()
  {
    //Refresh the screen
    stroke(255);
    fill(127);
    
    //For each element of data
    for(int i=0; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the bar relevant to the graph width and height
      float x = map(i, 0, data.size(), borderW, borderW+graphW);
      float y = map(data.get(i), min, max, height-borderH, (height-borderH) - graphH);
      
      //Draw the bar
      rect(x, y, rectWidth, (height-borderH)-y);
    }//end for 
    
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the bar chart
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
  }
  
  void drawTrendLine()
  {
    //There is one less line than there is data values
    rectWidth = graphW/ (float)(data.size()-1);
    
    //Refresh the screen
    stroke(lineC);
    fill(255);
    
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
    
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the trend line graph
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
  }
}