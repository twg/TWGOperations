//
//  TWGDelayOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#import "TWGBaseOperation.h"

@interface TWGDelayOperation : TWGBaseOperation

@property (nonatomic, assign) NSTimeInterval delay;

+ (instancetype)delayOperationWithDelay:(NSTimeInterval)delay;

@end
