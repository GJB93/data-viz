class Axis
{
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
  
  Axis(ArrayList<Integer> y, ArrayList<String> x, int mx, int mn, float bW, float bH, float rW)
  {
    yText = new ArrayList<Integer>();
    xText = new ArrayList<String>();
    yText.addAll(y);
    xText.addAll(x);
    max = mx;
    min = mn;
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
  
  void drawAxisLines()
  {
    stroke(255);
    line(borderW, (height-borderH) - graphH, borderW, height-borderH);
    line(borderW, (height-borderH), borderW+graphW, height-borderH);
  }
  
  void drawXTicks()
  {
    textSize(10);
    textAlign(LEFT, CENTER);
    for(int i=0; i<xText.size(); i++)
    {
      line(borderW+(horizontalIncrement*i), (height-borderH)+tickW, borderW+(horizontalIncrement*i), height-borderH);
      translate(borderW+(i*horizontalIncrement), (height-borderH)+textIntW);
      rotate(-PI/2);
      fill(255);
      text((xText.get(i)).substring(0,4), 0, 0);
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
      text(int((numberInc*i)+min), borderW-textIntH, (height-borderH)-(tickIncrement*i));
    }//end for
  }
}