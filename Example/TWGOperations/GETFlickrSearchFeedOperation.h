//
//  GETFlickrSearchFeedOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "GETFlickrFeedOperation.h"

@interface GETFlickrSearchFeedOperation : GETFlickrFeedOperation

@property (nonatomic, copy) NSString *searchString;

+ (GETFlickrSearchFeedOperation *)operationWithSearchString:(NSString *)searchString;

@end
