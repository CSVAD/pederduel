ControlGroup ctrl;
ControlGroup agentCtrl;

void setupGUI(){
  color activeColor = color(0,255,0);
  controlP5 = new ControlP5(this);
  controlP5.setColorActive(activeColor);
  controlP5.setColorBackground(color(255, 0, 0));
  controlP5.setColorForeground(color(175, 0, 0));
  controlP5.setColorCaptionLabel(color(255));
  controlP5.setColorValueLabel(color(255));

  ControlGroup ctrl = controlP5.addGroup("menu",15,25,35);
  ctrl.setColorLabel(color(255));
  ctrl.close();
  //ctrl.setOpen(false);

  ControlGroup agentCtrl = controlP5.addGroup("agents",100,25,45);
  agentCtrl.setColorLabel(color(255));
  agentCtrl.close();

  ControlGroup soundCtrl = controlP5.addGroup("sound",195,25,45);
  agentCtrl.setColorLabel(color(255));
  soundCtrl.close();
 
  ControlGroup captureMethods = controlP5.addGroup("methods",300,25,50);
  agentCtrl.setColorLabel(color(255));
  captureMethods.close();

  sliders = new Slider[10];
  agentSliders = new Slider[10];
  toggles = new Toggle[10];
  toggleSound = new Toggle[10];
  toggleMethod = new Toggle[10];
  sliderSound = new Slider[10];

  int left = 0;
  int top = 5;
  int len = 70;

  int si = 0;
  int asi = 0;
  int snd = 0;
  int ssnd = 0;
  int tgl = 0;
  int mtd = 0;
  
  int posY = 0;
  int posYagent = 0;
  int posYsound = 0;
  int posYmethod = 0;
  
  toggles[tgl++] = controlP5.addToggle("Recording").setValue(false).setPosition(left,top+posY+0);
  posY += 35;
  
  toggles[tgl++] = controlP5.addToggle("Stop").setState(false).setPosition(left,top+posY+0);
  posY += 35;
  
  toggles[tgl++] = controlP5.addToggle("Picture").setState(false).setPosition(left,top+posY+0);
  posY += 35;
  
  sliders[si++] = controlP5.addSlider("Threshold",15,100,left,top+posY+0,len,15);
  posY += 35;
  
  toggles[tgl++] = controlP5.addToggle("Motion_Blur").setValue(false).setPosition(left,top+posY+0);
  posY += 35;
  
  toggleMethod[mtd++] = controlP5.addToggle("Picture_Mode").setValue(false).setPosition(left,top+posYmethod+0);
  posYmethod += 35;
  
  //agentSliders[asi++] = controlP5.addSlider("Test",1,10,left,top+posY+0,len,15);
  //posY += 35;
  
  agentSliders[asi++] = controlP5.addSlider("agentsCount",0,10000,left,top+posYagent+0,len,15);
  posYagent += 35;
  
  agentSliders[asi++] = controlP5.addSlider("strokeWidth",1,10,left,top+posYagent+0,len,15);
  posYagent += 35;
  
  toggleMethod[mtd++] = controlP5.addToggle("Sound_Capture").setState(false).setPosition(left,top+posYmethod+0);
  posYmethod += 35;
  
  toggleSound[snd++] = controlP5.addToggle("Sound_Manipulation").setState(false).setPosition(left,top+posYsound+0);
  posYsound += 35;
  
  sliderSound[ssnd++] = controlP5.addSlider("Sound_Sens",1,10,left,top+posYsound+0,len,15);
  posYsound += 35;
  //agentSliders[asi++] = controlP5.addSlider("angle",1,10,left,top+posYagent+0,len,15);
  //posYagent += 35;

  for (int i = 0; i < tgl; i++) {
    toggles[i].setGroup(ctrl);
    toggles[i].setId(i);
    toggles[i].getCaptionLabel().toUpperCase(true);
    toggles[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    toggles[i].getCaptionLabel().getStyle().marginTop = -4;
    toggles[i].getCaptionLabel().getStyle().marginLeft = 0;
    toggles[i].getCaptionLabel().getStyle().marginRight = -14;
  }
  
  for (int i = 0; i < si; i++) {
    sliders[i].setGroup(ctrl);
    sliders[i].setId(i);
    sliders[i].getCaptionLabel().toUpperCase(true);
    sliders[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    sliders[i].getCaptionLabel().getStyle().marginTop = -4;
    sliders[i].getCaptionLabel().getStyle().marginLeft = 0;
    sliders[i].getCaptionLabel().getStyle().marginRight = -14;
  }
  
  for (int i = 0; i < asi; i++) {
    agentSliders[i].setGroup(agentCtrl);
    agentSliders[i].setId(i);
    agentSliders[i].getCaptionLabel().toUpperCase(true);
    agentSliders[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    agentSliders[i].getCaptionLabel().getStyle().marginTop = -4;
    agentSliders[i].getCaptionLabel().getStyle().marginLeft = 0;
    agentSliders[i].getCaptionLabel().getStyle().marginRight = -14;
  }
  
  for (int i = 0; i < snd; i++) {
    toggleSound[i].setGroup(soundCtrl);
    toggleSound[i].setId(i);
    toggleSound[i].getCaptionLabel().toUpperCase(true);
    toggleSound[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    toggleSound[i].getCaptionLabel().getStyle().marginTop = -4;
    toggleSound[i].getCaptionLabel().getStyle().marginLeft = 0;
    toggleSound[i].getCaptionLabel().getStyle().marginRight = -14;
  }
  
  for (int i = 0; i < ssnd; i++) {
    sliderSound[i].setGroup(soundCtrl);
    sliderSound[i].setId(i);
    sliderSound[i].getCaptionLabel().toUpperCase(true);
    sliderSound[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    sliderSound[i].getCaptionLabel().getStyle().marginTop = -4;
    sliderSound[i].getCaptionLabel().getStyle().marginLeft = 0;
    sliderSound[i].getCaptionLabel().getStyle().marginRight = -14;
  }
  
  for (int i = 0; i < mtd; i++) {
    toggleMethod[i].setGroup(captureMethods);
    toggleMethod[i].setId(i);
    toggleMethod[i].getCaptionLabel().toUpperCase(true);
    toggleMethod[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    toggleMethod[i].getCaptionLabel().getStyle().marginTop = -4;
    toggleMethod[i].getCaptionLabel().getStyle().marginLeft = 0;
    toggleMethod[i].getCaptionLabel().getStyle().marginRight = -14;
  }
}

/*void mousePressed(){
  println(ctrl.isOpen(), agentCtrl.isOpen());
  /*if(ctrl.isOpen()){
    println("Ctrl open");
    agentCtrl.close();
    agentCtrl.setOpen(false);
  }else if(agentCtrl.isOpen()){
    println("Agent ctrl open");
    ctrl.close();
    ctrl.setOpen(false);
  }
}*/

void drawGUI(){
  controlP5.show();
  controlP5.draw();
}
