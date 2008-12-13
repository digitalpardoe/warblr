//
//  AccountPrefController.m
//  Warblr
//
//  Created by Alex on 13/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "AccountPrefController.h"


@implementation AccountPrefController

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
