class Agent {
  PVector p, pOld;
  float noiseZ, noiseZVelocity = 0.01;
  float stepSize, angle;
  float noiseScale = 100; 

  Agent() {
    p = new PVector(lerpX,lerpY);
    pOld = new PVector(p.x,p.y);
    stepSize = random(1,5);
    // init noiseZ
    setNoiseZRange(0.4);
  }

  void update(){
    angle = noise(p.x/lerpX, p.y/lerpY, noiseZ) * noiseStrength;

    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;

    // offscreen wrap
    if (p.x<-10) p.x=pOld.x=width+10;
    if (p.x>width+10) p.x=pOld.x=-10;
    if (p.y<-10) p.y=pOld.y=height+10;
    if (p.y>height+10) p.y=pOld.y=-10;

    strokeWeight(strokeWidth*stepSize);
    line(pOld.x,pOld.y, p.x,p.y);

    pOld.set(p);
    noiseZ += noiseZVelocity;
  }

  void setNoiseZRange(float theNoiseZRange) {
    // small values will increase grouping of the agents
    noiseZ = random(theNoiseZRange);
  }
}
