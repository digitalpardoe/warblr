//
//  WindowController.m
//  Warblr
//
//  Created by Alex on 13/11/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "WindowController.h"


@implementation WindowController

+ (id)singleInstanceWindowController {
    static WindowController *singleInstanceWindowController = nil;
	
    if (!singleInstanceWindowController) {
        singleInstanceWindowController = [[WindowController allocWithZone:NULL] init];
    }
	
    return singleInstanceWindowController;
}

- (id)init {
    return [self initWithWindowNibName:@"TweetHUD"];
}

@end
