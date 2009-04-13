//
//  TimelineWindowController.m
//  Warblr
//
//  Created by Alex on 13/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TimelineWindowController.h"

static TimelineWindowController *windowController;

@implementation TimelineWindowController

+ (TimelineWindowController *)sharedController {
    if (windowController == nil) {
        windowController = [[TimelineWindowController alloc] initWithWindowNibName: @"TimelineWindow"];
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
