//
//  TWGGroupOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGOperation.h"
@class TWGGroupCallbackOperation;

@interface TWGGroupOperation : TWGOperation

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

/*
 initWithOperations: adds operations passed to the operationQueue
 subclasses need create sub-operations then [super initWithOperations:]
 to have them execute
 */
- (instancetype) initWithOperations:(NSArray<NSOperation*>*)operations;

/*
 See TWGBaseOperation for further subclassing instructions
 */


@end
