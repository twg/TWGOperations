//
//  NSObjectPerformBlockTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface NSObjectPerformBlockTests : XCTestCase

@property (nonatomic, strong) NSObject *object;

@end

@implementation NSObjectPerformBlockTests

- (void)setUp {
	[super setUp];
	
	self.object = [[NSObject alloc] init];
	
}

- (void)tearDown {
	
	self.object = nil;
	
	[super tearDown];
}


- (void)testThatPerformBlockOnMainThreadRunsBlock
{
	id mockString = OCMClassMock([NSString class]);
	
	[self.object performBlockOnMainThread:^{
		[mockString length];
	} waitUntilDone:YES];
	
	OCMVerify([mockString length]);
}


- (void)testThatPerformBlockOnMainThreadPerformsOnMainThread
{
	id mockString = OCMClassMock([NSString class]);
	
	[self.object performBlockOnMainThread:^{
		if([NSThread isMainThread]) {
			[mockString length];
		}
	} waitUntilDone:YES];
	
	OCMVerify([mockString length]);
}

- (void)testThatPerformBLockOnMainThreadPerformsOnMainThreadWhenDispatchedFromBackground
{
	__block id mockString = OCMClassMock([NSString class]);
	
	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
		[self.object performBlockOnMainThread:^{
			if([NSThread isMainThread]) {
				[mockString length];
			}
		} waitUntilDone:YES];
		
		
	});
	
	OCMVerify([mockString length]);
}

@end
