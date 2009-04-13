//
//  DPCoreData.h
//  Warblr
//
//  Created by Alex on 10/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DPUtility.h"


@interface DPCoreData : NSObject {
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

+ (DPCoreData *)instance;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

@end
