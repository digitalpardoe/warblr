//
//  DPGrowl.m
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPGrowl.h"


@implementation DPGrowl

static DPGrowl *growl;

+ (DPGrowl *)instance {
	if (growl == nil) {
		growl = [[DPGrowl alloc] init];
	}
	
	return growl;
}

- (void)initializeGrowl {
	[GrowlApplicationBridge setGrowlDelegate:@""];
}

- (void)showGrowlNotification:(NSString *)growlName:(NSString *)growlTitle:(NSString *)growlDescription {
	[GrowlApplicationBridge notifyWithTitle:growlTitle
								description:growlDescription
						   notificationName:growlName
								   iconData:nil
								   priority:0
								   isSticky:NO
							   clickContext:nil ];
}

@end
