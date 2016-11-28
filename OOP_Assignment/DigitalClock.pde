class DigitalClock extends Clock
{
  int fontSize;
  float x, y;
  
  DigitalClock(int _fontSize, float _x, float _y) 
  {
    fontSize = _fontSize;
    x = _x;
    y = _y;
  }
  
  void getTime() 
  {
    super.getTime();
  }
  
  void display() 
  {
    fill(0, 0, 0, 60);
    textSize(fontSize);
    text (h + ":" + nf(m, 2) + ":" + nf(s, 2), x, y);
  } 
}