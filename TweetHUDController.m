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
	[characterCount setStringValue:[NSString stringWithFormat:@"0/140"]];
	[messageArea becomeFirstResponder];
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)tweet:(id)sender {
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
}

- (void)dealloc
{
	[messageArea release];
	[characterCount release];
	[cancelButton release];
	[tweetButton release];
	[super dealloc];
}

@end
