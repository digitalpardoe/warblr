//
//  TweetHUDController.h
//  Warblr
//
//  Created by Alex on 14/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BGHUDAppKit/BGHUDAppKit.h>
#import "WindowController.h"


@interface TweetHUDController : NSObject {
	IBOutlet NSTextField *messageArea;
	IBOutlet BGHUDLabel *characterCount;
	IBOutlet NSButton *closeButton;
	IBOutlet NSButton *tweetButton;
}

- (IBAction)close:(id)sender;
- (IBAction)tweet:(id)sender;

@end
