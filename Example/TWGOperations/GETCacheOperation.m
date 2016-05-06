//
//  GETCacheOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-03.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "GETCacheOperation.h"

@implementation GETCacheOperation

- (void)execute
{
    if ([GETCacheOperation fileExistsForURL:self.url]) {
        NSData *fileData = [GETCacheOperation dataForFileAtURL:self.url];
        if ([fileData length]) {
            [self finishWithResult:fileData];
            return; // Stop here
        }
    }

    [super execute];
}

- (void)finishWithResult:(id)result
{
    if ([result isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)result;
        if ([data length]) {
            [[NSFileManager defaultManager] createFileAtPath:[GETCacheOperation localPathForURL:self.url]
                                                    contents:data
                                                  attributes:nil];
        }
    }

    [super finishWithResult:result];
}

+ (BOOL)fileExistsForURL:(NSURL *)url
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self localPathForURL:url]];
}

+ (NSString *)localPathForURL:(NSURL *)url
{
    NSData *plainData = [[url absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *fileName = [plainData base64EncodedStringWithOptions:kNilOptions];
    return [[self tempDirectory] stringByAppendingPathComponent:fileName];
}

+ (NSString *)tempDirectory
{
    return NSTemporaryDirectory();
}

+ (NSData *)dataForFileAtURL:(NSURL *)url
{
    if ([self fileExistsForURL:url]) {
        return [[NSFileManager defaultManager] contentsAtPath:[self localPathForURL:url]];
    }
    return nil;
}

@end
