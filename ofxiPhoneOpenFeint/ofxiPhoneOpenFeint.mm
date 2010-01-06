/*
 *  ofxiPhoneOpenFeint.cpp
 *  Unify
 *
 *  Created by Zach Gage on 8/10/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */

#include "ofxiPhoneOpenFeint.h"

ofxiPhoneOpenFeint::ofxiPhoneOpenFeint()
{
	isOpen=false;	
	connected = false;
	openFeint = [[NSObject init] alloc];
}

ofxiPhoneOpenFeint::~ofxiPhoneOpenFeint()
{
	[openFeint release];
}

void ofxiPhoneOpenFeint::connect()
{
	if(!connected)
	{
		[OpenFeint initializeWithProductKey:@"YOUR KEY HERE" andSecret:@"YOUR SECRET HERE" andDisplayName:@"YOUR APP NAME HERE" andSettings:nil andDelegate:openFeint];
		[OpenFeint setDashboardOrientation:UIInterfaceOrientationLandscapeRight]; // you will probably want to change this for your app orientation
		connected=true;
	}
	else
	{
		open();
	}
}

void ofxiPhoneOpenFeint::setActive(bool p)
{
	if(p)
	{
		[OpenFeint applicationWillResignActive];
	}
	else
	{
		[OpenFeint applicationDidBecomeActive];
	}
}

void ofxiPhoneOpenFeint::approveOpenFeint()
{
	[OpenFeint userDidApproveFeint:YES];
}

void ofxiPhoneOpenFeint::setOpenBool(bool o)
{
	isOpen = o;
}

void ofxiPhoneOpenFeint::open()
{
	[OpenFeint launchDashboardWithDelegate: openFeint];
}

void ofxiPhoneOpenFeint::submitHighscore(int score, int _id)
{
	[OFHighScoreService setHighScore:score forLeaderboard:stringToNSString(ofToString(_id)) onSuccess:OFDelegate() onFailure:OFDelegate()];
}

void ofxiPhoneOpenFeint::getAchievement(int _id)
{
	[OFAchievementService unlockAchievement: stringToNSString(ofToString(_id))];
}

NSString * ofxiPhoneOpenFeint::stringToNSString(string s)
{
	return [[[NSString alloc] initWithCString: s.c_str()] autorelease];
}

// CLASS IMPLEMENTATIONS--------------objc------------------------
//----------------------------------------------------------------
@implementation ofxiPhoneOpenFeintDelegate
- (void) dashboardWillAppear
{
	cppDel->setOpenBool(true);
}
- (void) dashboardDidAppear{}
- (void) dashboardWillDisappear{}
- (void) dashboardDidDisappear
{
	cppDel->setOpenBool(false);
}
- (void)userLoggedIn:(NSString*)userId{}

- (BOOL)showCustomOpenFeintApprovalScreen
{
	return YES;
}

@end