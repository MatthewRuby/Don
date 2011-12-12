#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofRegisterTouchEvents(this);
	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);

 
	appIphoneScale = 1.0;

	ofSetFrameRate(60);
	ofSetCircleResolution(120);
	
	ofxALSoundPlayer::ofxALSoundPlayerSetListenerLocation(ofGetWidth()/2, 0,ofGetHeight()/2);
	ofxALSoundPlayer::ofxALSoundPlayerSetReferenceDistance(1);
	ofxALSoundPlayer::ofxALSoundPlayerSetMaxDistance(1);
	ofxALSoundPlayer::ofxALSoundPlayerSetListenerGain(100.0);

	for (int i = 0; i < 13; i++) {
		player[i].loadSound("0.caf");
	}
	
	if (ofGetWidth() == 768) {
		device = 1;	// iPad
		resolution = "hi_res/";
		touchDist = 25;
		res_offset = 200;
	} else if (ofGetWidth() == 640) {
		device = 2; // retina
		resolution = "lo_res/";
		touchDist = 15;
		res_offset = 84;
	} else if (ofGetWidth() == 320) {
		device = 3; // iPhone
		resolution = "lo_res/";
		touchDist = 15;
		res_offset = 84;
	} else {
		device = 0; // iPhone
		resolution = "lo_res/";
		touchDist = 15;
		res_offset = 84;
	}
	
	
	XML.loadFile(resolution + "body.xml");

	int numPointTags = XML.getNumTags("POINT");	
	
	for (int i = 0; i < numPointTags; i++) {
		
		XML.pushTag("POINT", i);
		
			float x	= (ofGetWidth()/2) + XML.getValue("X", 0);
			float y	= XML.getValue("Y", 0) + res_offset;
			
			joint[i].setInitialCondition(x, y, 0, 0);
		
		XML.popTag();
	}
	
	int numSpringTags = XML.getNumTags("SPRING");
	
	for (int i = 0; i < numSpringTags; i++) {
		
		XML.pushTag("SPRING", i);
		
		int _A	= XML.getValue("A", 0);
		int _B	= XML.getValue("B", 0);
		
		bone[i].distance	= XML.getValue("LENGTH", 0);
		bone[i].springiness	= 0.25f;
		bone[i].particleA = & (joint[ _A ]);
		bone[i].particleB = & (joint[ _B ]);
		
		XML.popTag();

	}



	shoulder[0].set(joint[0].pos.x, joint[0].pos.y, 0.0);
	shoulder[1].set(joint[3].pos.x, joint[3].pos.y, 0.0);
	shoulder[2].set(joint[13].pos.x, joint[13].pos.y, 0.0);

	
	for (int i=0; i < 13; i++) {
		
		bTrack[i] = false;		
		whoAmITrack[i] = 0;
		
		bIsDrawing[i] = false;
		isDrawing[i].set(0, 0, 0);
		
		TPR[i].setup();

	}

	
	body[0].setup(joint[0].pos.x, joint[0].pos.y, resolution + "body.png");
	body[1].setup(joint[0].pos.x, joint[0].pos.y, resolution + "right_bicep.png");
	body[2].setup(joint[1].pos.x, joint[1].pos.y, resolution + "right_foreArm.png");
	body[3].setup(joint[1].pos.x, joint[1].pos.y, resolution + "right_hand.png");
	body[4].setup(joint[3].pos.x, joint[3].pos.y, resolution + "left_bicep.png");
	body[5].setup(joint[4].pos.x, joint[4].pos.y, resolution + "left_foreArm.png");
	body[6].setup(joint[5].pos.x, joint[5].pos.y, resolution + "left_hand.png");
	body[7].setup(joint[6].pos.x, joint[6].pos.y, resolution + "right_thigh.png");
	body[8].setup(joint[7].pos.x, joint[7].pos.y, resolution + "right_shin.png");
	body[9].setup(joint[8].pos.x, joint[8].pos.y, resolution + "right_foot.png");
	body[10].setup(joint[9].pos.x, joint[9].pos.y, resolution + "left_thigh.png");
	body[11].setup(joint[10].pos.x, joint[10].pos.y, resolution + "left_shin.png");
	body[12].setup(joint[11].pos.x, joint[11].pos.y, resolution + "left_foot.png");
	body[13].setup(joint[12].pos.x, joint[12].pos.y, resolution + "head.png");
	
	body[3].bScaleRotation = true;
	body[6].bScaleRotation = true;
	body[9].bScaleRotation = true;
	body[12].bScaleRotation = true;
	body[13].bScaleRotation = true;
	
	if (device == 1) {
		body[0].imageOffset.set(-16, -40, 180);
		body[1].imageOffset.set(-32,-22, 90);
		body[2].imageOffset.set(-22,-22, 90);
		body[3].imageOffset.set(-22,-18, -90);
		body[4].imageOffset.set(-35,-22, 90);
		body[5].imageOffset.set(-22,-22, 90);
		body[6].imageOffset.set(-25,-18, -90);
		body[7].imageOffset.set(-28,-24, 90);
		body[8].imageOffset.set(-27,-20, 90);
		body[9].imageOffset.set(-44,-18, -90);
		body[10].imageOffset.set(-44,-24, 90);
		body[11].imageOffset.set(-27,-20, 90);
		body[12].imageOffset.set(-20,-18, -90);
		body[13].imageOffset.set(-38,-58, 90);
	} else {
		body[0].imageOffset.set(-7, -16, 180);
		body[1].imageOffset.set(-13,-9, 90);
		body[2].imageOffset.set(-9,-9, 90);
		body[3].imageOffset.set(-9,-8, -90);
		body[4].imageOffset.set(-15,-9, 90);
		body[5].imageOffset.set(-9,-9, 90);
		body[6].imageOffset.set(-11,-8, -90);
		body[7].imageOffset.set(-10,-10, 90);
		body[8].imageOffset.set(-11,-8, 90);
		body[9].imageOffset.set(-18,-8, -90);
		body[10].imageOffset.set(-20,-10, 90);
		body[11].imageOffset.set(-12,-8, 90);
		body[12].imageOffset.set(-9,-8, -90);
		body[13].imageOffset.set(-17,-24, 90);
	}


	bHaveDrawing = false;
	bShowInfo = false;
	

	infoBtn.loadImage(resolution + "info.png");
	infoBtnLoc.set((infoBtn.width / 2) + 10, ofGetHeight() - ((infoBtn.height / 2) + 10), 0.0);
	
	coverSize = 0;
	coverIn = -ofGetHeight();
	coverOut = 0;
	
	if (device == 1) {
		uniBlk.loadFont("universblack.ttf", 24);
		uniLght.loadFont("universlight.ttf", 14);
		floor.loadImage(resolution + "floor.png");
	} else {
		uniBlk.loadFont("universblack.ttf", 14);
		uniLght.loadFont("universlight.ttf", 10);
		floor.loadImage(resolution + "floor.png");
	}

}


