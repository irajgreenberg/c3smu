/**
 * Collider class
 * Particle Engine
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 class Collider extends Sprite{

  // use to control collider visibility
  boolean isRendered;
  float pulseMag = 0;
  int pitch = 60; // the collider has a pitch associated with it 
  

  // default constructor
  Collider(){
  }

  // constructor - smooth circle
  Collider(PVector loc, float radius, color col, boolean isRendered){
    super(loc, radius, col);
    this.isRendered = isRendered;
  }
  
    // constructor - smooth circle
  Collider(PVector loc, float radius, color col, boolean isRendered, int pitchNum){
    super(loc, radius, col);
    this.isRendered = isRendered;
    this.pitch = pitchNum;
  }
  
  void create(){
    noStroke();
    // only draw if true
    if (isRendered){
      float r = red(col);
      float g = green(col);
      float b = blue(col);
      color c = color(r+pulseMag, g, b);
      fill(c);
      pushMatrix();
      translate(loc.x, loc.y);
      ellipse(0, 0, radius*2+pulseMag, radius*2 + pulseMag);
      popMatrix();
    }
    pulseMag *= .975;
  }
  
  void pulse(){
    pulseMag = 60;
  }
}