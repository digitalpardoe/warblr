//
//  TweetManager.m
//  Warblr
//
//  Created by Alex on 09/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TweetManager.h"


@implementation TweetManager

- (void)getTweets {
	NSFetchRequest *mostRecentFetchRequest = [[NSFetchRequest alloc] init];
	[mostRecentFetchRequest setEntity:tweetEntityDescription];
	[mostRecentFetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"tweetId" ascending:NO]]];
	[mostRecentFetchRequest setFetchLimit:1];
	NSArray *results = [managedObjectContext executeFetchRequest:mostRecentFetchRequest error:nil];
		
	[twitterEngine setUsername:[[AccountDetails instance] currentUsername] password:[[AccountDetails instance] currentPassword]];
	
	if (results == nil || [results count] == 0) {
		[twitterEngine getFollowedTimelineFor:[[AccountDetails instance] currentUsername] since:nil startingAtPage:0];
	} else {
		[twitterEngine getFollowedTimelineFor:[[AccountDetails instance] currentUsername] sinceID:[[[results objectAtIndex:0] valueForKey:@"tweetId"] intValue] startingAtPage:0 count:0];
	}
}

- (TweetManager *)init {
	if (self = [super init]) {
		twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
		
		managedObjectContext = [[DPCoreData instance] managedObjectContext];
		tweetEntityDescription = [[[[DPCoreData instance] managedObjectModel] entitiesByName] objectForKey:@"tweet"];
		userEntityDescription = [[[[DPCoreData instance] managedObjectModel] entitiesByName] objectForKey:@"user"];
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

	NSEnumerator *enumerator = [statuses objectEnumerator];
	id status;
	while ( status = [enumerator nextObject] ) {
		NSFetchRequest *userFetchRequest = [[NSFetchRequest alloc] init];
		[userFetchRequest setEntity:userEntityDescription];
		[userFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"userId == %@", [[status objectForKey:@"user"] objectForKey:@"id"]]];
		NSArray *results = [managedObjectContext executeFetchRequest:userFetchRequest error:nil];
		
		NSManagedObject *userManagedObject;
		if (results == nil || [results count] == 0) {
			userManagedObject = [[NSManagedObject alloc] initWithEntity:userEntityDescription insertIntoManagedObjectContext:managedObjectContext];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"id"] forKey:@"userId"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"screen_name"] forKey:@"screenName"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"name"] forKey:@"name"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"url"] forKey:@"url"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"location"] forKey:@"location"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"description"] forKey:@"desc"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"profile_image_url"] forKey:@"profileImageURL"];
		} else {
			userManagedObject = [results objectAtIndex:0];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"screen_name"] forKey:@"screenName"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"name"] forKey:@"name"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"url"] forKey:@"url"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"location"] forKey:@"location"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"description"] forKey:@"desc"];
			[userManagedObject setValue:[[status objectForKey:@"user"] objectForKey:@"profile_image_url"] forKey:@"profileImageURL"];
		}
		
		NSManagedObject *tweetManagedObject = [[NSManagedObject alloc] initWithEntity:tweetEntityDescription insertIntoManagedObjectContext:managedObjectContext];
		[tweetManagedObject setValue:[status objectForKey:@"id"] forKey:@"tweetId"];
		[tweetManagedObject setValue:[status objectForKey:@"text"] forKey:@"body"];
		[tweetManagedObject setValue:[status objectForKey:@"created_at"] forKey:@"createdAt"];
		[tweetManagedObject setValue:userManagedObject forKey:@"user"];
	}

	NSError *error;
	if (![managedObjectContext save:&error]) {
		NSLog(@"%@", error);
	}
}

-(void)dealloc {
	[twitterEngine release];
	[managedObjectContext release];
	[tweetEntityDescription release];
	[userEntityDescription release];
	
	[super dealloc];
}

@end
