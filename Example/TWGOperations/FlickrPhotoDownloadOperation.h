//
//  FlickrPhotoDownloadOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;
#import "FlickrPhoto.h"
#import "GETCacheOperation.h"

@interface FlickrPhotoDownloadOperation : TWGRetryOperation

@property (nonatomic, strong) FlickrPhoto *photo;
@property (nonatomic, strong) UIViewController *presentingViewController;

@end
