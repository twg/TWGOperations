//
//  PhotoThumbnailCell.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-03.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "PhotoThumbnailCell.h"

@implementation PhotoThumbnailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.frame = self.contentView.bounds;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

@end
