/*
 *  ofxiPhoneAnayltics.mm
 *  sws023
 *
 *  Created by Zach Gage on 1/5/10.
 *  Copyright 2010 stfj. All rights reserved.
 *
 */

#include "ofxiPhoneFlurryAnalytics.h"

ofxiPhoneFlurryAnalytics::ofxiPhoneAnalytics(NSString * appId)// log in
{
	[FlurryAPI startSession:appId];
}

void ofxiPhoneFlurryAnalytics::logEvent(NSString * eventName)
{
	[FlurryAPI logEvent:eventName];
}

void ofxiPhoneFlurryAnalytics::logEventWithVar(NSString * eventName, NSString * varName, float varValue)
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObject: [NSNumber numberWithFloat:varValue] forKey: varName];
	
	[FlurryAPI logEvent: eventName withParameters: dictionary];
}


