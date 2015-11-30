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
    if(self.error) {
        [self finishWithError:self.error];
    }
    else {
        [self finishWithResult:self.result];
    }
}

- (void)finishWithResult:(id)result
{
    if([self.proxyOperation.delegate respondsToSelector:@selector(operation:didCompleteWithResult:)]) {
        [self.proxyOperation.delegate operation:self.proxyOperation didCompleteWithResult:result];
    }
    
    [self finish];
}

- (void)finishWithError:(NSError *)error
{
    if([self.proxyOperation.delegate respondsToSelector:@selector(operation:didFailWithError:)]) {
        [self.proxyOperation.delegate operation:self.proxyOperation didFailWithError:error];
    }
    
    [self finish];
}

+ (instancetype) groupCallbackOperationWithProxyOperation:(TWGOperation *)proxyOperation
{
    TWGGroupCallbackOperation *operation = [[[self class] alloc] init];
    operation.proxyOperation = proxyOperation;
    return operation;
}


@end
