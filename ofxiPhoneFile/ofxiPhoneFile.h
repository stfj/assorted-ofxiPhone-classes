/*
 *  ofxiPhoneFile.h
 *  mobileFrameworks
 *
 *  Created by Zach Gage on 10/15/08.
 *  Copyright 2008 stfj. All rights reserved.
 *
 */

#ifndef OFX_IPHONE_FILE
#define OFX_IPHONE_FILE

#import "ofMain.h"
#include <fstream>

#define OFX_IPHONE_FILE_WRITE 0
#define OFX_IPHONE_FILE_READ 1

class ofxiPhoneFile
{
	public:
	
	ofxiPhoneFile();
	
	bool open(string fileName, int readWrite);
	bool openFromData(string fileName, int readWrite);
	bool openFromURL(string url);
	bool open(string fileName, int fileLen, int readWrite); // if you are trying to read in a giagantic file all at once, you may need to use this function and increase fileLen
	
	void close(); 
	
	char * read();
	char * readNextLine(); 
	char * readLine(int lineNum);
	
	bool write(string data);
	
	bool writeLine(string data);
	bool commitLines(); // if you have been using writeLine, you must commit the lines to the file using this function.
	
	NSString *filePath;
	
	NSString * file;
	NSArray *lines;
	
	char * fileData;
	char lineData[2000];
	string writtenLines;

	int maxFileLen;
	int numLines;
	
	bool verbose;
		
	int IO;
	
	private:
	
	int lastLineRead;
};

#endif