//
//  ShortcutsPrefController.m
//  Warblr
//
//  Created by Alex on 18/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "ShortcutsPrefController.h"


@implementation ShortcutsPrefController

#pragma mark ShortcutRecroder delegate methods

- (BOOL)shortcutRecorder:(SRRecorderControl *)aRecorder isKeyCode:(signed short)keyCode andFlagsTaken:(unsigned int)flags reason:(NSString **)aReason {
	return NO;
}

- (void)shortcutRecorder:(SRRecorderControl *)aRecorder keyComboDidChange:(KeyCombo)newKeyCombo {
	NSLog(@"Recorder control: %@", aRecorder);
	NSLog(@"Key combo code: %i", newKeyCombo.code);
	NSLog(@"Key combo flags: %i", newKeyCombo.flags);
}

#pragma mark PrefsController methods

+ (NSArray *)preferencePanes {
    return [NSArray arrayWithObjects:[[[ShortcutsPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView {
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ShortcutsPrefPane" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName {
    return @"Shortcuts";
}

- (NSImage *)paneIcon {
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ShortcutsPrefIcon"]] autorelease];
}

- (NSString *)paneToolTip {
    return @"Keyboard Shortcut Preferences";
}

- (BOOL)allowsHorizontalResizing {
    return NO;
}

- (BOOL)allowsVerticalResizing {
    return NO;
}

- (void)dealloc {
	[prefsView release];
	[super dealloc];
}

@end
