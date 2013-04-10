/*
NEUROSKY
yes@cosmopol.is

hand-rolled in los angeles
august 2011

* * * / 

this class stores data from a neurosky mindset. 
it uses those data to calculate some in-house metrics:

float attn,
float med
  0-100 - e-sense attention/meditation score. 
  (these scores are produced by dark magic
  (ML) inside the neurosky API.)
  
float attn_pulse, 
float med_pulse
  0-100 - eased/smoothed version of attn
  and med. ideally, these values guard
  against the spikes we sometimes see
  in the the e-sense readings.
  
*/

public class Neurosky {
  PApplet parent;
  MindSet ns;
  
  String com_port;
  boolean god;
  
  float attn = 50;
  float med = 50;
  
  float attn_pulse;
  float med_pulse;
  
  boolean is_meditating = false;
  boolean is_attentive = false;
  
  boolean has_initialized = false;

   float pulse_easing = .1; 

  void initialize(PApplet parent, String com_port, boolean god) {
    this.god = god;
    this.parent = parent;
    this.com_port = com_port;
    ns = new MindSet(parent);
    ns.connect(this.com_port);
  }
  
  int update() {
    
    try {
      
      if (Browsing)
        return 2;
      
      if (millis() < pauseMillis)
       return 3; 
      
      if (!god) {
        med = ns.data.meditation;
        attn = ns.data.attention;
      } 
      
      if (!god) {
        if (!has_initialized) {
          if (attn == -1.0)
            return 1;
          else {
            if (attn < 20)  //hack: signal is overall low at beginning of stream 
              return 1;
          }
            has_initialized=true;
          }
        }
      
      
      set_attn_pulse();
      set_med_pulse();
       }
      
      catch( ArrayIndexOutOfBoundsException e ) {
        return 1;
      }
     
     return 0;
    }
  
  void set_attn_pulse() {
    attn_pulse += (attn - attn_pulse) * pulse_easing;
    attn_pulse = constrain(attn_pulse, 0.0, 100.0);
  }
  
  void set_med_pulse() {
    med_pulse += (med - med_pulse) * pulse_easing;
    med_pulse = constrain(med_pulse, 0.0, 100.0);
  }

}
