import controlP5.*;

PVector p;
PVector pOld;

Agent[] agents = new Agent[100]; // create more ... to fit max slider agentsCount
int boltCount = 20;
float boltWidth = 2, split = 2, rightAngle = PI, leftAngle = 0;
int count = 1;

ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;


void setup() {
  size(1280,800);
  smooth();
  background(20, 24, 82);
  for(int i=0; i<agents.length; i++) agents[i] = new Agent();
  setupGUI();
}

void draw() {
  fill(0);
  noStroke();

  stroke(255, 255, 100);
 
   for(int i=0; i<boltCount; i++){
     agents[i].update();
   }

  drawGUI();
}
