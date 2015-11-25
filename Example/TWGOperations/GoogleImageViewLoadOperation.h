//
//  GoogleImageViewLoadOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>
#import <UIKit/UIKit.h>

@interface GoogleImageViewLoadOperation : TWGGroupOperation

@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) UIImageView *imageView;

+ (instancetype) loadOperationWithSearchString:(NSString *)searchString andImageView:(UIImageView *)imageView;

@end
