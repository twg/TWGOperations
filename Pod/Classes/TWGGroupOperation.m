//
//  TWGGroupOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "NSOperation+GroupDependencies.h"
#import "NSOperationQueueKVOKeys.h"
#import "TWGGroupOperation.h"

static void * const TWGGroupOperationKVOContext = (void*)&TWGGroupOperationKVOContext;

@interface TWGGroupOperation ()

@property (nonatomic, strong, nonnull) NSOperationQueue *operationQueue;
@property (nonatomic, strong, nonnull) NSArray<NSOperation *> *operations;

@end

@implementation TWGGroupOperation

- (nonnull instancetype)initWithOperations:(nonnull NSArray<NSOperation *>  *)operations
{
    if (self = [super init]) {
        self.operations = operations;
		self.operationQueue.suspended = YES;
		
		[self.operationQueue addObserver:self forKeyPath:NSOperationQueueOperationCount options:NSKeyValueChangeNewKey context:TWGGroupOperationKVOContext];
    }
    return self;
}

- (void)execute
{
    if ([self.operations count]) {
        [self.operationQueue addOperations:self.operations waitUntilFinished:NO];
		self.operationQueue.suspended = NO;
    }
	else {
		[self finishWithError:nil];
	}
}

- (void)finishWithResult:(id)result
{
	[super finishWithResult:result];
	[self.operationQueue cancelAllOperations];
}

- (void)finishWithError:(NSError *)error
{
	[super finishWithError:error];
	[self.operationQueue cancelAllOperations];
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
    }
    return _operationQueue;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if(context == TWGGroupOperationKVOContext) {
		if(self.operationQueue.suspended == NO && self.operationQueue.operationCount == 0) {
			if([self isExecuting]) {
				[super finishWithResult:nil];
			}
		}
	}
}

- (void)dealloc
{
	[self.operationQueue removeObserver:self forKeyPath:NSOperationQueueOperationCount];
}

@end
