//
//  GETFlickrSearchFeedOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "GETFlickrSearchFeedOperation.h"

@implementation GETFlickrSearchFeedOperation

- (NSURL *)url
{
    return [NSURL
        URLWithString:[NSString
                          stringWithFormat:@"https://api.flickr.com/services/rest/"
                                           @"?method=flickr.photos.search&api_key=8d46b69cd963ef7544119d719de8ba9e&"
                                           @"tags=%@&format=json&nojsoncallback=1",
                                           [self.searchString stringByAddingPercentEncodingWithAllowedCharacters:
                                                                  [NSCharacterSet URLQueryAllowedCharacterSet]]]];
}

+ (GETFlickrSearchFeedOperation *)operationWithSearchString:(NSString *)searchString
{
    GETFlickrSearchFeedOperation *operation = [[[self class] alloc] init];
    operation.searchString = searchString;
    return operation;
}

@end
