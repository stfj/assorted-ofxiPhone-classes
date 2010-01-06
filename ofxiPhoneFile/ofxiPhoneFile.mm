/*
 *  ofxiPhoneFile.mm
 *  mobileFrameworks
 *
 *  Created by Zach Gage on 10/15/08.
 *  Copyright 2008 stfj. All rights reserved.
 *
 */

#include "ofxiPhoneFile.h"

ofxiPhoneFile::ofxiPhoneFile()
{
	IO=-1;
	writtenLines = "";
	verbose = false;
}

bool ofxiPhoneFile::openFromData(string fileName, int readWrite)
{
	if(IO==-1)
	{
		NSArray *foundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //find a path to the documents directory
		NSString *documents = [foundPaths objectAtIndex:0]; //store the path
		if (documents == nil)
		{ 
			printf("Error: couldn't fine documents folder");
			[foundPaths release];
			return false;
		}
		
		//NSString * fn = [[NSString alloc] initWithCString: fileName.c_str()];
		filePath = [[NSString alloc] initWithCString: ofToDataPath(fileName).c_str()];
		//[documents stringByAppendingPathComponent:fn]; //append the file name to the end of the path to make the path to the file!
		//[fn release];
		
		maxFileLen = 5000;
		
		lastLineRead=0;
		
		fileData = new char[maxFileLen];
		
		
		if(readWrite == OFX_IPHONE_FILE_READ)
		{
			file = [NSString stringWithContentsOfFile: filePath];
			
			
			//[file UTF8String: fileString];
			//[file cStringUsingEncoding:NSASCIIStringEncoding];
			
			if(file==nil)
			{
				cout<<"Error: "<<fileName<<" does not exist"<<endl;
				//printf("Error: file does not exist");
				//delete[] fileData;
				return false;
			}
			
			//[file release];
			//file = [[NSString alloc] init];
			//[file getCString: fileString]; //need to find a better solution here as this throws EXC_BAD_ACCESS :(
			[file getCString:fileData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
			
			if(fileData=="")
			{
				printf("Error: file is empty");
				//[file release];
				return false;
			}
			
			lines = [file componentsSeparatedByString:@"\n"];
			numLines = [lines count];
			
			IO=OFX_IPHONE_FILE_READ;
			
			//[filePath release];
			//[foundPaths release];
			//[documents release];
			return true;
			
		}
		else if(readWrite == OFX_IPHONE_FILE_WRITE)
		{
			IO=OFX_IPHONE_FILE_WRITE;
			/*[filePath release];
			 [foundPaths release];
			 [documents release];*/
			return true;
		}
		else
		{
			/*[filePath release];
			 [foundPaths release];
			 [documents release];*/
			printf("Error: you must pass MF_FILE_READ or MF_FILE_WRITE to the mfFile.open() statement");
			return false;
		}
	}
	else
	{
		printf("Error: please close your mfFile before opening a new file");
	}
	return false;
}

bool ofxiPhoneFile::openFromURL(string url)
{
	if(IO==-1)
	{
		maxFileLen = 5000;
		
		lastLineRead=0;
		
		fileData = new char[maxFileLen];
		
		filePath = [[NSString alloc] initWithCString: url.c_str()];
		file = [NSString stringWithContentsOfURL:[NSURL URLWithString:filePath]];
		
		file = [file stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		//cout<<filePath<<endl;
		
		//file = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://stfj.net/misc/example50.txt"]];	
//		while (file==nil) {
//			cout<<".";
//		}
		//NSLog(file);
		//[file UTF8String: fileString];
		//[file cStringUsingEncoding:NSASCIIStringEncoding];
		
		if(file==nil)
		{
			cout<<"Error: "<<url<<" does not exist"<<endl;
			//printf("Error: file does not exist");
			//delete[] fileData;
			return false;
		}
		
		
		[file getCString:fileData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
		
		if(fileData=="")
		{
			printf("Error: file is empty");
			//[file release];
			return false;
		}
		
		lines = [file componentsSeparatedByString:@"\n"];
		numLines = [lines count];
		
		IO=OFX_IPHONE_FILE_READ;
		
		return true;
			
		
	}
	else
	{
		printf("Error: please close your mfFile before opening a new file");
	}
	return false;
}

bool ofxiPhoneFile::open(string fileName, int readWrite)
{
	if(IO==-1)
	{
		NSArray *foundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //find a path to the documents directory
		NSString *documents = [foundPaths objectAtIndex:0]; //store the path
		if (documents == nil)
		{ 
			printf("Error: couldn't fine documents folder");
			[foundPaths release];
			return false;
		}
		
		NSString * fn = [[NSString alloc] initWithCString: fileName.c_str()];
		filePath = [documents stringByAppendingPathComponent:fn]; //append the file name to the end of the path to make the path to the file!
		[fn release];
		
		maxFileLen = 5000;
		
		lastLineRead=0;
		
		fileData = new char[maxFileLen];
		
		
		if(readWrite == OFX_IPHONE_FILE_READ)
		{
			file = [NSString stringWithContentsOfFile: filePath];
			
			
			//[file UTF8String: fileString];
			//[file cStringUsingEncoding:NSASCIIStringEncoding];
			
			if(file==nil)
			{
				cout<<"Error: "<<fileName<<" does not exist"<<endl;
				//printf("Error: file does not exist");
				//delete[] fileData;
				return false;
			}
			
			//[file release];
			//file = [[NSString alloc] init];
			//[file getCString: fileString]; //need to find a better solution here as this throws EXC_BAD_ACCESS :(
			[file getCString:fileData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
			
			if(fileData=="")
			{
				printf("Error: file is empty");
				//[file release];
				return false;
			}
			
			lines = [file componentsSeparatedByString:@"\n"];
			numLines = [lines count];
			
			IO=OFX_IPHONE_FILE_READ;
			
			//[filePath release];
			//[foundPaths release];
			//[documents release];
			return true;
			
		}
		else if(readWrite == OFX_IPHONE_FILE_WRITE)
		{
			IO=OFX_IPHONE_FILE_WRITE;
			/*[filePath release];
			[foundPaths release];
			[documents release];*/
			return true;
		}
		else
		{
			/*[filePath release];
			[foundPaths release];
			[documents release];*/
			printf("Error: you must pass MF_FILE_READ or MF_FILE_WRITE to the mfFile.open() statement");
			return false;
		}
	}
	else
	{
		printf("Error: please close your mfFile before opening a new file");
	}
	return false;
}


bool ofxiPhoneFile::open(string fileName, int fileLen, int readWrite)
{
	if(IO==-1)
	{
		NSArray *foundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //find a path to the documents directory
		NSString *documents = [foundPaths objectAtIndex:0]; //store the path
		if (documents == nil)
		{ 
			printf("Error: couldn't fine documents folder");
			return false;
		} 
		
		NSString * fn = [[NSString alloc] initWithCString: fileName.c_str()];
		filePath = [documents stringByAppendingPathComponent:fn]; //append the file name to the end of the path to make the path to the file!
		[fn release];
		
		lastLineRead=0;
		
		maxFileLen = fileLen;
		fileData = new char[maxFileLen];
		
		if(readWrite == OFX_IPHONE_FILE_READ)
		{
			file = [NSString stringWithContentsOfFile: filePath];
			
			
			//[file UTF8String: fileString];
			//[file cStringUsingEncoding:NSASCIIStringEncoding];
			
			if(file==nil)
			{
				printf("File doesnt exist yet");
				return false;
			}
			
			//[file getCString: fileString]; //need to find a better solution here as this throws EXC_BAD_ACCESS :(
			[file getCString:fileData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
			
			if(fileData=="")
			{
				printf("file is empty or does not exist yet");
				//delete[] fileData;
				return false;
			}
			
			lines = [file componentsSeparatedByString:@"\n"];
			numLines = [lines count];
			return true;
		}
		else if(readWrite == OFX_IPHONE_FILE_WRITE)
		{
			return true;
		}
		else
		{
			printf("Error: you must pass MF_FILE_READ or MF_FILE_WRITE to the mfFile.open() statement");
			return false;
		}
	}
	else
	{
		printf("Error: please close your mfFile before opening a new file");
	}
	return false;
}

char * ofxiPhoneFile::read()
{	
	if(IO==OFX_IPHONE_FILE_READ)
	{
		return fileData;
	}
	else
	{
		printf("Error: mfFile set to write");
		return "";
	}
}

char * ofxiPhoneFile::readNextLine() 
{
	if(IO==OFX_IPHONE_FILE_READ)
	{
		lastLineRead++;
		
		if(lastLineRead>=numLines)
		{
			return "";
		}

		NSString * temp = [lines objectAtIndex:lastLineRead];
		[temp getCString:lineData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
		
		if(verbose)
			cout<<lineData<<endl;
		
		return lineData;
	}
	else
	{
		printf("Error: mfFile set to write");
		return "";
	}
}

char * ofxiPhoneFile::readLine(int lineNum)
{
	if(IO==OFX_IPHONE_FILE_READ)
	{
		if(lineNum>=numLines)
		{
			return "";
		}
		else
		{
		NSString * temp = [lines objectAtIndex:lineNum];
		[temp getCString:lineData maxLength:maxFileLen-1 encoding:NSASCIIStringEncoding];
			
		lastLineRead = lineNum;
			
		if(verbose)
			cout<<lineData<<endl;
		
		return lineData;
		}
	}
	else
	{
		printf("Error: mfFile set to write");
		return "";
	}

}

bool ofxiPhoneFile::write(string data)
{

	if(IO==OFX_IPHONE_FILE_WRITE)
	{
		NSString * dataNSString = [[NSString alloc] initWithCString: data.c_str()];
		
		
		if (![dataNSString writeToFile: filePath atomically:YES])
		{
			return false;
		}
		
		[dataNSString release];
		
		return true;
	}
	else
	{
		printf("Error: mfFile set to read");
		return false;
	}
}

bool ofxiPhoneFile::writeLine(string data)
{
	if(IO==OFX_IPHONE_FILE_WRITE)
	{
		writtenLines += data+"\n";
		
		return true;
	}
	else
	{
		printf("Error: mfFile set to read");
		return false;
	}
}

bool ofxiPhoneFile::commitLines()
{
	return write(writtenLines);
}

void ofxiPhoneFile::close()
{
	//[filePath release];
	//[file release];
	//[lines release];
	//delete[] fileData;
	IO=-1;
	writtenLines="";
}