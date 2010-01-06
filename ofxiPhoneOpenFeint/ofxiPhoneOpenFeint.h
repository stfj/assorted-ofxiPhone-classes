/*
 *  ofxiPhoneOpenFeint.h
 *  Unify
 *
 *  Created by Zach Gage on 8/10/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */

#import "OpenFeint.h"
#import "OFHighScoreService.h"
#import "OFAchievementService.h"

#import "ofMain.h"
#pragma once

class cppOFOpenFeintDelegate
{
	public:
		virtual void setOpenBool(bool o) = 0;
};

@interface ofxiPhoneOpenFeintDelegate : NSObject <OpenFeintDelegate>
{	
	cppOFOpenFeintDelegate * cppDel;
}
- (void) dashboardWillAppear;
- (void) dashboardDidAppear;
- (void) dashboardWillDisappear;
- (void) dashboardDidDisappear;
- (void)userLoggedIn:(NSString*)userId;
- (BOOL)showCustomOpenFeintApprovalScreen;


@end

class ofxiPhoneOpenFeint : public cppOFOpenFeintDelegate
{
		
	public:
		
		ofxiPhoneOpenFeint();
		~ofxiPhoneOpenFeint();
		
		void approveOpenFeint();
		void open();
		void setOpenBool(bool o);
	
		void connect();
	
		void setActive(bool p);
	
		void submitHighscore(int score, int _id);
		void getAchievement(int _id);
	
		bool isOpen;
		
	protected:
		
		ofxiPhoneOpenFeintDelegate * openFeint;
	
		NSString * stringToNSString(string s);
	
		bool connected;
};