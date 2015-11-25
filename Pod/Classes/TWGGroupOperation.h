//
//  TWGGroupOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGBaseOperation.h"

@interface TWGGroupOperation : TWGBaseOperation

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

@property (nonatomic, assign, getter=isSerial) BOOL serial;

- (instancetype) initWithOperations:(NSArray<NSOperation*>*)operations;

@end
