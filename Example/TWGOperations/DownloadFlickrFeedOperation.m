//
//  DownloadFlickrFeedOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "ConnectionAlertOperation.h"
#import "DownloadFlickrFeedOperation.h"

@interface DownloadFlickrFeedOperation ()

@property (nonatomic, strong) FetchFlickrFeedOperation *fetchOperation;
@property (nonatomic, strong) TWGAlertOperation *alertOperation;

@end

@implementation DownloadFlickrFeedOperation

- (instancetype)init
{
    FetchFlickrFeedOperation *fetchOperation = [[FetchFlickrFeedOperation alloc] init];
    ConnectionAlertOperation *alertOperation = [[ConnectionAlertOperation alloc] init];

    self = [super initWithOperation:fetchOperation andCheckOperation:alertOperation];
    if (self) {
        self.fetchOperation = fetchOperation;
        self.alertOperation = alertOperation;
    }
    return self;
}

- (void)setPresentingViewController:(UIViewController *)presentingViewController
{
    _presentingViewController = presentingViewController;
    self.alertOperation.presentingViewController = presentingViewController;
}

@end
