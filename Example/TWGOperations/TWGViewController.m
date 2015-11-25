//
//  TWGViewController.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 09/22/2015.
//  Copyright (c) 2015 Nicholas Kuhne. All rights reserved.
//

#import "TWGViewController.h"

#import <TWGOperations/TWGOperations-umbrella.h>

#import "GoogleImageDownloadOperation.h"
#import "GoogleImageViewLoadOperation.h"
#import "ImageViewSearchOperation.h"

@interface TWGViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation TWGViewController

/*
 *
 *
 *
 Example 1
 *
 *
 *
 */
- (IBAction)example1Action:(id)sender
{
    GoogleImageDownloadOperation *downloadOperation =
        [GoogleImageDownloadOperation imageDownloadOperationWithSearchString:@"Sparkles"];
    
    __weak typeof(self) weakSelf = self;
    
    [downloadOperation setOperationCompletionBlock:^(id result, NSError *error) {
        
        if([result isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)result;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                weakSelf.imageView.image = image;
            });
        }
        
    }];
    
    [self.operationQueue addOperation:downloadOperation];
}



/*
 *
 *
 *
 Example 2
 *
 *
 *
 */
- (IBAction)example2Action:(id)sender
{
    GoogleImageViewLoadOperation *loadOperation =
        [GoogleImageViewLoadOperation loadOperationWithSearchString:@"DiZazzo" andImageView:self.imageView];
    
    [self.operationQueue addOperation:loadOperation];
    
}



/*
 *
 *
 *
 Example 3
 *
 *
 *
 */
- (IBAction)example3Action:(id)sender
{
    [self.operationQueue addOperation:[ImageViewSearchOperation imageViewSearchOperationWithImageView:self.imageView]];
}


- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end
