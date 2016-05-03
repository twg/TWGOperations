//
//  TWGRetryOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2016-04-29.
//
//

#import "TWGGroupOperation+ImpliedDependency.h"
#import "TWGRetryOperation.h"

@interface TWGRetryOperation ()

@property (nonatomic, strong) TWGOperation<NSCopying> *operation;
@property (nonatomic, strong) TWGOperation<NSCopying> *checkOperation;
@property (nonatomic, strong) TWGRetryOperation *retryOperation;

@property (nonatomic, strong) TWGOperation *placeholderOperation;

@end

@implementation TWGRetryOperation

- (instancetype)initWithOperation:(TWGOperation<NSCopying> *)operation
                andCheckOperation:(TWGOperation<NSCopying> *)checkOperation
{
    TWGOperation *placeholderOperation = [[TWGOperation alloc] init];

    self = [super initWithSerialOperations:@[ operation, checkOperation, placeholderOperation ]];
    if (self) {

        self.operation = operation;
        self.operation.delegate = self;

        self.checkOperation = checkOperation;
        self.checkOperation.delegate = self;

        self.placeholderOperation = placeholderOperation;
        self.placeholderOperation.delegate = self;
    }
    return self;
}

#pragma mark TWGOperationDelegate

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    if (operation == self.operation || operation == self.retryOperation) {
        [self finishWithResult:result];
    }
    else if (operation == self.checkOperation) {
        TWGOperation<NSCopying> *fetchOperation = [self.operation copy];
        TWGOperation<NSCopying> *checkOperation = [self.checkOperation copy];

        TWGRetryOperation *retryOperation =
            [[[self class] alloc] initWithOperation:fetchOperation andCheckOperation:checkOperation];
        retryOperation.delegate = self;

        self.retryOperation = retryOperation;
        [self.placeholderOperation addDependency:self.retryOperation];
        [self.operationQueue addOperation:self.retryOperation];
    }
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    if (operation == self.checkOperation || operation == self.retryOperation) {
        [self finishWithError:error];
    }
}

@end
