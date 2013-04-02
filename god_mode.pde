/* 
GOD MODE GUI
whatup@cosmopol.is

this class sets up a GUI to simulate neurosky output.

*/

void setupGUI() {

  
  cP5 = new ControlP5(this);
  //new controller window
  ControlWindow ns_window = cP5.addControlWindow("ns_win", 250, 300);
  ns_window.setLocation(10, 10);
  //add GUI elements to a group
  //move group to controller window
  ControlGroup brain_gui = cP5.addGroup("brains_up", 30, 30);
  brain_gui.moveTo(ns_window);
  cP5.begin(brain_gui, 5, 10);
  cP5.addSlider("med_value", 0, 100).linebreak();
  cP5.addSlider("attn_value", 0, 100).linebreak();
  cP5.end();
}

void updateGUI() {
  cP5.controller("med_value").setValue(neurosky.med);
  cP5.controller("attn_value").setValue(neurosky.attn);
}

public void med_value(int v) {  neurosky.med = v; } 

public void attn_value(int v) {  neurosky.attn = v; }

