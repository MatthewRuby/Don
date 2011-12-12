/*
 *  skin.cpp
 *  Dan
 *
 *  Created by Matt Ruby on 9/21/11.
 *  Copyright 2011. All rights reserved.
 *
 */

#include "skin.h"

//------------------------------------------------------------------
void skin::setup(float x, float y, string imageFile) {
	pos.set(x, y, 0);
	bodyPart.loadImage(imageFile);
	angle = 0;
	imageOffset.set(0, 0, 0);
	bScaleRotation = false;
	prevAngle = 0.0;
	scaledAngle = 0.0;
}

//------------------------------------------------------------------
void skin::update(float x1, float y1, float x2, float y2) {
	
	pos.set(x1, y1, 0);
	
	float dx = x1 - x2;
	float dy = y1 - y2;
	
	angle = atan2(dy, dx);
	
	scaledAngle = ((angle - prevAngle) * 7) + angle;
	
	prevAngle = angle;
	
}

//------------------------------------------------------------------
void skin::draw() {
	
	ofSetColor(255, 255, 255);
	
	if (bScaleRotation) {
		
		ofPushMatrix();
		
		ofTranslate(pos.x, pos.y, 0.0);
		
		ofRotateZ(scaledAngle * RAD_TO_DEG + imageOffset.z);
		
		bodyPart.draw( imageOffset.x, imageOffset.y);
		
		ofPopMatrix();
		
	} else {
		
		ofPushMatrix();
		
		ofTranslate(pos.x, pos.y, 0.0);
		
		ofRotateZ(angle * RAD_TO_DEG + imageOffset.z);
		
		bodyPart.draw( imageOffset.x, imageOffset.y);
		
		ofPopMatrix();
		
	}
	
}