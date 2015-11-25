//
//  GETOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface GETOperation : TWGBaseOperation

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSURLSession *session;

@end
