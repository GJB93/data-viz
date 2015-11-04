class Graph
{
  Axis axis;
  ArrayList<Integer> data;
  ArrayList<String> names;
  int max;
  float borderW = width*0.1f; 
  float borderH;
  float graphW;
  float graphH;
  float rectWidth;
  
  Graph(ArrayList<Integer> d, ArrayList<String> n, int mx, float bW, float bH)
  {
    data = new ArrayList<Integer>();
    names = new ArrayList<String>();
    data.addAll(d);
    names.addAll(n);
    borderW = bW; 
    borderH = bH;
    max = mx;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (data.size());
    axis = new Axis(data, names, max, borderW, borderH);
  }
  
  void drawBarChart()
  {
    //Refresh the screen
    background(0);
    stroke(255);
    fill(127);
    
    //For each element of data
    for(int i=0; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the bar relevant to the graph width and height
      float x = map(i, 0, data.size(), borderW, borderW+graphW);
      float y = map(data.get(i), 0, max, height-borderH, (height-borderH) - graphH);
      
      //Draw the bar
      rect(x, y, rectWidth, (height-borderH)-y);
    }//end for 
    
    //Draw the axis for the bar chart
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
  }
}