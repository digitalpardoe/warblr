//
//  DPUtility.h
//  Warblr
//
//  Created by Alex on 13/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DPUtility : NSObject {

}

+ (DPUtility *)instance;

- (NSString *)applicationSupportFolder;

@end
