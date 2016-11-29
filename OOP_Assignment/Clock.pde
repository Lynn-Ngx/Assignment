class Clock 
{
  int h, m, s; //variable for time
  Clock() 
  {
  }
  
  void getTime() 
  {
    h = hour();
    m = minute();
    s = second();
  }
}