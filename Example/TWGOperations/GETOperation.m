//
//  GETOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GETOperation.h"

@interface GETOperation ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation GETOperation

- (void)execute
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    NSURLSessionDataTask *task = [self.session
        dataTaskWithRequest:request
          completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
              if (error) {
                  [self finishWithError:error];
              }
              else if (data) {
                  [self finishWithResult:[self parsedObject:data]];
              }
          }];

    [task resume];
}

- (id)parsedObject:(NSData *)data
{
    return data;
}

- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

- (id)copyWithZone:(NSZone *)zone
{
    GETOperation *operation = [[[self class] alloc] init];
    operation.url = self.url;
    return operation;
}

@end
