class Axis
{
  //Creating fields necessary for creating the axis of a graph
  ArrayList<Integer> yText;
  ArrayList<String> xText;
  ArrayList<MarqueData> mData;
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
  
  Axis()
  {
    this(0, width, width*0.1f, height*0.1f, 0);
  }
  
  Axis(int max, int min, float borderW, float borderH, float rectW)
  {
    //Set the max and min values
    this.max = max;
    this.min = min;
    
    //Set the values for drawing the graph
    this.borderW = borderW; 
    this.borderH = borderH;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    tickW = borderW*0.1;
    textIntW = borderW*0.5;
    textIntH = borderH*0.2;
    verticalIncrement = 10;
    horizontalIncrement = rectW;
    dataRange = max-min;
    numberInc = max/ verticalIncrement;
    tickIncrement = graphH/ verticalIncrement;
  }
  
  //Constructor for the Axis class
  Axis(ArrayList<Integer> yText, ArrayList<String> xText, int max, int min, float borderW, float borderH, float rectW)
  {
    this(max, min, borderW, borderH, rectW);
    //Initialise the yText and xText ArrayLists
    this.yText = new ArrayList<Integer>();
    this.xText = new ArrayList<String>();
    
    //Copy the data entered to the constructor into the class' ArrayLists
    this.yText.addAll(yText);
    this.xText.addAll(xText);
  }
  
  Axis(ArrayList<MarqueData> data, int max, int min, float borderW, float borderH, float rectW)
  {
    this(max, min, borderW, borderH, rectW);
    this.mData = new ArrayList<MarqueData>();
    this.mData.addAll(data);
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
      if((xText.get(i)).length() > 3)
      {
        text((xText.get(i)).substring(0,4), 0, 0);
      }
      else
      {
        text((xText.get(i)).substring(0,3), 0, 0);
      }
      
      //Pop the transformation matrix off the stack
      popMatrix();
    }//end for
  }
  
  void drawBarXTicks()
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
      if((xText.get(i)).length() > 3)
      {
        text((xText.get(i)).substring(0,4), 0, horizontalIncrement*0.5);
      }
      else
      {
        text((xText.get(i)).substring(0,3), 0, horizontalIncrement*0.5);
      }
      
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
  
  void drawSlopeAxis()
  {
    float x1 = map(width*0.25f, 0, width, borderW, borderW+graphW);
    float x2 = map(width-(width*0.25f), 0, width, borderW, borderW+graphW);
    textAlign(CENTER, CENTER);
    textSize(11);
    fill(255);
    stroke(255);
    line(x1, height-borderH, x1, (height-borderH) - graphH);
    line(x2, height-borderH, x2, (height-borderH) - graphH);
    text("06-08 Average Sold", x1, borderH*0.7f);
    text("09-15 Average Sold", x2, borderH*0.7f);
  }
}