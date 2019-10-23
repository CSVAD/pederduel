import java.util.Random;
import java.util.Arrays;
import java.util.List;

class Agent {
  PVector p, pOld;
  float noiseZ, noiseZVelocity = 0.01;
  float stepSize, angle;
  Random rand = new Random();
  int interval[] = {width/5, 2*width/5, 3*width/5, 4*width/5};
  //List<Integer> list = new ArrayList<>();
  int max = 4*width/5;
  int med2 = 3*width/5;
  int med1 = 2*width/5;
  int min = width/5;

  Agent() {
    p = new PVector(width/2, 0);
    pOld = new PVector(p.x,p.y);
    stepSize = 10;
    // init noiseZ
    setNoiseZRange(0.4);
  }

  void update(){
    float angle;
    //angle = noise(p.x/noiseScale, p.y/noiseScale, noiseZ) * noiseStrength;

    if (p.y >= height/2){
      angle = random(0, PI);
    }
    else{
      angle = random(PI/2.1,1.1*PI/2.1);
    }

    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
    
    /*// offscreen wrap
    if (p.x<-10) p.x=pOld.x=width+10;
    if (p.x>width+10) p.x=pOld.x=-10;
    if (p.y<-10) p.y=pOld.y=height+10;
    if (p.y>height+10) p.y=pOld.y=-10;
    */
    
    strokeWeight(strokeWidth);
    line(pOld.x,pOld.y, p.x,p.y);
    pOld.set(p);
    
    noiseZ += noiseZVelocity;
  }



  void setNoiseZRange(float theNoiseZRange) {
    // small values will increase grouping of the agents
    noiseZ = random(theNoiseZRange);
  }
}
