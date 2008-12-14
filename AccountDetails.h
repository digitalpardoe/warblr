//
//  AccountDetails.h
//  Warblr
//
//  Created by Alex on 14/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EMKeychainProxy.h"


@interface AccountDetails : NSObject {
}

+ (AccountDetails *)instance;

- (NSString *)currentUsername;
- (NSString *)currentPassword;

- (void)setUsername:(NSString *)username;
- (void)setPassword:(NSString *)password;

@end
