//
//  NSObject+PerformBlock.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-12-11.
//
//

#import "NSObject+PerformBlock.h"

@interface BlockContainer : NSObject
@property(nonatomic, copy) dispatch_block_t block;

+ (instancetype)blockContainerWithBlock:(dispatch_block_t)block;
@end

@implementation NSObject (PerformBlock)

- (void)performBlockOnMainThread:(dispatch_block_t)block
				   waitUntilDone:(BOOL)wait {
	
	BlockContainer *container = [BlockContainer blockContainerWithBlock:block];
	
	[self performSelectorOnMainThread:@selector(runBlockWithBlockContainer:)
						   withObject:container
						waitUntilDone:wait];
}

- (void)runBlockWithBlockContainer:(BlockContainer *)container {
	if (container.block) {
		container.block();
	}
}

@end

@implementation BlockContainer

+ (instancetype)blockContainerWithBlock:(dispatch_block_t)block {
	BlockContainer *container = [[[self class] alloc] init];
	container.block = block;
	return container;
}

@end