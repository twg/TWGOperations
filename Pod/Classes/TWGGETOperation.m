//
//  TWGGETOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-10.
//
//

#import "TWGGETOperation.h"

@implementation TWGGETOperation

- (void)execute
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                              NSURLResponse * _Nullable response,
                                                                              NSError * _Nullable error) {
        self.result = data;
        self.error = error;
        [self finish];
    }];
    
    [task resume];
    
    
    
}

#pragma Lazy
- (NSURLSession *)session
{
    if(_session == nil) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

@end
