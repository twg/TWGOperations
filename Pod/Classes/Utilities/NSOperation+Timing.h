//
//  NSOperation+Timing.h
//  Pods
//
//  Created by Nicholas Kuhne on 2016-05-02.
//
//

#import <Foundation/Foundation.h>

@interface NSOperation (Timing)

/*
used to time the total duraiton of an execution of an NSOperation
*/
- (void)clockAndReport:(void(^)(NSTimeInterval duration))reportBlock;

@end
