//Audio
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

//Colour of background
color Red1 = 178;
color Green1 = 216; 
color Blue1 = 264;
color Red2 = 4;
color Green2 = 15; 
color Blue2 = 74;
float colourincrement = 1;

//Loading Image
PImage img1, img2, img3;

//The fade thing under Eve
static final int NUM = 0100, NEWEST = NUM - 1;
final int[] x = new int[NUM], y = new int[NUM];

//Mouse over
boolean overBox = false;
boolean locked = false;
boolean playing = false;

void setup()
{
  minim = new Minim(this);
  player = minim.loadFile("Walle.mp3", 2048);
  player.play();
  
  size(1200, 700);
  background(Red1, Green1, Blue1);
  
  frameRate(30);
  smooth();
  noCursor();
  noStroke();
  
  for ( int i = NUM; i-- != 0; x[i] = mouseX, y[i] = mouseY);
  
  image();
}

void draw() 
{
  backgroundFade();
  
  image(img3, 480, -10, 700, 400);
  walle();
  eve();
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
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}