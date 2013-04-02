class Levels {
  //==============game vars  
  float score;
  int lvl;
  float lvlup;
  float decay_value;
 
  //==============ui vars
  int s; 
  float r;
  int x, y, z, x1, x2, x3, y1, y2, y3;
  String l1, l2, l3;
  String currentMsg = "";
  
  Levels(int x_center, int y_center, String label1, String label2, String label3) {
    s = 300; //overall GUI scale (pixels)
    r = 1.42;
    font = loadFont("Monoxil-Regular-120.vlw");
    textFont(font, 55);
    textAlign(CENTER, CENTER);
    
    score = 50;
    lvlup = 100;
    decay_value = .56; //higher is faster
    l1 = label1;
    l2 = label2;
    l3 = label3;
    
    init_gui_vars(x_center, y_center);
    setup_controlP5();
  }
  
  void play_lvls(float used_value, float show_value) {
    if (used_value > 55)          score+=(used_value-55)*.16; 
    if (used_value < 30)        score-=(30-used_value)*.2;
    else                      decay_score();
    check_for_lvlup();
    draw_gui(used_value, show_value);
    }

  void check_for_lvlup() {
    if (score > lvlup)  lvlup();
    if (score < 0)      lvldown();
  }



// lvup and lvldown behavior


  void lvlup() {
    score = 50;
    winsound.trigger();
    fill(bar_color);
    currentMsg = returnInterestedMsg();
    link(reddit.currentArticle.url, "_new"); Browsing = true;
  }
  
  void lvldown() {
    score = 50;
    losesound.trigger();
    fill(text_color_lose);
    currentMsg = returnBoredMsg();
    reddit.advance();
    pauseMillis = millis()+stimulusPauseDuration; //set stimulus pause
  }
  
  
  //        «÷«
  
  
  String returnInterestedMsg() {
    burn_random();
    
   String[] InterestingMsgs = { 
      "interested!",
      "hm interested!",
      "ya interested!"
   };
    
    int r = (int)random(InterestingMsgs.length);
    return InterestingMsgs[r];
   }
  
  String returnBoredMsg() {
    burn_random();
    
    String[] BoredMsgs = {
      "nope",
      "eh nope",
      "eh w/e",
      "w/e",
      "nah",
      "not interested"
    };
    
    int r = (int)random(BoredMsgs.length);
    return BoredMsgs[r];
    
  }
  
  void decay_score() {
    score -= decay_value;
    constrain(score, 0, lvlup);
  }
  
  void init_gui_vars(int mid_x, int mid_y) {
    //proportion variables
    x = (int) (s / (r*r*20)); 
    y = (int) (s / (r*10));
    
    //coordinate variables
    x1 = (int)(mid_x - y - (2*x));
    x2 = (int)(x1 + y);
    x3 = (int)(mid_x + y + z);
    y1 = (int)((mid_y - (s/2 + y/2 + (r*x))/2));
    y2 = (int)(y1 + s/2 + y/2);
    y3 = (int)(y1 - .5*y);
  
    //relative vars
    z = (int)(s / 1.8);
  }
  
  void setup_controlP5() {
    cp5.setColorBackground(slider_bg_color);
    cp5.setColorForeground(bar_color);
    cp5.setColorActive(bar_color);
    cp5.setColorLabel(text_color);
    cp5.setColorCaptionLabel(text_color);
    cp5.setColorValue(text_color);
    cp5.setColorValueLabel(text_color);
    
    cp5.addSlider(l1, 0, 100, 0, x1, y1, x, s/2).setId(0);
    cp5.addSlider(l2, 0, 100, 0, x2, y1, x, s/2).setId(1);
    cp5.addSlider(l3, 0, lvlup, 0, x1, y2, z, (int)(r*x)).setId(2);
  } 
  
  void draw_gui(float used_value, float show_value) {
    cp5.controller(l2).setValue(show_value);
    cp5.controller(l1).setValue(used_value);
    cp5.controller(l3).setValue(score);
    draw_lvlbox();
  }

  void draw_loading_screen() {
    background(background_color);
    fill(text_color);
    textLeading(46);
    text("TRYNA SETUP BRAIN HAT.....", x3+50, y3, width-x3-120, s/2+30);
  }  
  
  void draw_stimulus_pause() {
    background(background_color);
  }
  
  void draw_lvlbox() {
    text(currentMsg.toUpperCase(), x3, y3+20, width-x3, s/2+30);
  }
  
}


