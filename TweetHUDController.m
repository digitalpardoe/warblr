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
}

- (IBAction)tweet:(id)sender {
	// Don't forget to remove these two lines when actually implementing the "tweet".
	[[WindowController sharedController] close];
	[messageArea setString:@""];
	
//	MGTwitterEngine *twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
//  [twitterEngine setUsername:@"digitalpardoe" password:@""];
//	[twitterEngine setClientName:@"Warblr" version:@"0.1a1" URL:@"http://digitalpardoe.co.uk/" token:@"warblr"];
//	[twitterEngine sendUpdate:[messageArea string]];
//	[[WindowController sharedController] close];
//	[messageArea setString:@""];
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

- (void)dealloc
{
	[messageArea release];
	[characterCount release];
	[closeButton release];
	[tweetButton release];
	[super dealloc];
}

@end
