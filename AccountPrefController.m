//
//  AccountPrefController.m
//  Warblr
//
//  Created by Alex on 13/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "AccountPrefController.h"


@implementation AccountPrefController

- (NSString *)username {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"Twitter Username"];
}

- (NSString *)password {
	return [[[EMKeychainProxy sharedProxy] genericKeychainItemForService:@"Warblr" withUsername:[[NSUserDefaults standardUserDefaults] stringForKey:@"Twitter Username"]] password];
}

- (IBAction)login:(id)sender {
	BOOL oldUser = [[[NSUserDefaults standardUserDefaults] stringForKey:@"Twitter Username"] isEqualToString:[usernameField stringValue]];
	EMKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:@"Warblr" withUsername:[[NSUserDefaults standardUserDefaults] stringForKey:@"Twitter Username"]];
	
	[[NSUserDefaults standardUserDefaults] setObject:[usernameField stringValue] forKey:@"Twitter Username"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	if (keychainItem == nil || !oldUser) {
		[[EMKeychainProxy sharedProxy] addGenericKeychainItemForService:@"Warblr" withUsername:[usernameField stringValue] password:[passwordField stringValue]];
	} else {
		[keychainItem setPassword:[passwordField stringValue]];
	}
	
	MGTwitterEngine *twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	[twitterEngine setUsername:[self username] password:[self password]];
	[twitterEngine checkUserCredentials];
	
	[progressIndicator startAnimation:self];
	[resultText setHidden:YES];
	[progressText setStringValue:@"Checking credentials…"];
	[progressText setHidden:NO];
}
	
#pragma mark MGTwitterEngineDelegate methods
	
- (void)requestSucceeded:(NSString *)requestIdentifier {
	[progressIndicator stopAnimation:self];
	[resultText setStringValue:@"\u2713"];
	[resultText setHidden:NO];
	[progressText setStringValue:@"Success…"];
}
	
	
- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error {
	[progressIndicator stopAnimation:self];
	[resultText setStringValue:@"\u2715"];
	[resultText setHidden:NO];
	[progressText setStringValue:@"Login failed…"];
}

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[AccountPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"AccountPrefPane" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Account";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"AccountPrefIcon"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Twitter Account Preferences";
}

- (BOOL)allowsHorizontalResizing
{
    return NO;
}

- (BOOL)allowsVerticalResizing
{
    return NO;
}

- (void)dealloc
{
	[prefsView release];
	[super dealloc];
}

@end
