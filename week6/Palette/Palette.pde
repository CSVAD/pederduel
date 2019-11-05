float num1 = 1, num2 = 1, num3 = 1;

public void settings() {
  size(800, 800);
}

void draw(){
  background((mouseY/(width/num1)), (mouseX/(width/num2)), (((mouseX+mouseY)/2)/(width/num3)));
  print("_RGB:" + "(" + round((mouseY/(width/num1))) + "," + round((mouseX/(width/num2))) + "," + round((((mouseX+mouseY)/2)/(width/num3))) +")");
}

void mousePressed(){
    num1 = random(127, 255);
    num2 = random(127, 255);
    num3 = random(127, 255);
}
