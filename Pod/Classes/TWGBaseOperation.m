//
//  TWGBaseOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGBaseOperation.h"
#import "NSOperation+GroupDependencies.h"

@interface TWGBaseOperation ()

@end

static NSString *kIsExecutingKey = @"isExecuting";
static NSString *kIsFinishedKey = @"isFinished";

@implementation TWGBaseOperation
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

- (void)execute {}

- (void)finish
{
    if(self.operationCompletionBlock) {
        self.operationCompletionBlock(self.result, self.error);
    }
    
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

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TWGBaseOperation *operation = [[[self class] alloc] init];
    
    operation.result = self.result;
    operation.error = self.error;
    operation.operationCompletionBlock = self.operationCompletionBlock;
    
    return operation;
}

@end
