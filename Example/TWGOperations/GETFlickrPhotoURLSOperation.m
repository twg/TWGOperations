//
//  GETFlickrMetadataOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-03.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "GETFlickrPhotoURLSOperation.h"

static NSString *LargeThumbnailName = @"Large Square";
static NSString *LargeName = @"Large";
static NSString *OrigName = @"Original";

@implementation GETFlickrPhotoURLSOperation

- (NSURL *)url
{
    NSString *urlString =
        [NSString stringWithFormat:@"https://api.flickr.com/services/rest/"
                                   @"?method=flickr.photos.getSizes&api_key=ee45c17f38db74644ecc1898e18c558a&photo_"
                                   @"id=%@&format=json&nojsoncallback=1",
                                   self.photo.identifier];
    return [NSURL URLWithString:urlString];
}

- (id)parsedObject:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!error) {
        NSDictionary *sizesDict = dict[@"sizes"];
        if ([sizesDict isKindOfClass:[NSDictionary class]]) {
            NSArray *sizes = sizesDict[@"size"];

            NSString *thumbnailPath = nil;
            NSString *fullImagePath = nil;

            for (NSDictionary *sizeDict in sizes) {
                if ([sizeDict[@"label"] isEqualToString:LargeThumbnailName]) {
                    thumbnailPath = sizeDict[@"source"];
                }
                else if ([sizeDict[@"label"] isEqualToString:LargeName]) {
                    fullImagePath = sizeDict[@"source"];
                }
                else if ([sizeDict[@"label"] isEqualToString:OrigName]) {
                    fullImagePath = sizeDict[@"source"];
                }
            }

            self.photo.thumbnailURL = (thumbnailPath) ? [NSURL URLWithString:thumbnailPath] : nil;
            self.photo.photoURL = (fullImagePath) ? [NSURL URLWithString:fullImagePath] : nil;
        }
    }

    return self.photo;
}
@end
