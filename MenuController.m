//
//  MenuController.m
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "MenuController.h"


@implementation MenuController

// Temporary method for running the dictionary as I haven't created a persistent one yet.
- (id)init {
	NSMutableDictionary *userDefaultsValuesDict = [NSMutableDictionary dictionary];
	[userDefaultsValuesDict setObject:[NSNumber numberWithInt:49] forKey:@"hotkeyCodeTweet"];  
	[userDefaultsValuesDict setObject:[NSNumber numberWithInt:cmdKey+optionKey] forKey:@"hotkeyModifiersTweet"];
	[[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	return self;
}

- (void)awakeFromNib {
	
	// Stuff for the hot keys, needs abstacting a little, :-).
	EventHotKeyRef gMyHotKeyRef;
	EventHotKeyID gMyHotKeyID;
	EventTypeSpec eventType;
	eventType.eventClass=kEventClassKeyboard;
	eventType.eventKind=kEventHotKeyPressed;

	InstallApplicationEventHandler(&MyHotKeyHandler,1,&eventType,self,NULL);
	
	gMyHotKeyID.signature='htk1';
	gMyHotKeyID.id=1;
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"hotkeyCodeTweet"] != -999) {
		RegisterEventHotKey([[NSUserDefaults standardUserDefaults] integerForKey:
							 @"hotkeyCodeTweet"], [[NSUserDefaults standardUserDefaults] integerForKey:
												  @"hotkeyModifiersTweet"], gMyHotKeyID, GetApplicationEventTarget(), 0, 
							&gMyHotKeyRef);
	}
	
	statusBarItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	[statusBarItem setHighlightMode:YES];
	[statusBarItem setMenu:statusMenu];
	
	// Temporary placeholder for development.
	[statusBarItem setTitle:@"A"];
	
	[statusBarItem setEnabled:YES];	
}

- (IBAction)showTweetHUD:(id)sender {
	[[TweetHUDWindowController sharedController] show];
}

- (IBAction)showPreferences:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	
	if (!prefs) {
		NSString *pathToPanes = [NSString stringWithFormat:@"%@/../Preference Panes", [[NSBundle mainBundle] resourcePath]];
		prefs = [[SS_PrefsController alloc] initWithPanesSearchPath:pathToPanes];
		
		[prefs setAlwaysShowsToolbar:YES];
		[prefs setDebug:NO];
		[prefs setAlwaysOpensCentered:YES];
		[prefs setPanesOrder:[NSArray arrayWithObjects:@"Account", @"Shortcuts",nil]];
	}
    
	[prefs showPreferencesWindow];
}

- (IBAction)showTimeline:(id)sender {
	[[TimelineWindowController sharedController] show];
}

// Method that actually handles the hot keys.
OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
	EventHotKeyID hkCom;
	GetEventParameter(theEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,sizeof(hkCom),NULL,&hkCom);
	int l = hkCom.id;
	
	MenuController* theMenu = userData;
	
	switch (l) {
		case 1:
			[theMenu showTweetHUD:nil];
			break;
	}
	
	return noErr;
}

- (void)dealloc {
	[super dealloc];
}

@end
