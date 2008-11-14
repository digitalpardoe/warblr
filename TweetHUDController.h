//
//  TweetHUDController.h
//  Warblr
//
//  Created by Alex on 14/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BGHUDAppKit/BGHUDAppKit.h>


@interface TweetHUDController : NSObject {
	IBOutlet NSTextField *messagePane;
	IBOutlet BGHUDLabel *characterCount;
	IBOutlet NSButton *cancelButton;
	IBOutlet NSButton *tweetButton;
}

- (IBAction)typing : (id)sender;
- (IBAction)cancel : (id)sender;
- (IBAction)tweet : (id)sender;

@end
