//
//  ImageViewSearchOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "ImageViewSearchOperation.h"
#import "GatherSearchStringOperation.h"
#import "GoogleImageViewLoadOperation.h"

@interface ImageViewSearchOperation () <TWGOperationDelegate>

@property (nonatomic, strong) GatherSearchStringOperation *gatherOperation;
@property (nonatomic, strong) GoogleImageViewLoadOperation *loadOperation;

@end

@implementation ImageViewSearchOperation

- (instancetype)init
{
    GatherSearchStringOperation *gatherOperation = [GatherSearchStringOperation gatherSearchStringOperation];
    GoogleImageViewLoadOperation *loadOperation = [[GoogleImageViewLoadOperation alloc] init];
    
    [loadOperation addDependency:gatherOperation];
    
    self = [super initWithOperations:@[gatherOperation, loadOperation]];
    if(self) {
        self.gatherOperation = gatherOperation;
        self.gatherOperation.delegate = self;
        
        self.loadOperation = loadOperation;
        self.loadOperation.delegate = self;
    }
    return self;
}

- (void)setImageView:(UIImageView *)imageView
{
    _imageView = imageView;
    self.loadOperation.imageView = imageView;
}

+ (instancetype)imageViewSearchOperationWithImageView:(UIImageView *)imageView
{
    ImageViewSearchOperation *searchOperation = [[[self class] alloc] init];
    searchOperation.imageView = imageView;
    return searchOperation;
}

#pragma mark TWGOperationDelegate

- (void)operation:(TWGBaseOperation *)operation didCompleteWithResult:(id)result
{
    if(operation == self.gatherOperation) {
        if([result isKindOfClass:[NSString class]]) {
            NSString *searchString = (NSString *)result;
            self.loadOperation.searchString = searchString;
        }
    }
    else if (operation == self.loadOperation) {
        [self finishWithResult:nil];
    }
}

- (void)operation:(TWGBaseOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}

@end
