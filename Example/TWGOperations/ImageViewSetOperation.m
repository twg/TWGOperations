//
//  TWGImageViewSetOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "ImageViewSetOperation.h"

@implementation ImageViewSetOperation

- (void)execute
{
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:self.image waitUntilDone:YES];
    [self finish];
}

+ (instancetype) imageViewSetOperationWithImageView:(UIImageView *)imageView andImage:(UIImage *)image
{
    ImageViewSetOperation *setOperation = [[[self class] alloc] init];
    setOperation.imageView = imageView;
    setOperation.image = image;
    return nil;
}

@end
