//
//  NSObjectPerformBlockTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

@interface NSObjectPerformBlockTests : XCTestCase

@property (nonatomic, strong) NSObject *object;

@end

@implementation NSObjectPerformBlockTests

- (void)setUp
{
    [super setUp];

    self.object = [[NSObject alloc] init];
}

- (void)tearDown
{

    self.object = nil;

    [super tearDown];
}

- (void)testThatPerformBlockOnMainThreadRunsBlock
{
    id mockObject = OCMClassMock([NSObject class]);

    [self.object performBlockOnMainThread:^{
        [mockObject hash];
    }
                            waitUntilDone:YES];

    OCMVerify([mockObject hash]);
}

- (void)testThatPerformBlockOnMainThreadPerformsOnMainThread
{
    id mockObject = OCMClassMock([NSObject class]);

    [self.object performBlockOnMainThread:^{
        if ([NSThread isMainThread]) {
            [mockObject hash];
        }
    }
                            waitUntilDone:YES];

    OCMVerify([mockObject hash]);
}

- (void)testThatPerformBLockOnMainThreadPerformsOnMainThreadWhenDispatchedFromBackground
{
    __block id mockObject = OCMClassMock([NSObject class]);

    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        [self.object performBlockOnMainThread:^{
            if ([NSThread isMainThread]) {
                [mockObject hash];
            }
        }
                                waitUntilDone:YES];

    });

    OCMVerify([mockObject hash]);
}

@end
