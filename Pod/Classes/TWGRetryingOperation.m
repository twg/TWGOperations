//
//  TWGRetryingOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#import "TWGRetryingOperation.h"
#import "TWGDelayOperation.h"
#import "TWGRetryAlertOperation.h"

@interface TWGRetryingOperation () <TWGRetryDecisionDelegate>

@property (nonatomic, assign, readwrite) NSUInteger retryCount;

@end

#define kOneSecond 1.f

@implementation TWGRetryingOperation

- (void)setupOperation {}
- (void)setupRetryAlertOperation {}

- (NSArray<NSOperation *> *)operations
{
    [self setupOperation];
    
    return @[self.operation];
}

- (void)finish
{
    if(!self.operation.error && self.operation.result) {
        self.result = self.operation.result;
        [super finish];
    }
    else {
        [self setupRetryAlertOperation];
        self.retryOperation.delegate = self;
        [self.operationQueue addOperations:@[self.retryOperation] waitUntilFinished:NO];
    }
}

- (void) retry
{
    self.operation = [self.operation copy];
    self.retryOperation = [self.retryOperation copy];
    
    [self execute];
}

- (TWGBaseOperation *)operation
{
    if(_operation == nil) {
        _operation = [TWGDelayOperation delayOperationWithDelay:kOneSecond];
    }
    return _operation;
}

- (TWGBaseOperation <TWGRetryDecisionOperation> *)retryOperation
{
    if(_retryOperation == nil) {
        _retryOperation = [TWGRetryAlertOperation alertOperationWithTitle:@"Error" andMessage:@"There was an error"];
    }
    return _retryOperation;
}

#pragma mark TWGRetryDesisionDelegate

- (void)retryDecisionDelegateDidDecide:(BOOL)retry
{
    if(retry) {
        self.retryCount++;
        [self retry];
    }
    else {
        self.error = self.operation.error;
        [super finish];
    }
}

@end
