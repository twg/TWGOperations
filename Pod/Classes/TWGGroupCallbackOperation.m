//
//  TWGGroupCallbackOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-25.
//
//

#import "TWGGroupCallbackOperation.h"

@implementation TWGGroupCallbackOperation

- (void)execute
{
    switch (self.action) {
    case TWGGroupCallbackOperationActionError:
        [self finishWithError:self.value];
        break;
    default:
    case TWGGroupCallbackOperationActionSuccess:
        [self finishWithResult:self.value];
        break;
    }
}

- (void)configureValueForError:(NSError *)error
{
    self.action = TWGGroupCallbackOperationActionError;
    self.value = error;
}

- (void)configureValueForResult:(id)result
{
    self.action = TWGGroupCallbackOperationActionSuccess;
    self.value = result;
}

- (void)finishWithResult:(id)result
{
    if ([self.proxyOperation.delegate respondsToSelector:@selector(operation:didCompleteWithResult:)]) {
        [self.proxyOperation.delegate operation:self.proxyOperation didCompleteWithResult:result];
    }

    [self finish];
}

- (void)finishWithError:(NSError *)error
{
    if ([self.proxyOperation.delegate respondsToSelector:@selector(operation:didFailWithError:)]) {
        [self.proxyOperation.delegate operation:self.proxyOperation didFailWithError:error];
    }

    [self finish];
}

+ (instancetype)groupCallbackOperationWithProxyOperation:(TWGOperation *)proxyOperation
{
    TWGGroupCallbackOperation *operation = [[[self class] alloc] init];
    operation.proxyOperation = proxyOperation;

    return operation;
}

@end
