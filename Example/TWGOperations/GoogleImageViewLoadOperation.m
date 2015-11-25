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

@interface GoogleImageViewLoadOperation () <TWGOperationDelegate>

@property (nonatomic, strong) GoogleImageDownloadOperation *downloadOperation;
@property (nonatomic, strong) ImageViewSetOperation *setOperation;

@end

@implementation GoogleImageViewLoadOperation

- (instancetype)init
{
    GoogleImageDownloadOperation *downloadOperation = [[GoogleImageDownloadOperation alloc] init];
    ImageViewSetOperation *setOperation = [[ImageViewSetOperation alloc] init];
    
    [setOperation addDependency:downloadOperation];
    
    self = [super initWithOperations:@[downloadOperation, setOperation]];
    if(self) {
        self.downloadOperation = downloadOperation;
        self.downloadOperation.delegate = self;
        
        self.setOperation = setOperation;
        self.setOperation.delegate = self;
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

#pragma mark TWGOperationDelegate

- (void)operation:(TWGBaseOperation *)operation didCompleteWithResult:(id)result
{
    if(operation == self.downloadOperation) {
        if([result isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)result;
            self.setOperation.image = image;
        }
        else  {
            [self finishWithError:[NSError errorWithDomain:NSStringFromClass(self.class) code:0 userInfo:nil]];
        }
    }
    else if(operation == self.setOperation) {
        [self finishWithResult:result];
    }
}

- (void)operation:(TWGBaseOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}

@end
