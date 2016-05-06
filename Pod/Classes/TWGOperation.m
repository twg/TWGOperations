//
//  TWGBaseOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "NSOperationKVOKeys.h"
#import "TWGOperation.h"

@implementation TWGOperation {
    BOOL _executing;
    BOOL _finished;
}

// iOS <= 7
- (BOOL)isConcurrent
{
    return NO;
}
// iOS >= 8
- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return _executing;
}

- (BOOL)isFinished
{
    return _finished;
}

- (void)start
{
    if ([self isCancelled] == NO) {
        [self willChangeValueForKey:NSOperationIsExecuting];
        _executing = YES;
        [self didChangeValueForKey:NSOperationIsExecuting];

        [self execute];
    }
    else {
        [self finish];
    }
}

- (void)execute
{
    [self finishWithResult:nil];
}

- (void)finish
{
    [self willChangeValueForKey:NSOperationIsExecuting];
    _executing = NO;
    [self didChangeValueForKey:NSOperationIsExecuting];

    [self willChangeValueForKey:NSOperationIsFinished];
    _finished = YES;
    [self didChangeValueForKey:NSOperationIsFinished];
}

#pragma mark convenience completions

- (void)finishWithResult:(id)result
{
    if ([self.delegate respondsToSelector:@selector(operation:didCompleteWithResult:)]) {
        [self.delegate operation:self didCompleteWithResult:result];
    }

    [self finish];
}

- (void)finishWithError:(NSError *)error
{

    if ([self.delegate respondsToSelector:@selector(operation:didFailWithError:)]) {
        [self.delegate operation:self didFailWithError:error];
    }

    [self finish];
}

@end
