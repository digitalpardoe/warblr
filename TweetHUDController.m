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
	[[[WindowController sharedController] window] center];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
	[messageArea setFont:[NSFont fontWithName:@"Lucida Grande" size:14]];
	[messageArea setTextColor:[NSColor whiteColor]];
}

- (IBAction)close:(id)sender {
	[[WindowController sharedController] close];
	[messageArea setString:@""];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
}

- (IBAction)tweet:(id)sender {	
//	MGTwitterEngine *twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
//	[twitterEngine setUsername:[[AccountDetails instance] currentUsername] password:[[AccountDetails instance] currentPassword]];
//	[twitterEngine setClientName:APP_NAME version:APP_VERSION URL:APP_URL token:APP_TOKEN];
//	[twitterEngine sendUpdate:[messageArea string]];
	[[WindowController sharedController] close];
	[messageArea setString:@""];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
}

- (void)textDidChange:(NSNotification *)notification {
	NSString *contents = [messageArea string];
	
	int theLength = [contents length];
	
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140", theLength]];
	
	if (theLength > 140) {
		[characterCount setTextColor:[NSColor redColor]];
	} else if (theLength <= 140) {
		[characterCount setTextColor:[NSColor whiteColor]];
	}
	
	// http://tinyurl.com/api-create.php?url=
}

- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)command {
	if (command == @selector(cancelOperation:)) {
		[self close:nil];
		return YES;
	} else if (command == @selector(insertNewline:)) {
		[self tweet:nil];
		return YES;
	}
	
//	NSLog(@"Command = %@", NSStringFromSelector(command));
	
	return NO;
}

- (void)dealloc {
	[messageArea release];
	[characterCount release];
	[closeButton release];
	[tweetButton release];
	[super dealloc];
}

@end
