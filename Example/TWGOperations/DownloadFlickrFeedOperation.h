//
//  DownloadFlickrFeedOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;
#import "FetchFlickrFeedOperation.h"

@interface DownloadFlickrFeedOperation : TWGRetryOperation

@property (nonatomic, strong) UIViewController *presentingViewController;

@property (nonatomic, strong, readonly) FetchFlickrFeedOperation *fetchOperation;
@property (nonatomic, strong, readonly) TWGAlertOperation *alertOperation;

@end
