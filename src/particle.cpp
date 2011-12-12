#include "particle.h"
#include "ofMain.h"
#include "ofxVectorMath.h"

//------------------------------------------------------------
particle::particle(){
	setInitialCondition(0,0,0,0);
	damping = 0.1f;
}

//------------------------------------------------------------
void particle::resetForce(){
    // we reset the forces every frame
    frc.set(0,0);
}

//------------------------------------------------------------
void particle::addForce(float x, float y){
    // add in a force in X and Y for this frame.
    frc.x = frc.x + x;
    frc.y = frc.y + y;
}

//------------------------------------------------------------
void particle::anchor(ofPoint p){
	
	
	ofxVec2f posOfForce;
	posOfForce.set(p.x, p.y);
	
	
	ofxVec2f diff	= pos - posOfForce;
	float length	= diff.length();
	
	float pct = length / 100;
	
	
	diff.normalize();
	
	frc.x = frc.x - diff.x * pct;
	frc.y = frc.y - diff.y * pct;
	
}

//------------------------------------------------------------
void particle::follow(float x, float y){
	
	float scale = 5.0;
	
	ofxVec2f posOfForce;
	posOfForce.set(x,y);
	
	
	ofxVec2f diff	= pos - posOfForce;
	float length	= diff.length();
	
	float pct = length / 100;
	
	diff.normalize();
	
	frc.x = frc.x - diff.x * scale * pct;
	frc.y = frc.y - diff.y * scale * pct;

}

//------------------------------------------------------------
void particle::addDampingForce(){
    frc.x = frc.x - vel.x * damping;
    frc.y = frc.y - vel.y * damping;
}

//------------------------------------------------------------
void particle::setInitialCondition(float px, float py, float vx, float vy){
    pos.set(px,py);
	vel.set(vx,vy);
}

//------------------------------------------------------------
void particle::update(){	

	vel = vel + frc;
	
	
	if (vel.x > 10.0) {
		
		vel.x = 10.0;
		
	} else if (vel.x < -10.0) {
		
		vel.x = -10.0;
		
	}
	
	if (vel.y > 10.0) {
		
		vel.y = 10.0;
		
	} else if (vel.y < -10.0) {
		
		vel.y = -10.0;
		
	}

	pos = pos + vel;

}