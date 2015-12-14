//
//  NSObject+PerformBlock.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-12-11.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

- (void)performBlockOnMainThread:(dispatch_block_t)block waitUntilDone:(BOOL)wait;

@end
