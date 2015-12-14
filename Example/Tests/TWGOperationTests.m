//
//  TWGBaseOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-10-09.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <XCTest/XCTest.h>

@interface TWGOperationTests : XCTestCase

@property (nonatomic, strong) TWGOperation *operation;

@end

@implementation TWGOperationTests

- (void)setUp
{
    [super setUp];

    self.operation = [[TWGOperation alloc] init];
}

- (void)tearDown
{

    self.operation = nil;

    [super tearDown];
}

#pragma mark Internal Tests

- (void)testThatStartSetsIsExecutingToYes
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock execute]);

    expect([operationMock isExecuting]).to.beFalsy();

    [operationMock start];

    expect([operationMock isExecuting]).to.beTruthy();
}

- (void)testThatACanceledOperaitonDoesNotExecute
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock isCancelled]).andReturn(YES);

    [[operationMock reject] execute];

    [operationMock start];

    OCMVerifyAll(operationMock);
}

- (void)testThatACanceledOperaitonCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock isCancelled]).andReturn(YES);
    OCMStub([operationMock finish]);

    [operationMock start];

    OCMVerify([operationMock finish]);
}

- (void)testThatFinishSetsIsFinishedToYes
{
    id operationMock = OCMPartialMock(self.operation);

    expect([operationMock isFinished]).to.beFalsy();

    [operationMock finish];

    expect([operationMock isFinished]).to.beTruthy();
}

- (void)testThatFinishSetsIsExecutingToNo
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock execute]);

    [operationMock start];

    expect([operationMock isExecuting]).to.beTruthy();

    [operationMock finish];

    expect([operationMock isExecuting]).to.beFalsy();
}

- (void)testThatStartCallsExecute
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock execute]);

    [operationMock start];

    OCMVerify([operationMock execute]);
}

- (void)testThatExecuteCallsFinishWithResult
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finishWithResult:OCMOCK_ANY]);

    [operationMock execute];

    OCMVerify([operationMock finishWithResult:nil]);
}

#pragma mark Delegate Call Convenience Methods

- (void)testThatFinishWithResultCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finish]);

    [operationMock finishWithResult:nil];

    OCMVerify([operationMock finish]);
}

- (void)testThatFinishWithErrorCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finish]);

    [operationMock finishWithError:nil];

    OCMVerify([operationMock finish]);
}

#pragma mark Delegate Tests

- (void)testThatFinishWithResultInformsDelegateOfCompletionWithResult
{
    id mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = mockDelegate;

    id mockResult = OCMClassMock([NSObject class]);

    [self.operation finishWithResult:mockResult];

    OCMVerify([mockDelegate operation:self.operation didCompleteWithResult:mockResult]);
}

- (void)testThatFinishWithNilResultInformsDelegateOfCompletionWithNil
{
    id mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = mockDelegate;

    [self.operation finishWithResult:nil];

    OCMVerify([mockDelegate operation:self.operation didCompleteWithResult:nil]);
}

- (void)testThatFinishWithErrorInformsDelegateOfCompletionWithError
{
    id mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = mockDelegate;

    id mockError = OCMClassMock([NSError class]);

    [self.operation finishWithError:mockError];

    OCMVerify([mockDelegate operation:self.operation didFailWithError:mockError]);
}

- (void)testThatFinishWithNilErrorInformsDelefateOfCompletionWithNilError
{
    id mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = mockDelegate;

    [self.operation finishWithError:nil];

    OCMVerify([mockDelegate operation:self.operation didFailWithError:nil]);
}

- (void)testThatStartSetsStartTime
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock execute]);

    expect(self.operation.startTime).to.equal(0);
	
	[operationMock start];
	
	expect(self.operation.startTime).toNot.equal(0);
}

- (void)testThatFinishSetsEndTime
{
	expect(self.operation.endTime).to.equal(0);
	
	[self.operation finish];
	
	expect(self.operation.endTime).toNot.equal(0);
}

@end
