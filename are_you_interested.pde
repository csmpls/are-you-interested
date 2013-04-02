import com.shigeodayo.pframe.*;
import processing.serial.*;
import controlP5.*;
import ddf.minim.*;
import org.json.*;
import mindset.*;

/*
        ////////////////////////////////////////////////
        //////////////// A   R   E /////////////////////
        //////////////// Y   O   U /////////////////////
        /////////////////INTERESTED/////////////////////
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!! HAND-ROLLED IN !!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!THE XANA-KITCHEN!!!!!!!
        !!!!!!! EVANSTON, IL 2013 !!!! !!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
* * */

String BASE_URL =   //my reddit/json  
"YOUR JSON HASH HERE"; //find this by going to to Preferences > RSS Feeds 
//then, next to Private Listings > your front page, copy the JSON link.
Reddit reddit;
boolean Browsing;
int pauseMillis = 0;
int stimulusPauseDuration = 600; //how many ms to wait for user to react to new stimulus?

ControlP5 cP5;
Minim minim;
AudioSample winsound;
AudioSample losesound;

SecondApplet secondApplet = null;
PFrame secondFrame = null;

PFont redditFont;

//==============brain game vars
//god mode takes input from msouse:
boolean god_mode = false; 
String com_port = "/dev/tty.MindWave";
//replace with whatever serial device you connect
//your mindset through. on mac/linux it 
//will start with /dev; on windows, COM#
Neurosky neurosky = new Neurosky();
Levels attn;

//==============ui vars
color background_color = color(12,12,12);
color slider_bg_color = color(31,30,30);
color text_color = color(226, 227, 223);
color text_color_win = color(200, 255, 200);
color text_color_lose = color(227, 56, 49);
color bar_color = color(202, 242, 0);
ControlP5 cp5;
PFont font;

void setup() {
  size (800, 230);
  frameRate(24);
  smooth(); 
  stroke(255);
  textLeading(-5);
  frameRate(24);

  secondApplet = new SecondApplet();
  secondFrame = new PFrame(secondApplet, 960, 0);
  secondFrame.setTitle("reddit browser");

  neurosky.initialize(this, com_port, god_mode);
  setupBrainGUI();

  minim = new Minim(this);
  winsound = minim.loadSample("winsound.aiff", 512);
  losesound = minim.loadSample("losesound.aiff", 512);

  if (god_mode) { 
    setupGUI();
  }
}

void draw() {
  if (god_mode) { 
    updateGUI();
  }
  background(background_color);
  int n = neurosky.update();
  if (n == 0)
    attn.play_lvls(neurosky.attn_pulse, neurosky.attn);  
  else if (n == 1)
    attn.draw_loading_screen();
  else if (n == 2)
    attn.draw_lvlbox();
  else if (n ==3)
    attn.draw_stimulus_pause();
}


void setupBrainGUI() {
  textAlign(CENTER, CENTER);
  cp5 = new ControlP5(this); 
  //ControlWindow brain_win = cP5.addControlWindow("brain window", 900, 400);

  attn = new Levels(150, height/2 - 20, "r", "a", "p");
}

void burn_random() {
  // burn for real random, 
  // no funny business
  float burn; 
  randomSeed(second());  
  burn=random(1.0);
}

void stop() {
  winsound.close();
  losesound.close();
  minim.stop();
  super.stop();
}

