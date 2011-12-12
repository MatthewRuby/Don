/*
 *  skin.h
 *  Dan
 *
 *  Created by Matt Ruby on 9/21/11.
 *  Copyright 2011. All rights reserved.
 *
 */
#ifndef _skin
#define _skin


#include "ofMain.h"

class skin {
	
	public:
		void setup(float x, float y, string imageFile);
		void update(float x1, float y1, float x2, float y2);
		void draw();
	
		ofImage		bodyPart;
		float		angle;
		ofPoint		pos;
	
		ofPoint		imageOffset;
	
		bool		bScaleRotation;
		float		scaledAngle;
		float		prevAngle;
};

#endif
