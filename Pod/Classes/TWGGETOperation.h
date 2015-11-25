//
//  TWGGETOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-10.
//
//

#import "TWGBaseOperation.h"

@interface TWGGETOperation : TWGBaseOperation

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSURLSession *session;

@end