//--------------------------------------------------------------
void testApp::update(){
		
	for (int i = 0; i < 14; i++){
		joint[i].resetForce();
	}

	if (!bHaveDrawing) {
		
		for (int i = 0; i < 14; i++){
			joint[i].addForce(0.0, 0.1);
		}
		
		joint[0].anchor(shoulder[0]);
		joint[3].anchor(shoulder[1]);
		joint[13].anchor(shoulder[2]);
		
	} else {
		
		for (int i = 0; i < 14; i++){
			joint[i].addForce(0.0, 0.01);
		}
		
	}
	
	for (int i = 0; i < 13; i++){
		
		if (bIsDrawing[i]) {

			joint[i].follow(isDrawing[i].x, isDrawing[i].y);
			
			s[i].update(isDrawing[i]);
			
			if (s[i].bPlay) {
				player[i].stop();
				player[i].play();
			}
			
		}
		
		if (TPR[i].bHaveADrawing()) {

			joint[i].follow(TPR[i].location.x, TPR[i].location.y);
			
			s[i].update(joint[i].vel);
			
			if (s[i].bPlay) {
				player[i].stop();
				player[i].play();
			}
		}
		
		TPR[i].update();
	}
	
	
	
	for (int i = 0; i < 21; i++){
		bone[i].update();
	}
	
	
	for (int i = 0; i < 14; i++){
		joint[i].addDampingForce();
		joint[i].update();
	}
	

	body[0].update(joint[0].pos.x, joint[0].pos.y, joint[3].pos.x, joint[3].pos.y);
	body[1].update(joint[0].pos.x, joint[0].pos.y, joint[1].pos.x, joint[1].pos.y);
	body[2].update(joint[1].pos.x, joint[1].pos.y, joint[2].pos.x, joint[2].pos.y);
	body[3].update(joint[2].pos.x, joint[2].pos.y, joint[1].pos.x, joint[1].pos.y);
	body[4].update(joint[3].pos.x, joint[3].pos.y, joint[4].pos.x, joint[4].pos.y);
	body[5].update(joint[4].pos.x, joint[4].pos.y, joint[5].pos.x, joint[5].pos.y);
	body[6].update(joint[5].pos.x, joint[5].pos.y, joint[4].pos.x, joint[4].pos.y);
	
	body[7].update(joint[6].pos.x, joint[6].pos.y, joint[7].pos.x, joint[7].pos.y);
	body[8].update(joint[7].pos.x, joint[7].pos.y, joint[8].pos.x, joint[8].pos.y);
	body[9].update(joint[8].pos.x, joint[8].pos.y, joint[7].pos.x, joint[7].pos.y);

	body[10].update(joint[9].pos.x, joint[9].pos.y, joint[10].pos.x, joint[10].pos.y);
	body[11].update(joint[10].pos.x, joint[10].pos.y, joint[11].pos.x, joint[11].pos.y);
	body[12].update(joint[11].pos.x, joint[11].pos.y, joint[10].pos.x, joint[10].pos.y);
	
	body[13].update(joint[12].pos.x, joint[12].pos.y, joint[13].pos.x, joint[13].pos.y);


}

