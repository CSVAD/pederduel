package template.library;

import processing.core.PApplet;

public class Rotate implements NObj {
	public float theta;
	
	Rotate(PApplet myParent, float theta){
		this.theta = theta;
		this.renderTransformation(myParent);
	}
	
	Rotate(PApplet myParent, float theta, boolean apply){
		
		this.theta = theta;
		if(apply){
			this.renderTransformation(myParent);
		}
	}
	
	public void renderTransformation(PApplet parent){
		parent.rotate(this.theta);

	}
}




