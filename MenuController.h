//
//  MenuController.h
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "SS_PrefsController.h"
#import "TweetHUDWindowController.h"
#import "TimelineWindowController.h"


@interface MenuController : NSObject {
	IBOutlet NSMenu *statusMenu;
	NSStatusItem *statusBarItem;
	
	SS_PrefsController *prefs;
}

- (IBAction)showTweetHUD:(id)sender;
- (IBAction)showPreferences:(id)sender;
- (IBAction)showTimeline:(id)sender;

- (void)updateHotKeys;

OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler,EventRef theEvent, void *userData);

@end
