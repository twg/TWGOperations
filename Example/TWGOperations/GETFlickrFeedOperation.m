//
//  GETFlickrFeedOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "FlickrPhoto.h"
#import "GETFlickrFeedOperation.h"

@implementation GETFlickrFeedOperation

- (id)parsedObject:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!error) {
        NSDictionary *photosDict = dict[@"photos"];
        if ([photosDict isKindOfClass:[NSDictionary class]]) {
            NSArray *photos = photosDict[@"photo"];

            NSMutableArray *photoModels = [NSMutableArray new];

            for (NSDictionary *photoDict in photos) {
                FlickrPhoto *photo = [FlickrPhoto photoFromDict:photoDict];
                if (photo) {
                    [photoModels addObject:photo];
                }
            }

            return photoModels;
        }
    }

    return nil;
}

@end
