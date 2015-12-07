//
//  ExecutionOrderReportOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-07.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "CompletionOrderReportOperation.h"

@implementation CompletionOrderReportOperation

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    @synchronized(self) {
        if(operation) {
            [self.completedOperations addObject:operation];
        }
    }
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}

- (NSMutableArray *)completedOperations
{
    if(_completedOperations == nil) {
        _completedOperations = [NSMutableArray new];
    }
    return _completedOperations;
}

@end