//--------------------------------------------------------------
void testApp::draw(){
	ofScale(appIphoneScale, appIphoneScale, 1.0);
	ofBackground(255, 255, 255);
	ofEnableSmoothing();
	ofEnableAlphaBlending();
	
	
	ofSetColor(160, 160, 160);
	int fw = floor.width / 2;
	int fh = floor.height;
	if (device == 1) {
		floor.draw(ofGetWidth() / 2 - fw, ofGetHeight() - fh - (ofGetHeight() / 10));
	} else {
		floor.draw(ofGetWidth() / 2 - fw, ofGetHeight() - fh - (ofGetHeight() / 8));
	}

	
	int iw = infoBtn.width / 2;
	int ih = infoBtn.height / 2;
	infoBtn.draw(infoBtnLoc.x - iw, infoBtnLoc.y - ih);
	
	
	if (bShowInfo) {

		if (abs(coverSize - coverIn) < 25) {
			
			for (int i = 0; i < 13; i++) {
				
				if (bIsDrawing[i]) {
					
					TPR[i].draw();
					
				}
			}
		}
	}


	body[0].draw();		// body
	body[13].draw();	// head
	
	body[7].draw();		// thigh
	body[8].draw();		// shin
	body[9].draw();		// foot
	
		
	body[10].draw();	// thigh
	body[11].draw();	// shin
	body[12].draw();	// foot
	

	body[1].draw();
	body[4].draw();

	body[2].draw();
	body[5].draw();

	body[3].draw();
	body[6].draw();
	
	
	if (bShowInfo) {
		
		if (abs(coverSize - coverIn) > 1) {
			coverSize = 0.2 * coverIn + (1 - 0.2) * coverSize;
		}
		
		ofFill();
		ofSetColor(0, 0, 100, 35);
		ofRect(0, ofGetHeight(), ofGetWidth(), coverSize);

		if (abs(coverSize - coverIn) < 25) {

			for (int i = 0; i < 13; i++) {
				
				if (bIsDrawing[i]) {
					ofFill();
					ofSetColor(255, 0, 0, 127);
				} else {
					ofNoFill();
					ofSetColor(0, 0, 255, 100);
					ofSetLineWidth(1);
				}			
				ofCircle(joint[i].pos.x, joint[i].pos.y, touchDist);
			}
			
			
			ofSetColor(0, 0, 0, 127);
			
			if (!bHaveDrawing) {
				
				ofSetLineWidth(1);
				ofLine(45, 45, joint[randPoint].pos.x , joint[randPoint].pos.y);
				
			}
			
			
			if (device == 1) {
				
				uniBlk.drawString("Drag the handles to record movement.", 20, 40);
				
				uniBlk.drawString("Double-Tap to reset.", 20, ofGetHeight() - (ofGetHeight() / 9));

				uniLght.drawString("created by Matt Ruby, Brooklyn, NY 2011.", 120, ofGetHeight() - 36);
				uniLght.drawString("For more info visit: www.matt-ruby.com", 120, ofGetHeight() - 12);
								  
			} else {
				
				uniBlk.drawString("Drag the handles to", 10, 20);
				uniBlk.drawString("record movement.", 10, 40);
				
				uniBlk.drawString("Double-Tap to reset.", 10, ofGetHeight() - (ofGetHeight() / 7));
				
				uniLght.drawString("created by Matt Ruby, Brooklyn, NY 2011.", 60, ofGetHeight() - 28);
				uniLght.drawString("For more info visit: www.matt-ruby.com", 60, ofGetHeight() - 12);
				
								  
			}
			
		}

	} else {
		
		if (abs(coverSize - coverOut) > 1) {
			coverSize = 0.2 * coverOut + (1 - 0.2) * coverSize;
		}
			
		ofFill();
		ofSetColor(0, 0, 0, 45);
		ofRect(0, ofGetHeight(), ofGetWidth(), coverSize);	
		
	}
	
	
	ofDisableAlphaBlending();
	ofDisableSmoothing();
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

	if (abs(touch.x - infoBtnLoc.x) < infoBtn.width / 2 && abs(touch.y - infoBtnLoc.y) < infoBtn.width / 2) {
		
		randPoint = ofRandom(0, 13);
		
		bShowInfo = !bShowInfo;
		
	} else {

		for (int i = 0; i < 13; i++){
			
			if (abs(touch.x - joint[i].pos.x) < touchDist && abs(touch.y - joint[i].pos.y) < touchDist) {
					
				bTrack[i] = true;
				whoAmITrack[i] = touch.id;
				
				if (touch.id == whoAmITrack[i]) {
				
					bHaveDrawing = true;
					
					bIsDrawing[i] = true;
					
					isDrawing[i].set(touch.x, touch.y, 0);
					
					TPR[i].startDrawing(touch.x, touch.y);
					
				}
				
			}
			
		}
		
	}
		

	
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){

		
		for (int i = 0; i < 13; i++){
			
			if (bTrack[i] == true && touch.id == whoAmITrack[i] && bIsDrawing[i]) {
				
				isDrawing[i].set(touch.x, touch.y, 0);
				
				TPR[i].addPoint(touch.x,touch.y);
				
			}
			
		}
		

	
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

			
	for (int i = 0; i < 13; i++){
		if (bTrack[i] == true && bIsDrawing[i]) {

			float tempX = TPR[i].pts[TPR[i].pts.size()-1].x;
			float tempY = TPR[i].pts[TPR[i].pts.size()-1].y;
			
			
			while(abs(tempX - TPR[i].pts[0].x) > 1 && abs(tempY - TPR[i].pts[0].y) > 1) {
				
				tempX = 0.9 * TPR[i].pts[0].x + (1 - 0.9) * tempX; 
				tempY = 0.9 * TPR[i].pts[0].y + (1 - 0.9) * tempY; 
				
				TPR[i].addPointWTime(tempX, tempY);
			}
			
			TPR[i].endDrawing();
			TPR[i].playbackStartTime = ofGetElapsedTimef();
			bIsDrawing[i] = false;

		}
		
		bTrack[i] = false;
		
	}

	
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

	for (int i = 0; i < 13; i++){
		TPR[i].clear();
		bHaveDrawing = false;
	}
	
}
