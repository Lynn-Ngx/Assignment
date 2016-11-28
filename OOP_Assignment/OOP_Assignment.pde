DigitalClock digitalClock;
ArrayList stars;

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
PImage img1, img2, img3, img4;

//The fade thing under Eve
static final int NUM = 0100, NEWEST = NUM - 1;
final int[] x = new int[NUM], y = new int[NUM];

//Mouse over
boolean overBox = false; //walle voice
boolean overBox1 = false; //start box
boolean locked = false;
boolean playing = false;

//Start Box
float bx = 300;
float by = 600; //position
float boxWidth = 500;
float boxHeight = 70;

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
  loading();
  plant();
  image(img4, 520, 440, 130, 130);
  eve();
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

void mousePressed() 
{
  if(overBox1)
  { 
    locked = true;
    frame = frameCount;
    page = 1;
    overBox1 = false;
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