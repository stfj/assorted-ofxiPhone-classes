/*
 *  ofxiPhoneImagePicker.h
 *  iPhone UIImagePicker Example
 *
 *  Created by Zach Gage on 3/1/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */
#pragma once

#import <GameKit/GameKit.h>
#import "ofMain.h"

#define OFX_GAMEKIT_CANCELED 1
#define OFX_GAMEKIT_CONNECTED 2
#define OFX_GAMEKIT_DISCONNECTED 3


class ofxiPhoneGameKitDelegate
{
	public:
		virtual void recievedData(const void * data, int dataLength) = 0;
};

class ofxiPhoneGameKit;

@interface ofxiPhoneGameKitObjCDelegate : NSObject <GKPeerPickerControllerDelegate, GKSessionDelegate>
{
	//GKPeerPickerController *mPicker;
	GKSession *mSession;
	NSMutableArray *mPeers;
	NSString * sessionName;
	
	ofxiPhoneGameKitDelegate * cppDelegate;
	ofxiPhoneGameKit * gameKit;
	
	float myCoinFlipNumber; //for deciding who is server;
	bool coinFlipComplete;
}

- (id) initWithDelegate:(ofxiPhoneGameKitDelegate *) _cppDelegate andGameKit:(ofxiPhoneGameKit *)_gameKit;
- (id) initWithDelegate:(ofxiPhoneGameKitDelegate *) _cppDelegate andGameKit:(ofxiPhoneGameKit *)_gameKit andName:(string)name;

- (void) sendData:(NSData *)dataToSend;
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type;
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID;
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state;

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session;
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker;

- (void)disconnect;

- (void) showPeerPicker;

@property (retain) GKSession *mSession;

@end


class ofxiPhoneGameKit
{
	
	public:
		
		ofxiPhoneGameKit();
		~ofxiPhoneGameKit();
		
		void addListener(ofxiPhoneGameKitDelegate * delegate);
		void addListener(ofxiPhoneGameKitDelegate * delegate, string name);
		bool sendData(void * data, int length);
	
		void showPeerPicker();
	
		bool isConnected();
		bool isPeerPickerOpen();
		bool isServer();
		
		void setConnected(bool b);
		void setPeerPickerOpen(bool b);
		void setServer(bool s);
		void setReady(bool r);
		bool isReady();
		void disconnect();
		
	protected:
		
		ofxiPhoneGameKitObjCDelegate * gameKit;
		bool connected;
		bool peerPickerOpen;
		bool server;
		bool readyToSendData;
};
