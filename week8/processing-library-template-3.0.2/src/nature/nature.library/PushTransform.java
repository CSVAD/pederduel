package template.library;

import processing.core.PApplet;

public class PushTransform implements NObj {
	
	PushTransform(PApplet myParent){
		this.renderTransformation(myParent);
	}
	
	PushTransform(PApplet myParent, boolean apply){
		if(apply){
			this.renderTransformation(myParent);

		}
		
	}
	public void renderTransformation(PApplet parent){
		parent.pushMatrix();

	}

}



