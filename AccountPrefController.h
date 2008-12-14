//
//  AccountPrefController.h
//  Warblr
//
//  Created by Alex on 13/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"


@interface AccountPrefController : NSObject <SS_PreferencePaneProtocol> {
	IBOutlet NSView *prefsView;
	IBOutlet NSTextField *username;
	IBOutlet NSSecureTextField *password;
}

@end
