void setupGUI(){
  color activeColor = color(200,200,0);
  controlP5 = new ControlP5(this);
  controlP5.setColorActive(activeColor);
  controlP5.setColorBackground(color(20, 24, 82));
  controlP5.setColorForeground(color(220, 220, 0));
  controlP5.setColorCaptionLabel(color(0));
  controlP5.setColorValueLabel(color(0));

  ControlGroup ctrl = controlP5.addGroup("menu",15,25,35);
  ctrl.setColorLabel(color(255));
  ctrl.close();

  sliders = new Slider[10];

  int left = 0;
  int top = 5;
  int len = 300;

  int si = 0;
  int posY = 0;
  
  sliders[si++] = controlP5.addSlider("leftAngle",0,PI/2,left,top+posY+0,len,15);
  posY += 30;
  
  sliders[si++] = controlP5.addSlider("rightAngle",PI/2,PI,left,top+posY+0,len,15);
  posY += 30;

  sliders[si++] = controlP5.addSlider("boltCount",1,100,left,top+posY+0,len,15);
  posY += 30;

  sliders[si++] = controlP5.addSlider("boltWidth",0,10,left,top+posY+0,len,15);
  posY += 30;
  
  sliders[si++] = controlP5.addSlider("count",1,4,left,top+posY+0,len,15);
  posY += 30;
  
  sliders[si++] = controlP5.addSlider("split",1,10,left,top+posY+0,len,15);
  posY += 30;

  for (int i = 0; i < si; i++) {
    sliders[i].setGroup(ctrl);
    sliders[i].setId(i);
    sliders[i].getCaptionLabel().toUpperCase(true);
    sliders[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    sliders[i].getCaptionLabel().getStyle().marginTop = -4;
    sliders[i].getCaptionLabel().getStyle().marginLeft = 0;
    sliders[i].getCaptionLabel().getStyle().marginRight = -14;
    sliders[i].getCaptionLabel().setColorBackground(0x99ffffff);
  }

}

void drawGUI(){
  controlP5.show();
  controlP5.draw();
}
