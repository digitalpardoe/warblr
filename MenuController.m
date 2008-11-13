//
//  MenuController.m
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "MenuController.h"


@implementation MenuController

- (void)awakeFromNib {
	statusBarItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	[statusBarItem setHighlightMode:YES];
	[statusBarItem setMenu:menu];
	[statusBarItem setEnabled:YES];
	
	// Temporary placeholder for development.
	[statusBarItem setTitle:@"A"];
}

@end
