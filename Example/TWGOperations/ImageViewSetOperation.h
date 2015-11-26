//
//  TWGImageViewSetOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>
#import <UIKit/UIKit.h>

@interface ImageViewSetOperation : TWGOperation

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

+ (instancetype) imageViewSetOperationWithImageView:(UIImageView *)imageView andImage:(UIImage *)image;

@end
