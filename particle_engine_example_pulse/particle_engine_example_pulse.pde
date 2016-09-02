/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

// create particle populations
int particleCount = 5;
int colliderCount = 500;
int emitterCount = 8;

// instantiate particle multidimensional arrays
Particle[][] arrows = new Arrow[emitterCount][particleCount];
// instantiate collider arrays
Collider[] colliders = new Collider[colliderCount];
// instantiate emitter arrays
Emitter[] emitters = new Emitter[emitterCount];
// declare rest of global variables
Environment environment;
Engine engine;
//                        C  C  C  C  G  G  C  D  Ef F  G  Af Bf C  G
int[] pitches = new int[]{36, 36, 48, 48, 55, 55, 60, 62, 63, 65, 67, 68, 70, 72, 79}; // an array of pitch numbers to pick from uniformly at random

void setup() {
  size(3840, 2160, P2D);
  background(0);
  smooth();

  // instantiate colliders
  for (int i=0; i<colliderCount; i++) {
    colliders[i] = new Collider(new PVector(random(width), random(height)), 4, #323332, true);
    colliders[i].pitch = pitches[floor(random(0, pitches.length))]; // pick a pitch for the current collider
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
}

void draw() {
  // uncomment next line to see animated particles
  //background(0);
  fill(0, 37);
  rect(-1, -1, width+2, height+2);
  // required to make engine do its thing
  engine.run();
}