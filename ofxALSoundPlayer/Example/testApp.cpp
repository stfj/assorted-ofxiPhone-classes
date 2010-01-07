
#include "testApp.h"





//--------------------------------------------------------------
void testApp::setup(){	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	ofSetFrameRate(60);
	
	for(int i=0;i<10;i++)
	{
		synth[i].loadSound("synth.caf");
	}
	
	ofxALSoundPlayer::ofxALSoundPlayerSetListenerLocation(ofGetWidth()/2,0,ofGetHeight()/2);
	ofxALSoundPlayer::ofxALSoundPlayerSetReferenceDistance(10);
	ofxALSoundPlayer::ofxALSoundPlayerSetMaxDistance(500);
	ofxALSoundPlayer::ofxALSoundPlayerSetListenerGain(5.0);
	for(int i=0;i<5;i++)
	{
		audioLoc[i].set(-1,-1);
		audioSize[i]=0;
	}
	lastSoundPlayed=0;
}


//--------------------------------------------------------------
void testApp::update()
{
	for(int i=0;i<5;i++)
	{
		if(audioSize[i]>0 && audioSize[i]<ofGetHeight())
			audioSize[i]+=3;
	}
}

//--------------------------------------------------------------
void testApp::draw()
{
	ofNoFill();
	ofSetColor(50,50,200);
	ofCircle(ofGetWidth()/2, ofGetHeight()/2, 4);
	
	for(int i=0;i<5;i++)
	{
		ofSetColor(150+31*i,150+31*i,150+31*i);
		ofCircle(audioLoc[i].x, audioLoc[i].y, audioSize[i]);
	}
}

void testApp::exit() {
}


//--------------------------------------------------------------
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	
	audioLoc[touchId].set(x,y);
	audioSize[touchId]=1;
	
	lastSoundPlayed++;
	if(lastSoundPlayed>=10)
		lastSoundPlayed=0;
	
	
	synth[lastSoundPlayed].play();
	synth[lastSoundPlayed].setLocation(x, 0, y);
}

//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
}

//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
}

//--------------------------------------------------------------
void testApp::lostFocus()
{
}

//--------------------------------------------------------------
void testApp::gotFocus()
{
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning()
{
}

