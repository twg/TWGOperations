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

@interface TWGViewController () <TWGOperationDelegate>
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
    downloadOperation.delegate = self;
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
    loadOperation.delegate = self;
    
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
    ImageViewSearchOperation *operation = [ImageViewSearchOperation imageViewSearchOperationWithImageView:self.imageView];
    operation.delegate = self;
    [self.operationQueue addOperation:operation];
}


#pragma mark TWGOperationDelegate

- (void)operation:(TWGBaseOperation *)operation didCompleteWithResult:(id)result
{
    if([operation isKindOfClass:[GoogleImageDownloadOperation class]]) { // Example 1
        if([result isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)result;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }
    }
}

- (void)operation:(TWGBaseOperation *)operation didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}


- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end
