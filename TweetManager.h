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
#import "CoreData.h"


@interface TweetManager : NSObject {
	MGTwitterEngine *twitterEngine;
	
	NSManagedObjectContext *managedObjectContext;
	NSEntityDescription *tweetEntityDescription;
	NSEntityDescription *userEntityDescription;
}

- (void)testClass;
- (TweetManager *)init;

@end
