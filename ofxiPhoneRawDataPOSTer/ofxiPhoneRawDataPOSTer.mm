/*
 *  ofxiPhoneRawDataPOSTer.cpp
 *  sws021
 *
 *  Created by Zach Gage on 12/7/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */

#include "ofxiPhoneRawDataPOSTer.h"

ofxiPhoneRawDataPOSTer::ofxiPhoneRawDataPOSTer()
{
	posting = false;
	failed = false;
	
	urlDelegate = [[UrlDelegate alloc] initWithDelegate:this];
}

void ofxiPhoneRawDataPOSTer::postData(string url, string data)
{
	if(!posting)
	{
		failed = false;
		posting = true;
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[[[NSString alloc] initWithCString: url.c_str()] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] autorelease]]];     
		NSString *httpBody =  [[[[NSString alloc] initWithCString: data.c_str()] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] autorelease];
		
		aData = [httpBody dataUsingEncoding:NSUTF8StringEncoding]; //NSUTF8StringEncoding
		[request setHTTPBody:aData];
		[request setHTTPMethod:@"POST"];
		uploadPageURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:urlDelegate startImmediately:YES];
		
		receivedData=[[NSMutableData data] retain];
		[receivedData setLength:0];

		/*NSString *data=[[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding] autorelease]; 
		
		char response[ [data length]+1 ];
		[data getCString:response];
		
		
		return string(response);*/
	}
}

void ofxiPhoneRawDataPOSTer::finished()
{
	cout<<"finished!"<<endl;
	[request release];
	[aData release];
	[uploadPageURLConnection release];
	char responseChars[[receivedData length]];
	memcpy(&responseChars,[receivedData mutableBytes],[receivedData length]);
	
	response = string(responseChars);
	response = response.substr(1,response.length()-1);
	[receivedData release];
	posting = false;
	failed = false;
}


//--------------------------------------------------

@implementation UrlDelegate

- (id) initWithDelegate:(ofxiPhoneRawDataPOSTer *) _cppDelegate
{
	if(self = [super init])
	{
		cppDelegate = _cppDelegate;
	}
	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [cppDelegate->receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	/*
	NSString *data = [response query];
	
	data = [data stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	
	char cResponse[ [data length]+1 ];
	[data getCString:cResponse];
	
	cppDelegate->response = cResponse;
	
	NSLog(response);*/
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	cppDelegate->failed = true;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	cppDelegate->finished();
}

@end