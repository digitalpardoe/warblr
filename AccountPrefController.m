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
	return [[AccountDetails instance] currentUsername];
}

- (NSString *)password {
	return [[AccountDetails instance] currentPassword];
}

- (IBAction)login:(id)sender {
	MGTwitterEngine *twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	[twitterEngine setUsername:[usernameField stringValue] password:[passwordField stringValue]];
	
	[progressIndicator startAnimation:self];
	[resultText setHidden:YES];
	[progressText setStringValue:@"Checking credentials…"];
	[progressText setHidden:NO];
	
	[twitterEngine checkUserCredentials];
}
	
#pragma mark MGTwitterEngineDelegate methods
	
- (void)requestSucceeded:(NSString *)requestIdentifier {
	[[AccountDetails instance] setUsername:[usernameField stringValue]];
	[[AccountDetails instance] setPassword:[passwordField stringValue]];
	
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
	[usernameField release];
	[passwordField release];
	[progressIndicator release];
	[progressText release];
	[resultText release];
	[super dealloc];
}

@end
