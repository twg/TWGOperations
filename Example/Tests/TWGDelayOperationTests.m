//
//  TWGDelayOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

@interface TWGDelayOperationTests : XCTestCase

@property (nonatomic, strong) TWGDelayOperation *operation;

@end

@implementation TWGDelayOperationTests

- (void)setUp
{
    [super setUp];

    self.operation = [[TWGDelayOperation alloc] init];
}

- (void)tearDown
{

    self.operation = nil;

    [super tearDown];
}

- (void)testThatItCallsFinishAfterDelay
{
    NSTimeInterval delay = 0.01f;

    id operationMock = OCMPartialMock(self.operation);
    OCMExpect([operationMock finishWithResult:OCMOCK_ANY]);

    [operationMock setDelay:delay];

    [operationMock execute];

    OCMVerifyAllWithDelay(operationMock, delay);
}

- (void)testThatStaticInitalizerSetsDelay
{
    NSTimeInterval delay = 1.f;

    TWGDelayOperation *operation = [TWGDelayOperation delayOperationWithDelay:delay];

    expect(operation.delay).to.equal(delay);
}

@end
