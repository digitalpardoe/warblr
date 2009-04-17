//
//  TimelineController.h
//  Warblr
//
//  Created by Alex on 13/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "TimelineWindowController.h"
#import "TemplateProcessor.h"
#import "DPCoreData.h"
#import "TweetManager.h"


@interface TimelineController : NSObject {
	IBOutlet WebView *webView;
}

- (void)showTweets;

- (IBAction)getNewTweets:(id)sender;

@end
