import drawing.library.*;
import processing.pdf.*;
import java.util.Random;
import controlP5.*;

DrawingManager drawingManager;
DShape shape;
ControlP5 controlP5;
Random rand = new Random();
int noise = 0, col = 5, weight = 4;

void setupGUI(){
  color activeColor = color(200,200,0);
  controlP5 = new ControlP5(this);
  controlP5.setColorActive(activeColor);
  controlP5.setColorBackground(color(20, 24, 82));
  controlP5.setColorForeground(color(200, 45, 180));
  controlP5.setColorCaptionLabel(color(0));
  controlP5.setColorValueLabel(color(0));

  int left = 0;
  int top = 5;
  int len = 300;

  int posY = 0;
  
  controlP5.addSlider("noise",0,25,left+10,top+posY+0,len,15);
  posY += 30;
  
  controlP5.addSlider("col",0,255,left+10,top+posY+0,len,15);
  posY += 30;
  
  controlP5.addSlider("weight",1,30,left+10,top+posY+0,len,15);
  posY += 30;

}

void drawGUI(){
  controlP5.show();
  controlP5.draw();
}

void setup() {
  size(1056,816,P3D);
  background(random(255),random(255),random(255));
  smooth();
  drawingManager = new DrawingManager(this);
  setupGUI();
 }

void draw() {
  drawGUI();
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}

void mousePressed(){
   shape = drawingManager.addShape(); 
 
}
  
void mouseDragged(){
    drawingManager.strokeWeight(random(weight));
    int i = rand.nextInt(1+col);
    int j = rand.nextInt(1+col);
    int k = rand.nextInt(1+col);
    drawingManager.stroke(i,j,k);
    shape.addVertex(mouseX+random(-noise, noise), mouseY+random(-noise, noise));
}
