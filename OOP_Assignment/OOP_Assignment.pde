DigitalClock digitalClock;
ArrayList stars;
Star2 displayStar;

//Audio
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

int page = 0;
int frame = 0;
int loadingBack = 0;

int growth = 0;
float theta;

//Colour of background
color Red1 = 178;
color Green1 = 216; 
color Blue1 = 264;
color Red2 = 4;
color Green2 = 15; 
color Blue2 = 74;
float colourincrement = 1;

//Loading Image
PImage img1, img2, img3, img4, img5, img6;

//The fade thing under Eve
static final int NUM = 0100, NEWEST = NUM - 1;
final int[] x = new int[NUM], y = new int[NUM];

//Mouse over
boolean overBox = false; //walle voice
boolean overBox1 = false; //start box
boolean overBox2 = false; //back page 3
boolean overBox3 = false; //eve
boolean overBox4 = false; //walle
boolean locked = false;
boolean playing = false;

//Start Box
float bx = 300;
float by = 600; //position
float boxWidth = 500;
float boxHeight = 70;

//Back button
float bx1 = 20;
float by1 = 20;
float boxWidth1 = 180;
float boxHeight1 = 50;

//choose
float bw = 300;

void setup()
{
  minim = new Minim(this);
  player = minim.loadFile("Walle.mp3", 2048);
  player.play();
  
  size(1200, 700);
  background(Red1, Green1, Blue1);
  
  stars = new ArrayList();
  for(int i = 1; i <= 300; i++)
  {
    stars.add(new star());
  }
  
  digitalClock = new DigitalClock(150, 10, 190);
  
  frameRate(30);
  smooth();
  noStroke();
  
  for ( int i = NUM; i-- != 0; x[i] = mouseX, y[i] = mouseY);
  
  image();
}

void draw() 
{
 switch(page)
  {
    case 0:
      page1();
      println("1");
      break;
    case 1:
      page2();
      println("2");
      break;
    case 2:
      page3();
      println("3");
      break;
  }
}

void page1()
{
  page = 0;
  backgroundFade();
  for(int i = 0; i <= stars.size()-1; i++)
  {
    star starUse = (star) stars.get(i);
    starUse.display();
  }
  digitalClock.getTime();
  digitalClock.display();
 
  font();
  button();
  
  walle();
  image(img3, 480, -10, 700, 400);
  eve();
}

void page2()
{
  page = 1;
  background(Red1, Green1, Blue1);
  backgroundFade();
  for (int i =0; i < 5; i++)
  {
    Star2 s = new Star2 (random(width),random(height), 3.5, 7, int(random(4,6)));
    s.drawStar();
  }
  loading();
  plant();
  image(img4, 520, 440, 130, 130);
  eve();
}

void page3()
{
  cursor();
  page = 2;
  background(178, 216, 264);
  choose();
  back();
}

void font()
{
  fill(255, 0, 0);
  noStroke();
  ellipse(890, 480, 180, 180);
  
  PFont f = createFont("Impact", 150);
  String s = "W";
  String s2 = "L  L         E";
  fill(255);
  textFont(f);
  text(s, 100, 540);
  text(s2, 450, 540);
  ellipse(730, 480, 50, 50);
}

void backgroundFade()
{
  //Fade Background
  if (Red1 > Red2) 
  {
    Red1 -= colourincrement;
  }

  if (Green1 > Green2)
  {
    Green1 -= colourincrement;
  }
   
  if (Blue1 > Blue2)
  {
    Blue1 -= colourincrement;
  }
  
  background(Red1, Green1, Blue1);
}

void eve()
{
  //Eve
  image(img2, mouseX - 40, mouseY, 100, 100);
  
  //The fade thing under Eve
  noStroke();
  fill(0100 << 030);

  for (int i = 0; i != NEWEST;
  ellipse(x[i] = x[i + 1], y[i] = y[i + 1], i, i++) );
  ellipse(x[NEWEST] = mouseX, y[NEWEST] = mouseY + 120, NEWEST, NEWEST);
}

void walle()
{
  image(img1, 260, 410, 150, 150);
  
  // Test if the cursor is over the box 
  if (mouseX > 260 && mouseX < 460 && 
      mouseY > 310 && mouseY < 510) 
  {
    overBox = true;  
    if((!locked) && (playing == false)) 
    { 
      minim = new Minim(this);
      player = minim.loadFile("WalleVoice.mp3", 2048);
      player.play(); 
      playing = true;
    }
  }
  
  else if ((overBox == false) && (playing == true))
  {
    player.pause();
    playing = false;
  }
  else 
  {
     overBox = false;
  }
}

