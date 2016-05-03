//
//  FetchFlickrFeedOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;
#import "GETRecentFlickrFeedOperation.h"

@interface FetchFlickrFeedOperation : TWGGroupOperation <TWGOperationDelegate, NSCopying>

@property (nonatomic, strong, readonly) GETRecentFlickrFeedOperation *fetchOperation;

@end
