//
//  DPUtility.m
//  Warblr
//
//  Created by Alex on 13/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "DPUtility.h"

static DPUtility *instance;

@implementation DPUtility

+ (DPUtility *)instance {
	if (instance == nil ) {
		instance = [[DPUtility alloc] init];
	}
	
	return instance;
}

- (NSString *)applicationSupportFolder {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]];
}

@end
