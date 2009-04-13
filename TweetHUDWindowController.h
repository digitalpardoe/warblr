//
//  TweetHUDWindowController.h
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TweetHUDWindowController : NSWindowController {
}

+ (TweetHUDWindowController *)sharedController;

- (void)show;

@end
