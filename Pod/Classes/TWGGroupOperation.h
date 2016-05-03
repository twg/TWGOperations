//
//  TWGGroupOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGOperation.h"

@interface TWGGroupOperation : TWGOperation

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

/*
 initWithOperations: adds operations passed to the operationQueue
 subclasses need create sub-operations then [super initWithOperations:]
 to have them execute
 */
- (instancetype)initWithOperations:(NSArray<NSOperation *> *)operations;

/*
 Subclasses of TWGGroupOperation SHOULD NOT override -execute
 See TWGOperation for further subclassing instructions
 */

@end
