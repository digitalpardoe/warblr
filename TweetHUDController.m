//
//  TweetHUDController.m
//  Warblr
//
//  Created by Alex on 14/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "TweetHUDController.h"


@implementation TweetHUDController

- (void)awakeFromNib {
	[NSApp activateIgnoringOtherApps:YES];
	[window center];
	[window makeKeyAndOrderFront:nil];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
	[messageArea becomeFirstResponder];
}

- (IBAction)close:(id)sender {
	[window orderOut:nil];
}

- (IBAction)tweet:(id)sender {
	[window orderOut:nil];
}

- (void)showTweetHUD {
	[window makeKeyAndOrderFront:nil];
}

- (void)controlTextDidChange:(NSNotification *)notification {
	NSString *contents = [messageArea stringValue];
	int theLength = [contents length];
	
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140", theLength]];
	
	if (theLength > 140) {
		[characterCount setTextColor:[NSColor redColor]];
	} else if (theLength <= 140) {
		[characterCount setTextColor:[NSColor whiteColor]];
	}
	
	// http://tinyurl.com/api-create.php?url=
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)command {
	if (command == @selector(cancelOperation:)) {
		[window orderOut:nil];
		return YES;
	} else if (command == @selector(insertNewline:)) {
		[self tweet:nil];
		return YES;
	}
	
//	NSLog(@"Command = %@", NSStringFromSelector(command));
	
	return NO;
}

- (void)dealloc
{
	[messageArea release];
	[characterCount release];
	[closeButton release];
	[tweetButton release];
	[super dealloc];
}

@end
