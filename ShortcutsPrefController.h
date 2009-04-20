//
//  ShortcutsPrefController.h
//  Warblr
//
//  Created by Alex on 18/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"
#import "SRRecorderControl.h"


@interface ShortcutsPrefController : NSObject <SS_PreferencePaneProtocol> {
	IBOutlet NSView *prefsView;
	IBOutlet SRRecorderControl *tweetHUDRecorder;
	IBOutlet SRRecorderControl *timelineRecorder;
}

@end
