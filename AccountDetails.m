//
//  AccountDetails.m
//  Warblr
//
//  Created by Alex on 14/12/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "AccountDetails.h"

#define USERNAME_KEY	@"Twitter Username"
#define SERVICE_NAME	@"Warblr"

static AccountDetails *accDetails;

@implementation AccountDetails

+ (AccountDetails *)instance {
    if (accDetails == nil) {
        accDetails = [[AccountDetails alloc] init];
    }
	
    return (accDetails);
}

- (NSString *)currentUsername {
	return [[NSUserDefaults standardUserDefaults] stringForKey:USERNAME_KEY];
}

- (NSString *)currentPassword {
	return [[[EMKeychainProxy sharedProxy] genericKeychainItemForService:SERVICE_NAME withUsername:[self currentUsername]] password];
}

- (void)setUsername:(NSString *)username {
	EMKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:SERVICE_NAME withUsername:[self currentUsername]];
	
	if ([self currentUsername] == nil || keychainItem == nil) {
		[[EMKeychainProxy sharedProxy] addGenericKeychainItemForService:SERVICE_NAME withUsername:username password:@""];
	} else {
		[keychainItem setUsername:username];
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:username forKey:USERNAME_KEY];
	[defaults synchronize];
}

- (void)setPassword:(NSString *)password {
	EMKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:SERVICE_NAME withUsername:[self currentUsername]];
	
	if (keychainItem == nil) {
		NSLog(@"[ Warblr ] - Keychain item for: %@ does not exist, create it first.", [self currentUsername]);
	} else {
		[keychainItem setPassword:password];
	}
}

- (void)dealloc {
    [super dealloc];	
}

@end
