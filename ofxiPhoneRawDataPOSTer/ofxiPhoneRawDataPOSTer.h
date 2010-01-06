/*
 *  ofxiPhoneRawDataPOSTer.h
 *  sws021
 *
 *  Created by Zach Gage on 12/7/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"

class ofxiPhoneRawDataPOSTer;

@interface UrlDelegate : NSObject
{
	ofxiPhoneRawDataPOSTer * cppDelegate;
}

- (id) initWithDelegate:(ofxiPhoneRawDataPOSTer *) _cppDelegate;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end

//-----------------------------


class ofxiPhoneRawDataPOSTer
{
public:
	
	ofxiPhoneRawDataPOSTer();
	
	void postData(string url, string data);
	
	void finished();
	
	bool failed;
	
	bool posting;
	string response;
	
	NSMutableURLRequest *request;
	NSData *aData;
	NSData *urlData;
	NSURLConnection * uploadPageURLConnection;
	NSMutableData * receivedData;
	
	UrlDelegate * urlDelegate;
};