//
//  AccountPrefController.h
//  Warblr
//
//  Created by Alex on 13/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"
#import "MGTwitterEngine.h"
#import "AccountDetails.h"


@interface AccountPrefController : NSObject <SS_PreferencePaneProtocol> {
	IBOutlet NSView *prefsView;
	IBOutlet NSTextField *usernameField;
	IBOutlet NSSecureTextField *passwordField;
	
	IBOutlet NSProgressIndicator *progressIndicator;
	IBOutlet NSTextField *progressText;
	IBOutlet NSTextField *resultText;
}

- (IBAction)login:(id)sender;

@end
