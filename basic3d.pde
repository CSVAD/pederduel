import controlP5.*;
ControlP5 cp5;

int resolution = 4;

float frequency = 0.1;
float Width = 4.38;
float Height = 438;
float Box_Pyramid = 4.82;

Controller ringResSlider;
Controller freqSlider;
Controller WidthSlider;
Controller heightSlider;
Controller Box_PyramidSlider;


void setup() {
  size(1024, 768, P3D);
  cp5 = new ControlP5(this);

  WidthSlider =  cp5.addSlider("Width")
    .setPosition(25, 25*3)
    .setRange(1.0, 4.5);
    ;

  heightSlider = cp5.addSlider("Height")
    .setPosition(25, 25*4)
    .setRange(100, height-10)
    ;

  Box_PyramidSlider = cp5.addSlider("Box_Pyramid")
    .setPosition(25, 25*5)
    .setRange(0.93,4.82)
    ;
}

void draw() {
  int rowNum = 2;
  float quadHeight = Height/rowNum;
  int red = 194;
  int green = 178;
  int blue = 128;

  float value = cp5.getController("Box_Pyramid").getValue();

  background(0);
  lights();
  pushMatrix();
  translate(width / 2, height / 2 - rowNum*quadHeight / 2 , -100);
  
  fill(red/(value-0.3) + 152, 
       green*((value/4.82)-0.19) > 144 ? 178 : green*((value/4.82)-0.19), 
       blue*((value/4.82)-0.19) > 103 ? 128 : blue*((value/4.82)-0.19));

  stroke(0);
  strokeWeight(1);
  rotateY((float)(frameCount * Math.PI / 400));

  Point3D[][] verticies = calculateVerticies(rowNum, quadHeight);

  beginShape(QUAD_STRIP);
  for (int i=1; i<verticies.length; i++) {
    Point3D[] pointListTop = verticies[i-1];
    Point3D[] pointListBottom = verticies[i];


    for (int j=0; j<=pointListTop.length; j++) {
      int t;
      if (j<pointListTop.length) {
        t = j;
      } else {
        t = 0;
      }
      Point3D bottom = pointListBottom[t];
      Point3D top = pointListTop[t];
      vertex(top.x, top.y, top.z);
      vertex(bottom.x, bottom.y, bottom.z);
    }
  }

  endShape(CLOSE);

  popMatrix();
}



Point3D[][] calculateVerticies(int rowNum, float quadHeight) {
  Point3D[][] verticies = new Point3D[rowNum][resolution];
  
  for (int i=0; i<rowNum; i++) {
    float y = quadHeight*i;
    float theta = map(i,0,rowNum,0,8*PI);
    float r = (1+sin(theta*frequency+Box_Pyramid))*Width/2;
    println(r);
    Point3D[] pointList = calculatePoints(r*100, y, resolution);
    verticies[i] = pointList;
  }
  return verticies;
}


Point3D[] calculatePoints(float r, float y, int res) {
  Point3D [] pointList = new Point3D[res];
  for (int i =0; i<res; i++) {
    float theta = 2*PI/res*i;
    float x = cos(theta)*r;
    float z = sin(theta)*r;
    Point3D p = new Point3D(x, y, z);
    pointList[i] = p;
  }

  return pointList;
}
