//
//  FlickrPhotoDownloadOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "ConnectionAlertOperation.h"
#import "FlickrPhotoDownloadOperation.h"

@interface FlickrPhotoDownloadOperation ()

@property (nonatomic, strong) GETCacheOperation *fetchOperation;
@property (nonatomic, strong) TWGAlertOperation *alertOperation;

@end

@implementation FlickrPhotoDownloadOperation

- (instancetype)init
{
    GETCacheOperation *fetchOperation = [[GETCacheOperation alloc] init];
    ConnectionAlertOperation *alertOperation = [[ConnectionAlertOperation alloc] init];

    self = [super initWithOperation:fetchOperation andCheckOperation:alertOperation];
    if (self) {
        self.fetchOperation = fetchOperation;
        self.alertOperation = alertOperation;
    }
    return self;
}

- (void)setPhoto:(FlickrPhoto *)photo
{
    _photo = photo;
    self.fetchOperation.url = photo.photoURL;
}

- (void)setPresentingViewController:(UIViewController *)presentingViewController
{
    _presentingViewController = presentingViewController;
    self.alertOperation.presentingViewController = presentingViewController;
}

- (void)finishWithResult:(id)result
{
    if ([result isKindOfClass:[NSData class]]) {
        UIImage *image = [UIImage imageWithData:(NSData *)result];
        [super finishWithResult:image];
    }
    else {
        [super finishWithResult:nil];
    }
}

@end
