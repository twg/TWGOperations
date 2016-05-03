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
                                @"?method=flickr.photos.getRecent&api_key=ee45c17f38db74644ecc1898e18c558a&format="
                                @"json&nojsoncallback=1&safe_search=1"];
}

@end
