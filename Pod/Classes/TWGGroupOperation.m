//
//  TWGGroupOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGGroupOperation.h"
#import "NSOperation+GroupDependencies.h"
#import "TWGGroupCompletionOperation.h"


@interface TWGGroupOperation ()

@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSArray<NSOperation*>* operations;

@property (nonatomic, strong) TWGGroupCompletionOperation *completionOperation;

@end

@implementation TWGGroupOperation

- (instancetype)initWithOperations:(NSArray<NSOperation *> *)operations
{
    if(self = [super init]) {
        self.operations = operations;
    }
    return self;
}

- (void)execute
{
    self.completionOperation = [TWGGroupCompletionOperation groupCompletionOperationWithProxyOperation:self];
    
    if([self.operations count]) {
        [self.completionOperation addDependencies:self.operations];
        [self.operationQueue addOperations:self.operations waitUntilFinished:NO];
    }
    
    [self.operationQueue addOperation:self.completionOperation];
}

- (void)finishWithResult:(id)result
{
    self.completionOperation.result = result;
    [self cancelAllRemainingOperations];
}

- (void)finishWithError:(NSError *)error
{
    self.completionOperation.error = error;
    [self cancelAllRemainingOperations];
}

- (void)cancelAllRemainingOperations
{
    for (NSOperation *operation in self.operations) {
        if(![operation isFinished] && ![operation isExecuting]) {
            [operation cancel];
        }
    }
}

- (NSOperationQueue *)operationQueue
{
    if(_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return _operationQueue;
}

@end
