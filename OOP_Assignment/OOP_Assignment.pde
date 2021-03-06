//initialising class
DigitalClock digitalClock; 
ArrayList stars;
Star2 displayStar;

//Importing audio
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

//Variables for the loading page
int page = 0; 
int frame = 0;
int loadingBack = 0;
float fillX = 0;

//Variable for the plant
int growth = 0;
float theta;

//Colour of background
//The initial colour
color Red1 = 178;
color Green1 = 216; 
color Blue1 = 264;
//Colour after fade
color Red2 = 4;
color Green2 = 15; 
color Blue2 = 74;
//The colour incrementing
float colourincrement = 1;

//Loading Image
PImage img1, img2, img3, img4, img5, img6;

//The variable for the fade thing under Eve
int NUM = 0100, N = NUM - 1;
int[] x = new int[NUM], y = new int[NUM];

//Mouse over
boolean overBox = false; //walle voice
boolean overBox1 = false; //start box
boolean overBox2 = false; //back 
boolean overBox3 = false; //eve
boolean overBox4 = false; //walle
boolean overBox5 = false; //back2
boolean locked = false; //mosue clicked
boolean playing = false; //audio of walle's voice
boolean resetFrame = false; //reset frame count

//Start Box
float bx = 300; //position x 
float by = 600; //position y
float boxWidth = 500;
float boxHeight = 70;

//Back button
float bx1 = 20;
float by1 = 20;
float boxWidth1 = 180;
float boxHeight1 = 50;

//choose
float bw = 300;

//game
int score;
int Size = 20;
boolean shoot = false;
int gameOver = 0;
int randomX()
{
  return int(random(900));
}

int[] ballx = { randomX(), randomX(), randomX(), randomX(), randomX() };
int[] bally = { 0, 0, 0, 0, 0 };

void setup()
{
  //laoding the song
  minim = new Minim(this);
  player = minim.loadFile("Walle.mp3", 2048);
  player.play();
  
  size(1200, 700);
  background(Red1, Green1, Blue1);
  
  stars = new ArrayList();
  for(int i = 1; i <= 300; i++) //printing 300 stars everytime it prints
  {
    stars.add(new star());
  }
  
  digitalClock = new DigitalClock(150, 10, 190);
  
  frameRate(30);
  smooth();
  noStroke();
  
  //The fade thing under Eve
  for(int i = NUM; i-- != 0; x[i] = mouseX, y[i] = mouseY);
  
  //calling the image funtion
  image();
}

void draw() 
{
  //switch statement for each page
 switch(page)
  {
    case 0:
      page1();
      break;
    case 1:
      page2();
      break;
    case 2:
      page3();
      break;
    case 3:
      page4();
      break;
    case 4:
      page5();
      break;
  }
}

void page1()
{
  backgroundFade();
  
  //calling the class Star
  for(int i = 0; i <= stars.size()-1; i++)
  {
    star starUse = (star) stars.get(i);
    starUse.display();
  }
  
  //Calling the class DigitalClock
  digitalClock.getTime();
  digitalClock.display();
 
 
 //Calling functions
  font();
  button();
  
  walle();
  image(img3, 480, -10, 700, 400);
  eve();
}

void page2()
{
  background(Red1, Green1, Blue1);
  backgroundFade();
  
  //Calling the class Star2
  for (int i =0; i < 5; i++)
  {
    Star2 s = new Star2 (random(width),random(height), 3.5, 7, int(random(4,6)));
    s.drawStar();
  }
  
  //Calling the functions
  loading();
  plant();
  image(img4, 520, 440, 130, 130);
  eve();
}

void page3()
{
  cursor();
  background(178, 216, 264);
  choose();
  back();
}

//eve game
void page4()
{
  background(0);
  back2();
  gameEve();
}

//walle game
void page5()
{
  background(0);
  back2();
  gameWalle();
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
  //If the initial colour is greater than the second colour
  //Then that colour incremenets by colourincrement
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
  noCursor();
  
  //The image Eve
  image(img2, mouseX - 40, mouseY, 100, 100);
  
  //The fade thing under Eve
  noStroke();
  fill(0100 << 030);

  for (int i = 0; i != N; 
  ellipse(x[i] = x[i + 1], y[i] = y[i + 1], i, i++) ); 
  ellipse(x[N] = mouseX, y[N] = mouseY + 120, N, N);
}

