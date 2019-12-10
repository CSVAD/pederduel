//import gab.opencv.*;
import com.hamoid.*;
import controlP5.*;
import processing.sound.*;
import processing.video.*;

// Computer Vision
//OpenCV opencv;
//PImage src, canny, scharr, sobel;

// Motion
PImage prev;
int Threshold = 50;
float motionX = 0;
float motionY = 0;
float lerpX = width/2;
float lerpY = height/2;

// Agents
Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 5000;
float noiseScale = 100, noiseStrength = 10, noiseZRange = 0.4;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;

// VideoExport, Video and Camera
VideoExport videoExport;
Video video;
Capture cam;
int[] pixelList;
int pxl = 0;
boolean recording = false;
boolean stopped = true;
boolean motionBlur = false;
boolean pictureMode = false;
boolean pic = false;

// Sound
Sound sound;
Amplitude amp;
AudioIn audioIn;
float volume;
float Sound_Sens;
boolean soundCapture = false;
boolean soundManipulation = false;

// ControlP5
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;
Slider[] agentSliders;
Toggle[] toggles;
Toggle[] toggleSound;
Toggle[] toggleMethod;
Slider[] sliderSound;


// ---------------------------------------------------------------------------------------------------------------------------

// Setup begins
void setup(){
  size(640,480);
  smooth();     
  for(int i=0; i<agents.length; i++) agents[i] = new Agent();
  
  // Camera and video init
  cam = new Capture(this,640,480,30);
  cam.start();
  prev = createImage(640, 480, RGB);
  //video = new Video();
  videoExport = new VideoExport(this, "motionRun"+random(100)+".mp4");
  videoExport.startMovie();
  
  // Sound init
  sound = new Sound(this);
  amp = new Amplitude(this);
  audioIn = new AudioIn(this,0);
  audioIn.play();
  amp.input(audioIn);
  //sound.outputDevice(0);
  
  // Setting up GUI environment
  setupGUI();
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

// Functionality for record toggle
public void Recording(boolean val){
  recording = val;
}
public boolean isRecording(){
  return recording;
}

// Functionality for stop toggle
public void Stop(boolean val){
  stopped = val;
}
public boolean isStopped(){
  return stopped;
}

// Functionality for motion blur
public void Motion_Blur(boolean val){
  motionBlur = val;
}
public boolean isMotionBlur(){
  return motionBlur;
}

// Functionality for motion blur
public void Picture_Mode(boolean val){
  pictureMode = val;
}
public boolean isPictureMode(){
  return pictureMode;
}

// Functionality for sound capture
public void Sound_Capture(boolean val){
  soundCapture = val;
}
public boolean isSoundCapture(){
  return soundCapture;
}

// Functionality for sound manipulation
public void Sound_Manipulation(boolean val){
  soundManipulation = val;
}
public boolean isSoundManipulation(){
  return soundManipulation;
}

public void Picture(boolean val){
  pic = val;
}
public boolean takenPicture(){
  return pic;
}

// Funtion for recording video
public void record(){
      volume = amp.analyze();
      rect(0,0,width,height);
      cam.loadPixels();
      prev.loadPixels();
      image(cam,0,0);
      int count = 0;
      float avgX = 0;
      float avgY = 0;
      loadPixels();
      if(cam.available()){
        cam.read();
      }
        // Begin loop to walk through every pixel
        for (int x = 0; x < cam.width; x++ ) {
          for (int y = 0; y < cam.height; y++ ) {
            int loc = x + y * cam.width;
            // What is current color
            color currentColor = cam.pixels[loc];
            float r1 = red(currentColor);
            float g1 = green(currentColor);
            float b1 = blue(currentColor);
            color prevColor = prev.pixels[loc];
            float r2 = red(prevColor);
            float g2 = green(prevColor);
            float b2 = blue(prevColor);
      
            float d = distSq(r1, g1, b1, r2, g2, b2); 
            
            if(!isSoundManipulation()){
              // Checking if motion blur is on or off
              if(!isMotionBlur()){
                stroke(255, agentsAlpha);
                if (d > Threshold*Threshold) {
                  avgX += x;
                  avgY += y;
                  count++;
                  pixels[loc] = color(255);
                } else {
                  pixels[loc] = color(0);
                }
              }else if(isMotionBlur()){
                fill(255-r1,255-g1,255-b1, overlayAlpha);
                stroke(255-r1,255-g1,255-b1, agentsAlpha);
                if (d > Threshold*Threshold) {
                  avgX += x;
                  avgY += y;
                  count++;
                  pixels[loc] = color(r2,g2,b2);
                } else {
                  pixels[loc] = color(r1,g1,b1);
                }
              }
            }else{
              if(!isMotionBlur()){
                stroke(255, agentsAlpha);
                if (d > Threshold*Threshold) {
                  avgX += x;
                  avgY += y;
                  count++;
                  pixels[loc] = color(255*volume*Sound_Sens);
                } else {
                  pixels[loc] = color(0);
                }
              }else if(isMotionBlur()){
                fill(255-(r1*volume*Sound_Sens),255-(g1*volume*Sound_Sens),255-(b1*volume*Sound_Sens), overlayAlpha);
                stroke(255-(r1*volume*Sound_Sens),255-(g1*volume*Sound_Sens),255-(b1*volume*Sound_Sens), agentsAlpha);
                if (d > Threshold*Threshold) {
                  avgX += x;
                  avgY += y;
                  count++;
                  pixels[loc] = color(r2*volume*Sound_Sens,g2*volume*Sound_Sens,b2*volume*Sound_Sens);
                } else {
                  pixels[loc] = color(r1*volume*Sound_Sens,g1*volume*Sound_Sens,b1*volume*Sound_Sens);
                }
              }
            }
          }
        }
      updatePixels();
      
      // Calculating position of average motion
      if (count > 50) { 
        motionX = avgX / count;
        motionY = avgY / count;
      }
      lerpX = lerp(lerpX, motionX, 0.7); 
      lerpY = lerp(lerpY, motionY, 0.7);
      
      noiseStrength = (width*height)/(lerpX*lerpY);

     for(int i=0; i<agentsCount; i++){
       agents[i].update();
     }
     if(!isPictureMode() && isRecording()){
       videoExport.saveFrame();
     }
}

public void endVideo(){
  videoExport.endMovie();
  exit();
}

void draw(){
  record();
  drawGUI();
  // Picture or video mode selected
  if(!isPictureMode()){
    // Checking if sound capture is activated
    if(!isSoundCapture()){
      // Checking if record button is activated
      if(isRecording()) {
        record();
      }else{
        Recording(false);
      }
      if(isStopped()){
        endVideo();
      }
    }
    if (isSoundCapture()){
      float noise = amp.analyze();
      if(noise > 1-(0.1*Sound_Sens)){
        // The analyze() function samples from more than one frame, so I tried to make it more accurate by introducing "m". Not sure if it makes a difference
        int m = 1;
        if(m == 1){
          recording = !recording;
        }
        println("Not recording");
        if(isStopped()){
          endVideo();
        }
      }
      if(recording) {
        println("Recording");
        record();
      }
      if(isStopped()){
        endVideo();
      }
    }
  }else{
    // Checking if sound capture is activated
    if(isSoundCapture()){
      float noise = amp.analyze();
      if(noise > 1-(0.1*Sound_Sens)){
        saveFrame();
      }
      if(isStopped()){
        exit();
      }
    }
    else if(!isSoundCapture()){
      // Checking if picture is taken
      if(takenPicture()) {
        saveFrame();
      }
      if(isStopped()){
        exit();
      }
    }
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
