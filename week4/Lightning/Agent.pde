import java.util.Random;

class Agent {
  PVector p, pOld;
  float stepSize, angle;
  Random rand = new Random();
  int[] interval = {3*width/5, 2*width/5, 4*width/5, width/5};

  Agent() {
    p = new PVector(interval[rand.nextInt(count)], 0);
    pOld = new PVector(p.x,p.y);
    stepSize = 10;
  }

  void update(){
    float angle;
    if (p.y >= height/split){
      angle = random(leftAngle, rightAngle);
      stepSize = 10;
    }
    else{
      angle = random(24*PI/50, 26*PI/50);
      stepSize = 30;
    }

    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
    
    strokeWeight(boltWidth);
    line(pOld.x,pOld.y, p.x,p.y);
    pOld.set(p);
    
    if(p.y >= height){
      delay(500);
      setup();
    }
  }
}
