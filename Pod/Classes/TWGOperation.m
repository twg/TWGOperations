//
//  TWGBaseOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGOperation.h"
#import "NSOperation+GroupDependencies.h"

static NSString *kIsExecutingKey = @"isExecuting";
static NSString *kIsFinishedKey = @"isFinished";

@implementation TWGOperation
{
    BOOL _executing;
    BOOL _finished;
}

// iOS <= 7
- (BOOL)isConcurrent { return NO; }
// iOS >= 8
- (BOOL)isAsynchronous { return YES; }

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)execute
{
    [self finish];
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

- (void)start
{
    [self willChangeValueForKey:kIsExecutingKey];
    _executing = YES;
    [self didChangeValueForKey:kIsExecutingKey];
    [self execute];
}

#pragma mark convenience completions

- (void)finishWithResult:(id)result
{
    [self informDelegateOfCompletionWithResult:result];
    [self finish];
}

- (void)finishWithError:(NSError *)error
{
    [self informDelegateOfFailureWithError:error];
    [self finish];
}

#pragma mark delegate

- (void) informDelegateOfCompletionWithResult:(id)result
{
    if([self.delegate respondsToSelector:@selector(operation:didCompleteWithResult:)]) {
        [self.delegate operation:self didCompleteWithResult:result];
    }
}

- (void) informDelegateOfFailureWithError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(operation:didFailWithError:)]) {
        [self.delegate operation:self didFailWithError:error];
    }
}

@end
