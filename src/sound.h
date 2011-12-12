/*
 *  sound.h
 *  Dan
 *
 *  Created by Matt Ruby on 9/22/11.
 *  Copyright 2011. All rights reserved.
 *
 */
#ifndef _sound
#define _sound


#include "ofMain.h"
#include "ofxVectorMath.h"

class sound {
	
	public:
		sound();
		void update(ofxVec2f v);
		void update(ofPoint p);
	
		ofxVec2f	vel;
		ofxVec2f	prevVel;

		ofPoint		prevPos;
	
		float		volume;
		bool		bPlay;
};

#endif