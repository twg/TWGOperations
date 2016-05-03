//
//  FlickrPhotoViewController.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "FlickrPhoto.h"
#import <UIKit/UIKit.h>

@interface FlickrPhotoViewController : UIViewController

@property (nonatomic, strong) FlickrPhoto *photo;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end
