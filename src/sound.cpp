/*
 *  sound.cpp
 *  Dan
 *
 *  Created by Matt Ruby on 9/22/11.
 *  Copyright 2011. All rights reserved.
 *
 */

#include "sound.h"

//---------------------------------------------------------------------
sound::sound(){
	vel.set(0.0, 0.0);
	prevVel.set(0.0, 0.0);
	prevPos.set(0.0, 0.0, 0.0);
	bPlay = false;
	volume = 0.0;
}

//------------------------------------------------------------------
void sound::update(ofxVec2f v) {
	
	vel.set(v.x, v.y);
	
	if (vel.x > 0 && prevVel.x < 0 || vel.x < 0 && prevVel.x > 0 || vel.y > 0 && prevVel.y < 0 || vel.y < 0 && prevVel.y > 0) {
		
		float fx = abs(vel.x - prevVel.x);
		float fy = abs(vel.y - prevVel.y);
		float avg = (fx + fy) / 2;
		
		if (avg > 1.75) {
			
			bPlay = true;
			volume = ofMap(avg, 0.0, 10.0, 0.0, 1.0);

		}
		
	} else {
		
		bPlay = false;
		
	}

	prevVel.set(vel.x, vel.y);
	
}

//------------------------------------------------------------------
void sound::update(ofPoint p) {
	
	ofPoint pos;
	pos.set(p.x, p.y, 0.0);
	
	float vx = p.x - prevPos.x;
	float vy = p.y - prevPos.y;
	
	vel.set(vx, vy);
	
	if (vel.x > 0 && prevVel.x < 0 || vel.x < 0 && prevVel.x > 0 || vel.y > 0 && prevVel.y < 0 || vel.y < 0 && prevVel.y > 0) {
		
		float fx = abs(vel.x - prevVel.x);
		float fy = abs(vel.y - prevVel.y);
		float avg = (fx + fy) / 2;
		
		if (avg > 1.25) {
			
			bPlay = true;
			volume = ofMap(avg, 1.0, 10, 0.0, 1.0);
			
		}
		
	} else {
		
		bPlay = false;
		
	}
	
	prevPos.set(pos.x, pos.y, 0.0);
	prevVel.set(vel.x, vel.y);
	
}