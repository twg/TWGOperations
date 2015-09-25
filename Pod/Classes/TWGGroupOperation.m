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

@property (nonatomic, strong) NSBlockOperation *completionOperation;

@end

@implementation TWGGroupOperation

- (void)setupOperations {}

- (void)execute
{
    [self setupOperations];
    
    self.completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self finish];
    }];
    
    if([self.operations count]) {
        [self.completionOperation addDependencies:self.operations];
        [self.operationQueue addOperations:self.operations waitUntilFinished:NO];
    }
    
    [self.operationQueue addOperation:self.completionOperation];
}

- (void)finish
{
    self.completionOperation = nil;
    [super finish];
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
