package template.library;

import processing.core.PApplet;


public class Scale implements NObj {
	public float x;
	public float y;
	
	Scale(PApplet myParent, float x, float y){
		this.x = x;
		this.y = y;
		this.renderTransformation(myParent);
		
	}
	Scale(PApplet myParent, float x, float y, boolean apply){
		this.x = x;
		this.y = y;
	
		if(apply){
			this.renderTransformation(myParent);
		}
	}
	
	public void renderTransformation(PApplet parent){
		parent.scale(this.x,this.y);

	}
}




