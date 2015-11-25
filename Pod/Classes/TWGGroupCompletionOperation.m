//
//  TWGGroupCompletionOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-25.
//
//

#import "TWGGroupCompletionOperation.h"

@implementation TWGGroupCompletionOperation

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
    
    [self.proxyOperation finish];
    [self finish];
}

- (void)finishWithError:(NSError *)error
{
    if([self.proxyOperation.delegate respondsToSelector:@selector(operation:didFailWithError:)]) {
        [self.proxyOperation.delegate operation:self.proxyOperation didFailWithError:error];
    }
    
    [self.proxyOperation finish];
    [self finish];
}

+ (instancetype) groupCompletionOperationWithProxyOperation:(TWGBaseOperation *)proxyOperation
{
    TWGGroupCompletionOperation *operaiton = [[[self class] alloc] init];
    operaiton.proxyOperation = proxyOperation;
    return operaiton;
}


@end
