/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

// create particle populations
boolean sparseMode = false; // set to true to make testing easier on a laptop with a small screen
boolean quietMode = true;
int particleCount = 3;
int colliderCount = 500;
int emitterCount = 5;

// instantiate particle multidimensional arrays
Particle[][] arrows;
// instantiate collider arrays
Collider[] colliders;
// instantiate emitter arrays
Emitter[] emitters;
// declare rest of global variables
Environment environment;
Engine engine;
//                        C  C  C  C  G  G  C  D  Ef F  G  Af Bf C  G
int[] pitches = new int[]{36, 36, 36, 48, 48, 48, 55, 55, 60, 62, 63, 65, 67, 68, 70, 72, 79}; // an array of pitch numbers to pick from uniformly at random
int minPitch = 36;
int maxPitch = 79;

void setup() {
  size(3840, 2160, P2D);
  background(0);
  smooth();
  
  // debug mode settings
  if (sparseMode) {
    particleCount = 5;
    colliderCount = 30;
    emitterCount = 5;
  }
  
  arrows = new Arrow[emitterCount][particleCount];
  colliders = new Collider[colliderCount];
  emitters = new Emitter[emitterCount];

  // instantiate colliders
  for (int i=0; i<colliderCount; i++) {
    //colliders[i] = new Collider(new PVector(random(width), random(height)), 4, #323332, true);
    int p = pitches[floor(random(0, pitches.length))];
    color c = pitchToColor(p);
    colliders[i] = new Collider(new PVector(random(width), random(height)), 4, c, true, p);
  }
  float theta = 0;
  float px = 0, py = 0;
  // instantiate emitters
  for (int i=0; i<emitterCount; i++) {
    // instantiate particles
    for (int j=0; j<particleCount; j++) {
      //float w, color col, float lifeSpan, float damping, int tailFinCount
      arrows[i][j] = new Arrow(random(4, 68), color(255, random(255)), 12000, .99, 4);
    }
    px = width/2+cos(theta)*1200;
    py = height/2+sin(theta)*1200;
    emitters[i] = new Emitter(new PVector(px, py), 60, new PVector((-px+width/2)*.01, (-py+height/2)*.01+-2), .4, arrows[i]);
    theta += TWO_PI/emitterCount;
  }
  // instantiate Environment
  environment = new Environment(.02, .785, new PVector(.02, 0), .995, 0);
  // instantiate engine
  engine = new Engine(emitters, colliders, environment);

  //set boundary collisions
  boolean[] bounds =  {true, true, true, false};
  engine.setBoundaryCollision(true, bounds);
  engine.mh.quietMode = quietMode;
}

void draw() {
  // uncomment next line to see animated particles
  //background(0);
  fill(0, 37);
  rect(-1, -1, width+2, height+2);
  // required to make engine do its thing
  engine.run();
}

/*
Pitch to color translation function. Low pitches will be red, middle will be blue, and high will be green.
*/
color pitchToColor(int pnumIn) {
  float pnum = 127 * ((float)(pnumIn - minPitch) / (maxPitch-minPitch)); // if not using whole MIDI range, maximize the range of 0-127 used
  float r = 0;
  float g = 0;
  float b = 0;
  if(pnum <= 64) {
    r = 255 * ((64 - pnum)/64);
    b = 255 * (pnum/64);
    g = 0;
  } else {
    r = 0;
    b = 255 * ((64 - ((float)pnum - 64))/64);
    g = 255 * ((float)(pnum - 64)/64);
  }
  color c = color(r,g,b);
  return c;
}