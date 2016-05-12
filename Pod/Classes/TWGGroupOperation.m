//
//  TWGGroupOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "NSOperation+GroupDependencies.h"
#import "TWGGroupCallbackOperation.h"
#import "TWGGroupOperation.h"

@interface TWGGroupOperation ()

@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSArray<NSOperation *> *operations;

@property (nonatomic, strong) TWGGroupCallbackOperation *callbackOperation;
@property (nonatomic, strong) NSBlockOperation *completionOperation;

@end

@implementation TWGGroupOperation

- (instancetype)initWithOperations:(NSArray<NSOperation *> *)operations
{
    if (self = [super init]) {
        self.operations = operations;
    }
    return self;
}

- (void)execute
{
    self.callbackOperation = [TWGGroupCallbackOperation groupCallbackOperationWithProxyOperation:self];

    if ([self.operations count]) {
        [self.callbackOperation addDependencies:self.operations];
        [self.operationQueue addOperations:self.operations waitUntilFinished:NO];
    }

    __weak typeof(self) weakSelf = self;
    self.completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf finish];
    }];

    [self.completionOperation addDependency:self.callbackOperation];

    [self.operationQueue addOperation:self.callbackOperation];
    [self.operationQueue addOperation:self.completionOperation];
}

- (void)finishWithResult:(id)result
{
    [self.callbackOperation configureValueForResult:result];
    [self cancelAllRemainingOperations];
}

- (void)finishWithError:(NSError *)error
{
    [self.callbackOperation configureValueForError:error];
    [self cancelAllRemainingOperations];
}

- (void)cancelAllRemainingOperations
{
    for (NSOperation *operation in self.operations) {
        if (![operation isFinished] && ![operation isExecuting]) {
            [operation cancel];
        }
    }
}

- (void)cancel
{
    [super cancel];
    [self.operationQueue cancelAllOperations];
    [self finish];
}

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.name = NSStringFromClass([self class]);
        _operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return _operationQueue;
}

@end
