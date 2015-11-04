class Axis
{
  ArrayList<Integer> yText;
  ArrayList<String> xText;
  int min;
  int max;
  float borderW; 
  float borderH;
  float graphW;
  float graphH;
  float tickW;
  float textIntW;
  float textIntH;
  int verticalIncrement;
  int dataRange;
  float numberInc;
  float tickIncrement;
  
  Axis(ArrayList<Integer> y, ArrayList<String> x, int mx, int mn)
  {
    yText = new ArrayList<Integer>();
    xText = new ArrayList<String>();
    yText.addAll(y);
    xText.addAll(x);
    min = mn;
    max = mx;
    borderW = width*0.1f; 
    borderH = height*0.1f;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    tickW = borderW*0.1;
    textIntW = borderW*0.2;
    textIntH = borderH*0.2;
    verticalIncrement = 10;
    dataRange = max-min;
    numberInc = dataRange/ verticalIncrement;
    tickIncrement = graphH/ verticalIncrement;
  }
  
  //Drawing the axis lines
  line(borderW, (height-borderH) - graphH, borderW, height-borderH);
  line(borderW, (height-borderH), borderW+graphW, height-borderH);
  
  //Aligning and sizing the text for years
  textAlign(CENTER, CENTER);
  textSize(8);
  
  //If there is a lot of data, increment the amounts in 10's
  if(text.size() > months.size())
  {
    //For every ten elements, draw a tick and the related year
    for(int i=0; i<d.size(); i+=10)
    {
      line(borderW+(w*i), (height-borderH)+tickW, borderW+(w*i), height-borderH);
      text(text.get(i), borderW+(w*i), (height-borderH)+textIntW);
    }//end for
  }//end if
  else
  {
    //For every element, draw a tick and the related year
    for(int i=0; i<d.size(); i++)
    {
      line(borderW+(w*i), (height-borderH)+tickW, borderW+(w*i), height-borderH);
      text(text.get(i), borderW+(w*i), (height-borderH)+textIntW);
    }//end for
  }//end else
  
  //Variables relating to drawing the ticks on the vertical axis
  //as well as the values to allocate to each tick
  
  
  //Aligning the text properly for the vertical axis
  textAlign(RIGHT, CENTER);
  
  //For each tick increment, draw a tick and the rainfall value
  for(float i=0; i<= verticalIncrement; i++)
  {
    line(borderW, (height-borderH)-(tickIncrement*i), borderW-tickW, (height-borderH)-(tickIncrement*i));
    text((numberInc*i)+min, borderW-textIntH, (height-borderH)-(tickIncrement*i));
  }//end for
  
  //Reset the text alignment
  textAlign(CENTER);
}//end drawAxis
}