class Axis
{
  ArrayList<Integer> yText;
  String[] xText;
  int max;
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
  
  Axis(ArrayList<Integer> y, String[] x, int mx)
  {
    yText = new ArrayList<Integer>();
    xText = x;
    yText.addAll(y);
    max = mx;
    borderW = width*0.1f; 
    borderH = height*0.1f;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    tickW = borderW*0.1;
    textIntW = borderW*0.7;
    textIntH = borderH*0.2;
    verticalIncrement = 10;
    horizontalIncrement = graphW/ x.length;
    dataRange = max;
    numberInc = dataRange/ verticalIncrement;
    tickIncrement = graphH/ verticalIncrement;
    drawAxisLines();
    drawXTicks();
    drawYTicks();
  }
  
  void drawAxisLines()
  {
    line(borderW, (height-borderH) - graphH, borderW, height-borderH);
    line(borderW, (height-borderH), borderW+graphW, height-borderH);
  }
  
  void drawXTicks()
  {
    textSize(10);
    textAlign(LEFT, CENTER);
    for(int i=0; i<xText.length; i++)
    {
      line(borderW+(horizontalIncrement*i), (height-borderH)+tickW, borderW+(horizontalIncrement*i), height-borderH);
      translate(borderW+(i*horizontalIncrement), (height-borderH)+textIntW);
      rotate(-PI/2);
      fill(255);
      text(xText[i], 0, 0);
      rotate(PI/2);
      translate(-(borderW+(i*horizontalIncrement)), -((height-borderH)+textIntW));
    }//end for
  }
  
  void drawYTicks()
  {
    textAlign(RIGHT, CENTER);
    
    //For each tick increment, draw a tick and the rainfall value
    for(float i=0; i<= verticalIncrement; i++)
    {
      line(borderW, (height-borderH)-(tickIncrement*i), borderW-tickW, (height-borderH)-(tickIncrement*i));
      text(int(numberInc*i), borderW-textIntH, (height-borderH)-(tickIncrement*i));
    }//end for
  }
}