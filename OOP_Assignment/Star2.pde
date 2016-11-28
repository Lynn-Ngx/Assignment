class Star2
{
  float fade = 225;
  float px;
  float py;
  float l1;
  float l2;
  int npoints;

  
  Star2(float px, float py, float l1 , float l2, int npoints) //l1 inner radius, l2 outer radius
  {
    this.px = px;
    this.py = py;
    this.l1 = l1;
    this.l2 = l2;
    this.npoints = npoints;
  }
  
  void drawStar()
  {
    if(frameCount % 1 == 0)
    {    
      stroke(fade);
      
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      //inner radius
      fade --;
      float sx = px + cos(a) * l2;
      float sy = py + sin(a) * l2;
      vertex(sx, sy);
      //outer radius
      sx = px + cos(a+halfAngle) * l1;
      sy = py + sin(a+halfAngle) * l1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  }
}