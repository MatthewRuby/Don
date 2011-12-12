#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "particle.h"
#include "spring.h"
#include "ofxXmlSettings.h"
#include "timePointRecorder.h"
#include "skin.h"
#include "sound.h"
#include "ofxALSoundPlayer.h"


class testApp : public ofxiPhoneApp {
	
	public:
		void setup();
		void update();
		void draw();
		
		void touchDown(ofTouchEventArgs &touch);
		void touchMoved(ofTouchEventArgs &touch);
		void touchUp(ofTouchEventArgs &touch);
		void touchDoubleTap(ofTouchEventArgs &touch);

	
		float				appIphoneScale;
		int					device;
		string				resolution;
		float				res_offset;

		ofxXmlSettings		XML;

		particle			joint[14];
		spring				bone[21];
		skin				body[14];
	
		ofPoint				shoulder[3];
		
		bool				bIsDrawing[13];
		ofPoint				isDrawing[13];
	
		timePointRecorder	TPR[13];
		bool				bTrack[13];
		int					whoAmITrack[13];

		sound				s[13];
		ofxALSoundPlayer	player[13];
	
	
		bool				bHaveDrawing;
	
		float				touchDist;
	
		ofPoint				infoBtnLoc;
		ofImage				infoBtn;
		bool				bShowInfo;
		int					randPoint;
	
		float				coverSize;
		float				coverIn;
		float				coverOut;
	
		ofTrueTypeFont		uniBlk;
		ofTrueTypeFont		uniLght;
		ofImage				floor;
};


