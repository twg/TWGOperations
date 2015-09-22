//
//  TWGBaseOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGBaseOperation.h"

@interface TWGBaseOperation ()

@property (nonatomic, strong) dispatch_semaphore_t operationLock;

+ (dispatch_queue_t) unblockingQueue;

@end

@implementation TWGBaseOperation

- (void)execute {}

- (void)finish
{
    self.state = TWGOperationStateFinishing;
    
    dispatch_sync([TWGBaseOperation unblockingQueue], ^{
        dispatch_semaphore_signal(self.operationLock);
    });
    
    self.state = TWGOperationStateFinished;
}

- (void)cancel
{
    [super cancel];
    
    self.state = TWGOperationStateCanceled;
}

- (void)main
{
    self.state = TWGOperationStateStarting;
    
    self.operationLock = dispatch_semaphore_create(0);
    
    self.state = TWGOperationStateExecuting;
    [self execute];
    
    dispatch_semaphore_wait(self.operationLock, DISPATCH_TIME_FOREVER);
}

static dispatch_queue_t unblockingQueue = NULL;
+ (dispatch_queue_t) unblockingQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unblockingQueue = dispatch_queue_create("TWGBaseOperation Unblocking Queue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return unblockingQueue;
}

@end
