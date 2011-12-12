/*
 *  timePointRecorder.cpp
 *  drawingWithTime
 *
 *  Created by zachary lieberman on 9/21/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "timePointRecorder.h"

//-------------------------------------------------
void timePointRecorder::setup(){
	bRecording = false;
	playbackStartTime = 0;
}

//-------------------------------------------------
void timePointRecorder::clear(){
	pts.clear();
}

//-------------------------------------------------
void timePointRecorder::update(){
	
	if (bHaveADrawing()){
		
		float timeToCheck = ofGetElapsedTimef() - playbackStartTime;
		while (timeToCheck > getDuration() && getDuration() > 0){

			timeToCheck -= getDuration();
			
		}

		location = getPositionForTime(timeToCheck);
		velocity = getVelocityForTime(timeToCheck);
		
	}
}

//-------------------------------------------------
void timePointRecorder::draw(){
		
	ofSetColor(255,100,100,127);
	ofNoFill();
	ofSetLineWidth(1);
	
	ofBeginShape();
	for (int i = 0; i < pts.size();i++){
		ofVertex(pts[i].x, pts[i].y);
	}
	ofEndShape();
	
}

//-------------------------------------------------
void timePointRecorder::startDrawing(float x, float y){
	clear();
	bRecording = true;
	startTime = ofGetElapsedTimef();
	timePoint temp;
	temp.x = x;
	temp.y = y;
	temp.t = 0;
	pts.push_back(temp);
}

//-------------------------------------------------
void timePointRecorder::addPoint (float x, float y){
	timePoint temp;
	temp.x = x;
	temp.y = y;
	temp.t = ofGetElapsedTimef() - startTime;
	pts.push_back(temp);
}

//-------------------------------------------------
void timePointRecorder::addPointWTime (float x, float y){
	timePoint temp;
	temp.x = x;
	temp.y = y;
	temp.t = ofGetElapsedTimef() - startTime + 0.1;
	pts.push_back(temp);
}

//-------------------------------------------------
void timePointRecorder::endDrawing(){
	bRecording = false;
}

//-------------------------------------------------
bool timePointRecorder::bHaveADrawing(){
	if (bRecording == true){
		return false;
	} else if (pts.size() < 2){
		return false;
	}
	
	return true;
}

//-------------------------------------------------
float timePointRecorder::getDuration(){
	float duration = 0;
	if (bHaveADrawing() == true){
		duration =  pts[pts.size()-1].t;
	}
	return duration;
}

//-------------------------------------------------
ofPoint timePointRecorder::getPositionForTime( float time){

	if (bHaveADrawing() == false){
		return ofPoint(0,0,0);
	}

	ofPoint pos;
	
	for (int i = 0; i < pts.size()-1; i++){
		if (time >= pts[i].t && time <= pts[i+1].t){
 
			float part = time - pts[i].t;
			float whole = pts[i+1].t - pts[i].t;
			float pct = part / whole;

			pos.x = (1-pct) * pts[i].x + (pct) * pts[i+1].x;
			pos.y = (1-pct) * pts[i].y + (pct) * pts[i+1].y;
	
		}
	}
	
	return pos;
	
}

//-------------------------------------------------
ofPoint	timePointRecorder::getVelocityForTime( float time){

	ofPoint prevPt = getPositionForTime( MAX(time - 0.09f, 0));
	ofPoint currPt = getPositionForTime(time);
	
	ofPoint diff;
	diff.x = currPt.x - prevPt.x;
	diff.y = currPt.y - prevPt.y;
	
	return diff;
}