void walle()
{
  image(img1, 260, 410, 150, 150);
  
  // Test if the cursor is over the box 
  if (mouseX > 260 && mouseX < 460 && 
      mouseY > 310 && mouseY < 510) 
  {
    overBox = true;  //the cursor is over the mouse
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
  //Reseting all the loading variables 
  if (resetFrame == false)
  {
    frameCount = 0;
    loadingBack = 0;
    frame = 0;
    fillX = 0;
    resetFrame = true;
  }
  
  //The number is increasing to 100%
  loadingBack = (int((frameCount - frame %301) / 3 ));
  PFont f = createFont("Impact", 60);
  textFont(f);
  fill(255);
  text ("LOADING " + loadingBack + "%", 352, 180);
  rect(350, 200, 460, 50);
  fill(0, 0, 0, 60);
  //Filling the rect until its 100%
  fillX = ((frameCount - frame %301) / 3 * 4.5);
  rect(800, 205, fillX-450, 40);
  println ("Loading: "+loadingBack);
  println ("fillX: "+fillX);
  
  //If the number hits 100% then page changes
  if (loadingBack >= 100 || fillX >= 450)
  {
    frameCount = 0;
    loadingBack = 0;
    frame = 0;
    fillX = 0;
    page = 2;
    
    println ("Loading: "+loadingBack);
    println ("fillX: "+fillX);
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
  // Start the recursive branching
  branch(50);
  popMatrix();
}

void branch(float h) 
{
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  //When the length of the branch is 2 pixels or less
  if (h > 2) 
  {
    pushMatrix();
    rotate(theta);   // Rotate by the angle theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       
    popMatrix();     
    
    // Repeat the same thing, only branch off to the "left" this time
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
  strokeWeight(1);
  PFont f = createFont("Impact", 30);
  PFont f2 = createFont("Impact", 70);
  String s = "BACK";
  String s2 = "Choose a character";
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
    if(!locked) //if the mouse is over but not clicked
    { 
       stroke(9, 18, 72); 
       fill(33, 127, 121, 100);
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

void back2()
{
  strokeWeight(1);
  PFont f = createFont("Impact", 30);
  String s = "BACK";
  textFont(f);
  fill(255);
  text(s, 90, 55);
  
  // Test if the cursor is over the box 
  if (mouseX > bx1 && mouseX < bx1+boxWidth1 && 
      mouseY > by1 && mouseY < by1+boxHeight1)
  {
    overBox5 = true;  
    if(!locked) //if the mouse is over but not clicked
    { 
       stroke(255, 255, 255); 
       fill(33, 127, 121, 100);
    } 
  } 
  
  else
  {
     stroke(255, 255, 255, 100);
     fill(255, 255, 255, 150);
     overBox5 = false;
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
    if(!locked) //if the mouse is over but not clicked
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
    overBox1 = false; //reseting boolean
    locked = false; //reseting boolean
  } 

 if(overBox2)
  { 
    locked = true; 
    page = 0;
    overBox2 = false;//reseting boolean
    locked = false;//reseting boolean
  } 
  
  if(overBox3)
  { 
    locked = true; 
    page = 3;
    overBox3 = false;//reseting boolean
    locked = false;//reseting boolean
  } 
  
   if(overBox4)
  { 
    locked = true; 
    page = 4;
    overBox4 = false;//reseting boolean
    locked = false;//reseting boolean
  }
  
  if(overBox5)
  { 
    locked = true; 
    page = 2;
    score = 0;//reseting score to 0
    overBox5 = false;//reseting boolean
    locked = false;//reseting boolean
  }
  
   else 
  {
    locked = false;
  }
  
  shoot = true;
}

void gameEve()
{
  noCursor();
  fill(255);
  stroke (200);
  
  //drawing eve
  ellipse(mouseX-26, 620, 50, 80); //body
  ellipse(mouseX, 590, 20, 60);
  ellipse(mouseX - 44, 625, 25, 57);
  ellipse(mouseX-26, 580, 55, 40);

  // display score
  fill(255);
  text(score, 1100 ,65);
  if(shoot)
  {
    cannon(mouseX);
    shoot = false;
  }
  
   Fall();
   Finish();  
}

void gameWalle()
{
  
  //Drawing walle
  noCursor();
  fill(255, 161, 70);
  rect(mouseX+8, 600, 60, 60 ,15);
  
  fill(200);
  rect(mouseX, 640, 20, 50, 15);
  rect(mouseX + 60, 640, 20, 50 ,15);
  rect(mouseX+33, 585, 10, 20 ,15);
  stroke(100);
  rect(mouseX + 10, 566, 25, 25, 5 );
  rect(mouseX + 40, 565, 25, 25, 5);
  rect(mouseX, 570, 10, 50, 5);

  // display score
  fill(255);
  text(score, 1100 ,65);
  if(shoot)
  {
    cannon(mouseX);
    shoot = false;
  }
  
  Fall();
  Finish();  
}

void Fall()
{ 
  //The little balls that are falling in the game
  stroke(39, 154, 240); 
  fill (255, 0 ,0); 
    
  for (int i=0; i<5; i++)
  {
    ellipse(ballx[i], bally[i]++, Size, Size);
  }
    
  stroke(255);
  noFill();
  
  //The aim
  ellipse(mouseX, mouseY, 10, 10);
  ellipse(mouseX, mouseY, 15, 15);
  ellipse(mouseX, mouseY, 20, 20);
}
  
void cannon(int shotX)
{
  //to shoot
  boolean strike = false;
  for (int i = 0; i < 5; i++)
  {
    if((shotX >= (ballx[i]-Size/2)) && (shotX <= (ballx[i] + Size/2))) 
    {
      strike = true;
      line(mouseX, 565, mouseX, bally[i]);
      ellipse(ballx[i], bally[i], Size+25, Size+25);
      ballx[i] = randomX();
      bally[i] = 0;
      score++;
    }    
  }
  
  if(strike == false)
  {
    line(mouseX, 565, mouseX, 0);
  }   
}

void Finish()
{
  
  for (int i=0; i< 5; i++)
  {
    if(bally[i]==550)
    {
      fill(color(255));
      fill(255);
      text("GAME OVER", 400, 300);
      text("Your score was : "+ score, 400, 380); 
      noLoop();
     }
  }
}
  
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}