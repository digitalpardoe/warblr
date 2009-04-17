//
//  TweetManager.h
//  Warblr
//
//  Created by Alex on 09/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AccountDetails.h"
#import "MGTwitterEngine.h"
#import "DPCoreData.h"
#import "DPUtility.h"
#import "TweetManagerDelegate.h"


@interface TweetManager : NSObject {
	__weak NSObject <TweetManagerDelegate> *delegate;
	
	MGTwitterEngine *twitterEngine;
	
	NSManagedObjectContext *managedObjectContext;
	NSEntityDescription *tweetEntityDescription;
	NSEntityDescription *userEntityDescription;
}

- (void)getTweets;
- (TweetManager *)initWithDelegate:(NSObject *)theDelegate;

- (BOOL)isValidDelegateForSelector:(SEL)selector;

@end
