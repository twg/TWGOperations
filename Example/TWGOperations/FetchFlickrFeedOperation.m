//
//  FetchFlickrFeedOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "FetchFlickrFeedOperation.h"
#import "FlickrPhoto.h"
#import "GETFlickrPhotoURLSOperation.h"

@interface FetchFlickrFeedOperation ()

@property (nonatomic, strong) GETRecentFlickrFeedOperation *fetchOperation;
@property (nonatomic, strong) TWGOperation *placeholderOperation;

@property (nonatomic, strong) NSArray<FlickrPhoto *> *photos;

@end

@implementation FetchFlickrFeedOperation

- (instancetype)init
{
    GETRecentFlickrFeedOperation *fetchOperation = [[GETRecentFlickrFeedOperation alloc] init];
    TWGOperation *placeholderOperation = [[TWGOperation alloc] init];

    self = [super initWithSerialOperations:@[ fetchOperation, placeholderOperation ]];
    if (self) {
        self.fetchOperation = fetchOperation;
        self.fetchOperation.delegate = self;

        self.placeholderOperation = placeholderOperation;
        self.placeholderOperation.delegate = self;
    }
    return self;
}

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    if (operation == self.fetchOperation) {

        NSLog(@"Finished fetching Flickr recent feed");

        if ([result isKindOfClass:[NSArray class]]) {
            NSArray<FlickrPhoto *> *photos = (NSArray *)result;
            self.photos = photos;
            [self createPhotoURLSDownloadOperationsWithPhotos:photos];
        }
    }
    else if (operation == self.placeholderOperation) {
        [self finishWithResult:self.photos];
    }
    else if ([operation isKindOfClass:[GETFlickrPhotoURLSOperation class]]) {
        GETFlickrPhotoURLSOperation *urlsOperation = (GETFlickrPhotoURLSOperation *)operation;
        NSLog(@"Got Image URLs for image ID:%@", urlsOperation.photo.identifier);
    }
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}

- (void)createPhotoURLSDownloadOperationsWithPhotos:(NSArray<FlickrPhoto *> *)photos
{
    NSMutableArray *operations = [NSMutableArray new];

    for (FlickrPhoto *photo in photos) {
        GETFlickrPhotoURLSOperation *operation = [[GETFlickrPhotoURLSOperation alloc] init];
        operation.photo = photo;
        operation.delegate = self;
        [operations addObject:operation];
    }

    [self.placeholderOperation addDependencies:operations];
    [self.operationQueue addOperations:operations waitUntilFinished:NO];
}

- (id)copyWithZone:(NSZone *)zone
{
    FetchFlickrFeedOperation *operation = [[FetchFlickrFeedOperation alloc] init];
    operation.delegate = self;
    return operation;
}

@end
