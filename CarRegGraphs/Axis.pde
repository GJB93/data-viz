class Axis
{
  //Creating fields necessary for creating the axis of a graph
  ArrayList<Integer> yText;
  ArrayList<String> xText;
  int max;
  int min;
  float borderW; 
  float borderH;
  float graphW;
  float graphH;
  float tickW;
  float textIntW;
  float textIntH;
  int verticalIncrement;
  float horizontalIncrement;
  int dataRange;
  float numberInc;
  float tickIncrement;
  
  //Constructor for the Axis class
  Axis(ArrayList<Integer> y, ArrayList<String> x, int mx, int mn, float bW, float bH, float rW)
  {
    //Initialise the yText and xText ArrayLists
    yText = new ArrayList<Integer>();
    xText = new ArrayList<String>();
    
    //Copy the data entered to the constructor into the class' ArrayLists
    yText.addAll(y);
    xText.addAll(x);
    
    //Set the max and min values
    max = mx;
    min = mn;
    
    //Set the values for drawing the graph
    borderW = bW; 
    borderH = bH;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    tickW = borderW*0.1;
    textIntW = borderW*0.7;
    textIntH = borderH*0.2;
    verticalIncrement = 10;
    horizontalIncrement = rW;
    dataRange = max-min;
    numberInc = max/ verticalIncrement;
    tickIncrement = graphH/ verticalIncrement;
  }
  
  void drawAxis()
  {
    drawAxisLines();
    drawXTicks();
    drawYTicks();
  }
  
  //Method to draw the vertical and horizontal axis lines
  void drawAxisLines()
  {
    stroke(255);
    line(borderW, (height-borderH) - graphH, borderW, height-borderH);
    line(borderW, (height-borderH), borderW+graphW, height-borderH);
  }
  
  //Method to draw the ticks for the X axis
  void drawXTicks()
  {
    textSize(10);
    textAlign(LEFT, CENTER);
    for(int i=0; i<xText.size(); i++)
    {
      //Draw the tick lines
      line(borderW+(horizontalIncrement*i), (height-borderH)+tickW, borderW+(horizontalIncrement*i), height-borderH);
      
      //Push the current transformation matrix to the stack (i.e, drawing from 0,0)
      pushMatrix();
      //Translate the origin to the point to write the text for the x axis
      translate(borderW+(i*horizontalIncrement), (height-borderH)+textIntW);
      //Rotate the text 90 degrees
      rotate(-PI/2);
      fill(255);
      //Write the rotated text underneath the x axis ticks
      text((xText.get(i)).substring(0,4), 0, 0);
      
      //Pop the transformation matrix off the stack
      popMatrix();
    }//end for
  }
  
  //Method to draw the ticks for the Y axis
  void drawYTicks()
  {
    //Align the text appropriately
    textAlign(RIGHT, CENTER);
    
    //For each tick increment, draw a tick and the registration numbers scaled between the max and minimum value
    for(float i=0; i<= verticalIncrement; i++)
    {
      line(width-borderW, (height-borderH)-(tickIncrement*i), borderW-tickW, (height-borderH)-(tickIncrement*i));
      text(int((numberInc*i)+min), borderW-textIntH, (height-borderH)-(tickIncrement*i));
    }//end for
  }
}