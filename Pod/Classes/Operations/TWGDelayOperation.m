//
//  TWGDelayOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#import "TWGDelayOperation.h"

@implementation TWGDelayOperation

- (void)execute
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), queue, ^{
        [self finishWithResult:nil];
    });
}

- (id)copyWithZone:(NSZone *)zone
{
    TWGDelayOperation *operation = [[[self class] alloc] init];
    operation.delegate = self.delegate;
    operation.delay = self.delay;
    return operation;
}

+ (instancetype)delayOperationWithDelay:(NSTimeInterval)delay
{
    TWGDelayOperation *delayOperation = [[[self class] alloc] init];
    delayOperation.delay = delay;
    return delayOperation;
}

@end
