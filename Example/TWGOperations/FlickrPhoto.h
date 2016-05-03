//
//  FlickrPhoto.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *farm;

@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) NSURL *photoURL;

+ (instancetype)photoFromDict:(NSDictionary *)dict;

@end
