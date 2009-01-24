//
//  WindowController.m
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "WindowController.h"


static WindowController *windowController;

@implementation WindowController

+ (WindowController *)sharedController {
    if (windowController == nil) {
        windowController = [[WindowController alloc] initWithWindowNibName: @"TweetHUD"];
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