void image()
{
  // Images must be in the "data" directory to load correctly
  img1 = loadImage("Walle1.png");
  img2 = loadImage("Eve.png");
  img3 = loadImage("Rocket.png");
  img4 = loadImage("boot3.png");
  img5 = loadImage("eve2.png");
  img6 = loadImage("walle3.png");
}

void button()
{
  // Test if the cursor is over the box 
  if (mouseX > bx && mouseX < bx+boxWidth && 
      mouseY > by-boxHeight && mouseY < by+boxHeight)
  {
    overBox1 = true;  
    if(!locked) 
    { 
      stroke(160); 
      fill(150);
      overBox=false;
    } 
  } 
  
  else 
  {
    stroke(255);
    fill(255);
  }

  rect(bx, by, boxWidth, boxHeight);
  
  PFont f = createFont("Impact", 50);
  String s3 = "START";
  fill(0);
  textFont(f);
  text(s3, bx + 175, by + 55);
}

void loading()
{   
  loadingBack = (int((frameCount - frame %301) / 3 ));
  PFont f = createFont("Impact", 60);
  textFont(f);
  fill(255);
  text ("LOADING " + int((frameCount - frame %301) / 3 ) + "%", 352, 180);
  rect(350, 200, 460, 50);
  fill(0, 0, 0, 60);
  float fillX = ((frameCount - frame %301) / 3 * 4.5);
  rect(800, 205, fillX-450, 40);
    
  if (loadingBack >= 100)
  {
    page = 2;
    loadingBack = 0;
  }   
}

void plant()
{
  strokeWeight(2);
  stroke(0, 255, 0);
  growth ++;
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = (growth / (float) width) * 90f;
  // Convert it to radians
  theta = radians(a);
  pushMatrix();
  // Start the tree from the bottom of the screen
  translate((width/2) - 50,height - 150);
  // Draw a line 120 pixels
  line(0,0,0,-120);
  // Move to the end of that line
  translate(0,-120);
  // Start the recursive branching!
  branch(50);
  popMatrix();
}

void branch(float h) 
{
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) 
  {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

void back()
{
  pushMatrix();
  //overBox2 = false; 
  strokeWeight(1);
  PFont f = createFont("Impact", 30);
  PFont f2 = createFont("Impact", 70);
  String s = "BACK";
  String s2 = "Choose a character";
  //fill(255);
  textFont(f);
  fill(0);
  text(s, 90, 55);
  textFont(f2);
  fill(255);
  text(s2, 300, 200);
  popMatrix();
  
   // Test if the cursor is over the box 
  if (mouseX > bx1 && mouseX < bx1+boxWidth1 && 
      mouseY > by1 && mouseY < by1+boxHeight1)
  {
    overBox2 = true;  
    if(!locked) 
    { 
       stroke(9, 18, 72); 
       fill(33, 127, 121, 100);
       overBox2 = false;
    } 
  } 
  
  else
  {
     stroke(255, 255, 255, 100);
     fill(255, 255, 255, 150);
  }
  
  rect(20, 20, 180, 50);
  noStroke();
  triangle(30, 45, 65, 25, 65, 65);
}

void choose()
{
  image(img5, 230, 320, 250, 250);
  image(img6, 675, 320, 250, 250);
  
  // Test if the cursor is over the box 
  if (mouseX > 200 && mouseX < 200+bw && 
      mouseY > 300 && mouseY < 300+bw)
  {
    overBox3 = true;  
    if(!locked) 
    { 
      stroke(255);
      strokeWeight(10);
      noFill();
      rect(200, 300, 300, 300, 15);
    } 
  } 
  
  if (mouseX > 650 && mouseX < 650+bw && 
      mouseY > 300 && mouseY < 300+bw)
  {
    overBox4 = true;  
    if(!locked) 
    { 
      stroke(255);
      strokeWeight(10);
      noFill();
      rect(650, 300, 300, 300, 15);
      stroke(255);
      strokeWeight(1);
      rect(200, 300, 300, 300, 15);
    } 
  } 
  
  else 
  {
    stroke(255);
    strokeWeight(1);
    noFill();
    rect(200, 300, 300, 300, 15);
    //overBox3 = false;
    rect(650, 300, 300, 300, 15);
    overBox4 = false;
  }
}

void mousePressed() 
{
  if(overBox1)
  { 
    locked = true;
    frame = frameCount;
    page = 1;
    overBox1 = false;
  } 

 if(overBox2)
  { 
    locked = true; 
    page = 0;
  } 
  
   else 
  {
    locked = false;
  }
}
  
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}