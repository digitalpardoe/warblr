//
//  MenuController.h
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WindowController.h"


@interface MenuController : NSObject {
	IBOutlet NSMenu *menu;
	NSStatusItem *statusBarItem;
}

- (IBAction)showTweetHUD:(id)sender;

@end
