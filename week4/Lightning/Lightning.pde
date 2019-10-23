import controlP5.*;

PVector p;
PVector pOld;
float stepSize = 50;
float angle;

Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 10;
float noiseScale = 100, noiseStrength = 10, noiseZRange = 0.4;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 2;

ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;


void setup() {
  /*size(600, 600);
  p = new PVector(width/2, 2*height);
  pOld = p.copy();
  smooth();
 // frameRate(4);
  background(0);
  */
  size(1280,800);
  smooth();
  for(int i=0; i<agents.length; i++) agents[i] = new Agent();
  setupGUI();
}

void draw() {
  fill(255, overlayAlpha);
  noStroke();
  //rect(0,0,width,height);

  stroke(0, agentsAlpha);
  //draw agents
 
   for(int i=0; i<agentsCount; i++){
     agents[i].update();
   }
  
 

  drawGUI();
}
