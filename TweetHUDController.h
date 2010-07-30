//
//  TweetHUDController.h
//  Warblr
//
//  Created by Alex on 14/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AutoHyperlinks/AutoHyperlinks.h>
#import "TweetHUDWindowController.h"
#import "MGTwitterEngine.h"
#import "AccountDetails.h"


@interface TweetHUDController : NSObject {
	IBOutlet NSTextView *messageArea;
	IBOutlet NSTextField *characterCount;
	IBOutlet NSButton *closeButton;
	IBOutlet NSButton *tweetButton;
}

- (IBAction)close:(id)sender;
- (IBAction)tweet:(id)sender;

@end
