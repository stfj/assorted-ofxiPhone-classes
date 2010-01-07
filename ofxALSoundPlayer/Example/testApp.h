#ifndef _TEST_APP
#define _TEST_APP

#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxALSoundPlayer.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();

	void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data);
	void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data);
	void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data);
	void touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data);
	
	void exit();
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	
	ofxALSoundPlayer synth[10]; //load in 10 instances so that they can be played multiple times (sort of). Right now ofxALSoundPlayer doesn't work with multiPlay
	int lastSoundPlayed; //counter to keep track of which sound we're playing
	
	ofPoint audioLoc[5]; // one for each possible touch ID
	int audioSize[5];
	
};

#endif

