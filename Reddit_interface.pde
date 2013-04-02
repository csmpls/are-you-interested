private class SecondApplet extends PApplet {
  
  int timeout = 5000; //how long in ms before reader auto-advances
  int x = 60;
  int y = 40;
  int tbox_topbar_padding = 10;
  int topbar_height = 50;
  
  void setup() {
     size(950, 1200);
     frameRate(25);
     
     reddit = new Reddit();
     //redditFont =  loadFont("nobile.vlw");
     
     smooth();
     noStroke();
     
  }  
  
  void draw() {
    fill(background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(text_color);
    checkForTimeout();
    
    //textFont(redditFont);
    
    if (!Browsing) {
      drawRedditInterface();
    }
    else
      drawPauseInterface();
    }
  
  void drawRedditInterface() {
    int tbox_width = width-x-x-20;
    
    
    
      fill (bar_color);
      textSize(24);
      textAlign(LEFT, CENTER);
      text(reddit.currentArticle.subreddit,
      x, y, tbox_width, topbar_height);
      
      fill(text_color);
      textSize(48);
      textAlign(LEFT, TOP);
      text(reddit.currentArticle.title, 
      x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
  }
  
  void checkForTimeout() {
    if (reddit.curr_time+timeout > millis()) { }
      // attn.lvldown();  TIMEOUTS NOT WORKING RN .. QUESTIONABLE IF WE EVEN WANT THIS FEATURE LIKE JUST USE THE KEYBOARD U KNOW
  }
  
  void drawPauseInterface() {
    
    int tbox_width = width-x-x-40;
    
      fill(text_color);
      textSize(48);
      textAlign(LEFT, TOP);
      text("reading an article rn...press any key to continue", 
      x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
  }
  
  void keyPressed() {
  
  if (Browsing) {
  
    Browsing = false;
    attn.currentMsg="";
    reddit.advance();
    pauseMillis = millis()+stimulusPauseDuration; //set stimulus pause
  
  } else {   

    if (keyCode == RIGHT) 
      reddit.advance();
      
    if (keyCode == LEFT)
      reddit.back();
    
    if (keyCode == ENTER) {
      link(reddit.currentArticle.url, "_new");
      Browsing = true;
    }
    
  }
 }

}




