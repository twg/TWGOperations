//
//  GETRecentFlickrFeedOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "GETRecentFlickrFeedOperation.h"

@implementation GETRecentFlickrFeedOperation

- (NSURL *)url
{
	return [NSURL URLWithString:@"https://api.flickr.com/services/rest/"
			@"?method=flickr.photos.getRecent&api_key=8d46b69cd963ef7544119d719de8ba9e&format="
			@"json&nojsoncallback=1"];
}

@end
