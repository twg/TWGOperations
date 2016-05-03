//
//  TWGBaseOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGOperation.h"

static NSString *kIsExecutingKey = @"isExecuting";
static NSString *kIsFinishedKey = @"isFinished";

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
        [self willChangeValueForKey:kIsExecutingKey];
        _executing = YES;
        [self didChangeValueForKey:kIsExecutingKey];
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
    [self willChangeValueForKey:kIsExecutingKey];
    _executing = NO;
    [self didChangeValueForKey:kIsExecutingKey];

    [self willChangeValueForKey:kIsFinishedKey];
    _finished = YES;
    [self didChangeValueForKey:kIsFinishedKey];
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
