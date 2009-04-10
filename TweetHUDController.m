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
	[[[WindowController sharedController] window] center];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
	[messageArea setFont:[NSFont fontWithName:@"Lucida Grande" size:14]];
	[messageArea setTextColor:[NSColor whiteColor]];	
	[messageArea setRichText:NO];
}

- (IBAction)close:(id)sender {
	[[WindowController sharedController] close];
	[messageArea setString:@""];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
	[characterCount setTextColor:[NSColor whiteColor]];
}

- (IBAction)tweet:(id)sender {	
//	MGTwitterEngine *twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
//	[twitterEngine setUsername:[[AccountDetails instance] currentUsername] password:[[AccountDetails instance] currentPassword]];
//	[twitterEngine setClientName:APP_NAME version:APP_VERSION URL:APP_URL token:APP_TOKEN];
//	[twitterEngine sendUpdate:[messageArea string]];
	[[[TweetManager alloc] init] testClass];
	[[WindowController sharedController] close];
	[messageArea setString:@""];
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
}

#pragma mark NSTextView Delegate Methods

- (void)textDidChange:(NSNotification *)notification {
	NSString *contents = [messageArea string];
	
	int theLength = [contents length];
	
	AHHyperlinkScanner *hyperlinkScanner = [AHHyperlinkScanner hyperlinkScannerWithString:contents];
	NSArray *urls = [hyperlinkScanner allURIs];
	
	NSEnumerator *enumerator = [urls objectEnumerator];
	id url;
	while ( url = [enumerator nextObject] ) {
//		theLength = (theLength - [url range].length) + 25;
		NSLog(@"[ Warblr ] - Found URL: %@, in input.", url);
	}
	
//	if ([urls count] > 0) {
//		[characterCount setStringValue:[NSString stringWithFormat:@"~%d/140", theLength]];
//	} else {
		[characterCount setStringValue:[NSString stringWithFormat:@"%d/140", theLength]];
//	}
	
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
