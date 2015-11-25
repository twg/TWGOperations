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

@interface ImageViewSearchOperation ()

@property (nonatomic, strong) GatherSearchStringOperation *gatherOperation;
@property (nonatomic, strong) GoogleImageViewLoadOperation *loadOperation;

@end

@implementation ImageViewSearchOperation

- (instancetype)init
{
    self.gatherOperation = [GatherSearchStringOperation gatherSearchStringOperation];
    self.loadOperation = [[GoogleImageViewLoadOperation alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [self.gatherOperation setOperationCompletionBlock:^(id result, NSError *error) {
        
        if([result isKindOfClass:[NSString class]]) {
            NSString *searchString = (NSString *)result;
            weakSelf.loadOperation.searchString = searchString;
        }
        else if (error) {
            weakSelf.error = error;
            [weakSelf finish];
        }
        
    }];
    
    [self.loadOperation addDependency:self.gatherOperation];
    
    self = [super initWithOperations:@[self.gatherOperation, self.loadOperation]];
    if(self) {
        
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

@end
