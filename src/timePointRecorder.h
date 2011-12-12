
#ifndef TIME_POINT_RECORDER_H
#define TIME_POINT_RECORDER_H

#include "ofMain.h"

typedef struct{
	
	float x;
	float y;
	float t;
	
} timePoint;

//--------------------------------------------------
class timePointRecorder {

	public: 
	
		void		setup();
		void		clear();
		void		update();
		void		draw();
	
		void		startDrawing(float x, float y);
		void		addPoint (float x, float y);
		void		addPointWTime (float x, float y);
		void		endDrawing();
		
		ofPoint		getPositionForTime(float time);
		ofPoint		getVelocityForTime(float time);
		
		bool		bHaveADrawing();
		float		getDuration();
	

		vector < timePoint >	pts;
		float					startTime;
		bool					bRecording;
		float					playbackStartTime;
	
		ofPoint					location;
		ofPoint					velocity;
	
};



#endif