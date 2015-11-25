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
@property (nonatomic, strong) NSArray<NSOperation*>* operations;

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
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf finish];
    }];
    
    if([self.operations count]) {
        [completionOperation addDependencies:self.operations];
        [self.operationQueue addOperations:self.operations waitUntilFinished:NO];
    }
    
    [self.operationQueue addOperation:completionOperation];
}

- (void)setSerial:(BOOL)serial
{
    if(_serial != serial) {
        _serial = serial;
    }
    
    NSInteger maxConcurrentOperations = (serial)? 1 : NSOperationQueueDefaultMaxConcurrentOperationCount;
    [self.operationQueue setMaxConcurrentOperationCount:maxConcurrentOperations];
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
