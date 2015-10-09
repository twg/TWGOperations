//
//  TWGGroupOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGGroupOperation.h"
#import "NSOperation+GroupDependencies.h"

@interface TWGGroupOperation ()

@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;

@end

@implementation TWGGroupOperation

- (NSArray<NSOperation *> *)operations
{
    return nil;
}

- (void)execute
{
    NSArray *operations = [self operations];
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf finish];
    }];
    
    if([self.operations count]) {
        [completionOperation addDependencies:operations];
        [self.operationQueue addOperations:operations waitUntilFinished:NO];
    }
    
    [self.operationQueue addOperation:completionOperation];
}

- (void)setSerial:(BOOL)serial
{
    if(_serial != serial) {
        _serial = serial;
    }
    
    NSInteger maxConcurrentOperaitons = (serial)? 1 : NSOperationQueueDefaultMaxConcurrentOperationCount;
    [self.operationQueue setMaxConcurrentOperationCount:maxConcurrentOperaitons];
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
