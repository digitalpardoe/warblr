//
//  MenuController.h
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "WindowController.h"


@interface MenuController : NSObject {
	IBOutlet NSMenu *statusMenu;
	NSStatusItem *statusBarItem;
}

- (IBAction)showTweetHUD:(id)sender;

OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler,EventRef theEvent, void *userData);

@end
