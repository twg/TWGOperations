//
//  TWGDelayOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#import "TWGOperation.h"

/*
 This operation provides a way to create non thread-blocking delays in a chain of operations
 */

@interface TWGDelayOperation : TWGOperation <NSCopying>

@property (nonatomic, assign) NSTimeInterval delay;

+ (nonnull instancetype)delayOperationWithDelay:(NSTimeInterval)delay;

@end
