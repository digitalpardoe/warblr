//
//  TweetManager.m
//  Warblr
//
//  Created by Alex on 09/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TweetManager.h"


@implementation TweetManager

- (void)testClass {
	[twitterEngine setUsername:[[AccountDetails instance] currentUsername] password:[[AccountDetails instance] currentPassword]];
	[twitterEngine getFollowedTimelineFor:[[AccountDetails instance] currentUsername] since:nil startingAtPage:0];
}

- (TweetManager *)init {
	if (self = [super init]) {
		twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
    }
	
    return self;
}

#pragma mark MGTwitterEngineDelegate methods

- (void)requestSucceeded:(NSString *)requestIdentifier {
    NSLog(@"Request succeeded (%@)", requestIdentifier);
}


- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error {
    NSLog(@"Twitter request failed! (%@) Error: %@ (%@)", 
          requestIdentifier, 
          [error localizedDescription], 
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)identifier {
	//	Example returned request object.
	//
	//	{
	//		"created_at" = 2009-04-10 12:03:23 +0100;
	//		favorited = 0;
	//		id = 1489712732;
	//		source = "<a href=\"http://itweet.net/\">iTweet</a>";
	//		"source_api_request_type" = 0;
	//		text = "Pissed off my neighbours found things to make & do with a hammer on my wall at silly o clock :(";
	//		truncated = 0;
	//		user = {
	//			"created_at" = "Wed Oct 24 16:47:38 +0000 2007";
	//			description = "Undergrad Developer / Amateur Photographer";
	//			"favourites_count" = 0;
	//			"followers_count" = 103;
	//			following = false;
	//			"friends_count" = 155;
	//			id = 9659012;
	//			location = "London/Kent/Aberystwyth";
	//			name = "Rob Young";
	//			notifications = false;
	//			"profile_background_color" = ffffff;
	//			"profile_background_image_url" = "http://static.twitter.com/images/themes/theme1/bg.gif";
	//			"profile_background_tile" = false;
	//			"profile_image_url" = "http://s3.amazonaws.com/twitter_production/profile_images/72388094/n309600967_6013_normal.jpg";
	//			"profile_link_color" = 0000ff;
	//			"profile_sidebar_border_color" = 000000;
	//			"profile_sidebar_fill_color" = ffffff;
	//			"profile_text_color" = 000000;
	//			protected = 0;
	//			"screen_name" = robyoung26;
	//			"statuses_count" = 435;
	//			"time_zone" = London;
	//			url = "http://www.robyoung.me.uk";
	//			"utc_offset" = 0;
	//		};
	//	}

	NSManagedObjectContext *managedObjectContext = [[CoreData instance] managedObjectContext];
	NSManagedObjectModel *managedObjectModel = [[CoreData instance] managedObjectModel];	
	NSEntityDescription *tweetEntityDescription = [[managedObjectModel entitiesByName] objectForKey:@"tweet"];
	NSEntityDescription *userEntityDescription = [[managedObjectModel entitiesByName] objectForKey:@"user"];
	
	NSEnumerator *enumerator = [statuses objectEnumerator];
	id status;
	while ( status = [enumerator nextObject] ) {
//		NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
//		[managedObject setValue:[status objectForKey:@"id"] forKey:@"tweetId"];
//		[managedObject setValue:[status objectForKey:@"text"] forKey:@"body"];
//		[managedObject setValue:[status objectForKey:@"created_at"] forKey:@"createdAt"];
	
		NSLog(@"Next Tweet ---------------------------------------------------------");
		NSLog(@"ID: %@", [status objectForKey:@"id"]);
		NSLog(@"Created: %@", [status objectForKey:@"created_at"]);
		NSLog(@"Text: %@", [status objectForKey:@"text"]);
		NSLog(@"User ID: %@", [[status objectForKey:@"user"] objectForKey:@"id"]);
		NSLog(@"User Name: %@", [[status objectForKey:@"user"] objectForKey:@"name"]);
		
		NSFetchRequest *userFetchRequest = [[NSFetchRequest alloc] init];
		[userFetchRequest setEntity:userEntityDescription];
		[userFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"userId == %@", [[status objectForKey:@"user"] objectForKey:@"id"]]];
		NSArray *results = [managedObjectContext executeFetchRequest:userFetchRequest error:nil];
	}

//	NSError *error;
//	[managedObjectContext save:&error];
//	
//	NSLog(@"%@", error);
//	
//	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//	[fetchRequest setEntity:tweetEntityDescription];
//	
//	NSLog(@"%@", [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableSetValueForKey:@"createdAt"]);
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier {
    NSLog(@"Got direct messages:\r%@", messages);
}

@end
