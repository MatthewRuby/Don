#ifndef SPRING_H
#define SPRING_H

#include "ofMain.h"
#include "ofxVectorMath.h"
#include "particle.h"

class spring {

	public:
		spring();
		
		particle * particleA;
		particle * particleB;
		
		float distance;
		float springiness;
	
		void update();	
};


#endif