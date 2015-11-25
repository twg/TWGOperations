//
//  GoogleImageViewLoadOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GoogleImageViewLoadOperation.h"
#import "ImageViewSetOperation.h"
#import "GoogleImageDownloadOperation.h"

@interface GoogleImageViewLoadOperation ()

@property (nonatomic, strong) GoogleImageDownloadOperation *downloadOperation;
@property (nonatomic, strong) ImageViewSetOperation *setOperation;

@end

@implementation GoogleImageViewLoadOperation

- (instancetype)init
{
    self.downloadOperation = [[GoogleImageDownloadOperation alloc] init];
    self.setOperation = [[ImageViewSetOperation alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [self.downloadOperation setOperationCompletionBlock:^(id data, NSError *error) {
        
        if([data isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)data;
            weakSelf.setOperation.image = image;
        }
        else if (error) {
            weakSelf.error = error;
            [weakSelf finish];
        }
        
    }];
    
    [self.setOperation addDependency:self.downloadOperation];
    
    self = [super initWithOperations:@[self.setOperation, self.downloadOperation]];
    if(self) {
        
    }
    return self;
}

- (void)setSearchString:(NSString *)searchString
{
    _searchString = searchString;
    self.downloadOperation.searchString = searchString;
}

- (void)setImageView:(UIImageView *)imageView
{
    _imageView = imageView;
    self.setOperation.imageView = imageView;
}

+ (instancetype)loadOperationWithSearchString:(NSString *)searchString andImageView:(UIImageView *)imageView
{
    GoogleImageViewLoadOperation *loadOperation = [[[self class] alloc] init];
    loadOperation.searchString = searchString;
    loadOperation.imageView = imageView;
    return loadOperation;
}

@end
