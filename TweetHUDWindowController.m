//
//  WindowController.m
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "TweetHUDWindowController.h"


static TweetHUDWindowController *windowController;

@implementation TweetHUDWindowController

+ (TweetHUDWindowController *)sharedController {
    if (windowController == nil) {
        windowController = [[TweetHUDWindowController alloc] initWithWindowNibName: @"TweetHUD"];
    }
	
    return (windowController);
}

- (void)windowWillClose:(NSNotification *)notification {
	[self autorelease];
	
	if (windowController == self) {
		windowController = nil;
	}
}

- (void)show {
	[NSApp activateIgnoringOtherApps:YES];
    [self showWindow:self];
}

- (void)dealloc {
    [super dealloc];	
}

@end
