//
//  GETOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GETOperation.h"

@implementation GETOperation

- (void)execute
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                               NSURLResponse * _Nullable response,
                                                                                               NSError * _Nullable error) {
        if(error) {
            [self finishWithError:error];
        }
        else if(data) {
            [self finishWithResult:data];
        }
    }];
    
    [task resume];
}

- (NSURLSession *)session
{
    if(_session == nil) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}


@end
