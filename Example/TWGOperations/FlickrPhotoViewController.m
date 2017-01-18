//
//  FlickrPhotoViewController.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "FlickrPhotoDownloadOperation.h"
#import "FlickrPhotoViewController.h"

@interface FlickrPhotoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FlickrPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	TWGOperation *operation = [[TWGOperation alloc] init];
	[[NSOperationQueue mainQueue] addOperation:operation];
}

- (void)setPhoto:(FlickrPhoto *)photo
{
    if (_photo != photo) {
        _photo = photo;

        [self fetchPhoto];
    }
}

- (void)fetchPhoto
{
    if (self.photo.photo == nil) {
        FlickrPhotoDownloadOperation *operation = [[FlickrPhotoDownloadOperation alloc] init];
        operation.photo = self.photo;
        [operation completionOnMain:^(id result) {
            NSLog(@"Got full size image for photo ID:%@", self.photo.identifier);
            if ([result isKindOfClass:[UIImage class]]) {
                self.imageView.image = (UIImage *)result;
            }
        }];

        [self.operationQueue addOperation:operation];
    }
}

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end
