//
//  FlickrPhoto.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

+ (instancetype)photoFromDict:(NSDictionary *)dict
{
    FlickrPhoto *photo = [[FlickrPhoto alloc] init];

    photo.identifier = dict[@"id"];
    photo.farm = dict[@"farm"];
    photo.server = dict[@"server"];

    return photo;
}

@end
