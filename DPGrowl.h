//
//  DPGrowl.h
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Growl/Growl.h>

@interface DPGrowl : NSObject <GrowlApplicationBridgeDelegate>
{
}

+ (DPGrowl *)theGrowl;

- (void)initializeGrowl;

- (void)showGrowlNotification:(NSString *)growlName:(NSString *)growlTitle:(NSString *)gowlDescription;

@end