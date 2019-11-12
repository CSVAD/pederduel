package template.library;

import processing.core.PApplet;


public class PopTransform implements NObj {
	
	PopTransform(PApplet myParent){
		this.renderTransformation(myParent);
	}
	
	PopTransform(PApplet myParent, boolean apply){
		if(apply){
			this.renderTransformation(myParent);
		}
		
	}
	public void renderTransformation(PApplet parent){
		parent.popMatrix();

	}
}