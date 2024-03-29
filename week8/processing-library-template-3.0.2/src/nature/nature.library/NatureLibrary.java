package template.library;

/*
import java.util.ArrayList;

import template.library.NColor;
import template.library.NObj;
import template.library.NShape;
import processing.core.PApplet;
import processing.core.*;*/

import processing.core.*;

import java.util.ArrayList;

/**
 * This is a template class and can be used to start a new processing Library.
 * Make sure you rename this class as well as the name of the example package 'template' 
 * to your own Library naming convention.
 * 
 * (the tag example followed by the name of an example included in folder 'examples' will
 * automatically include the example in the javadoc.)
 *
 * @example Hello 
 */

public class NatureLibrary {
	
	// myParent is a reference to the parent sketch
	PApplet myParent;
	ArrayList<NObj> objects;
	NColor fillColor;
	NColor strokeColor;
	float strokeWeight;
	boolean noFill = true;
	boolean noStroke = false;

	int myVariable = 0;
	
	public final static String VERSION = "##library.prettyVersion##";
	

	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the Library.
	 * 
	 * @example Hello
	 * @param theParent
	 */
	public NatureLibrary(PApplet theParent) {
		myParent = theParent;
		objects = new ArrayList<NObj>();
		strokeColor = new NColor(0,0,0);
		fillColor = new NColor(255,255,255);
		strokeWeight = 1;
		welcome();
	}
	
	
	private void welcome() {
		System.out.println("##library.name## ##library.prettyVersion## by ##author##");
	}
	
	
	public void tiger(float weight){
		this.strokeWeight = weight;
		noStroke = false;
		System.out.println("weight: " + weight);
		if(myParent.mouseX % 5 == 0 || myParent.mouseX % 2 == 0){
			strokeColor = new NColor(50,50,50);
			System.out.println("dark: " + myParent.mouseX);
		}
		else{
			strokeColor = new NColor(255,255,255);
			System.out.println("light: " + strokeColor);
		}
	}
	
	public NShape addShape(){
		NShape nShape = new NShape(this.myParent,strokeColor,strokeWeight,noFill,noStroke);
		this.objects.add(nShape);
		return nShape;
	}
	
	
	public String say() {
		return "hello nature-library.";
	}
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

	/**
	 * 
	 * @param theA
	 *          the width of test
	 * @param theB
	 *          the height of test
	 */
	public void setVariable(int theA, int theB) {
		myVariable = theA + theB;
	}

	/**
	 * 
	 * @return int
	 */
	public int getVariable() {
		return myVariable;
	}
}

