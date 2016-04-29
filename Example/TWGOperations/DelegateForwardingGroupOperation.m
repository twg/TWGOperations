//
//  DelegateForwardingGroupOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "DelegateForwardingGroupOperation.h"

@implementation DelegateForwardingGroupOperation

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    [self finishWithResult:result];
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}

@end
