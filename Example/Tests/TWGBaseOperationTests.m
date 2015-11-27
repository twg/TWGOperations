//
//  TWGBaseOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-10-09.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface TWGOperationTests : XCTestCase

@property (nonatomic, strong) TWGOperation *operation;

@end

@implementation TWGOperationTests

- (void)setUp {
    [super setUp];
    
    self.operation = [[TWGOperation alloc] init];
}

- (void)tearDown {
    
    self.operation = nil;
    
    [super tearDown];
}

#pragma mark Internal Tests

- (void)testThatStartSetsIsExecutingToYes
{
    id partialMock = OCMPartialMock(self.operation);
    OCMStub([partialMock execute]);
    
    expect([partialMock isExecuting]).to.beFalsy();
    
    [partialMock start];
    
    expect([partialMock isExecuting]).to.beTruthy();
}

- (void)testThatFinishSetsIsFinishedToYes
{
    id partialMock = OCMPartialMock(self.operation);
    
    expect([partialMock isFinished]).to.beFalsy();
    
    [partialMock finish];
    
    expect([partialMock isFinished]).to.beTruthy();
}

- (void)testThatFinishSetsisExecutingToNo
{
    id partialMock = OCMPartialMock(self.operation);
    OCMStub([partialMock execute]);
    
    [partialMock start];
    
    expect([partialMock isExecuting]).to.beTruthy();
    
    [partialMock finish];
    
    expect([partialMock isExecuting]).to.beFalsy();
}

- (void)testThatStartCallsExecute
{
    id mockOperation = OCMPartialMock(self.operation);
    OCMStub([mockOperation execute]);
    
    [mockOperation start];
    
    OCMVerify([mockOperation execute]);
}

- (void)testThatExecuteCallsFinish
{
    id mockOperation = OCMPartialMock(self.operation);
    OCMStub([mockOperation finish]);
    
    [mockOperation execute];
    
    OCMVerify([mockOperation finish]);
}

#pragma mark Delegate Call Convenience Methods

- (void)testThatFinishWithResultCallsFinish
{
    id mockOperation = OCMPartialMock(self.operation);
    OCMStub([mockOperation finish]);
    
    [mockOperation finishWithResult:nil];
    
    OCMVerify([mockOperation finish]);
}

- (void)testThatFinishWithErrorCallsFinish
{
    id mockOperation = OCMPartialMock(self.operation);
    OCMStub([mockOperation finish]);
    
    [mockOperation finishWithError:nil];
    
    OCMVerify([mockOperation finish]);
}

#pragma mark Delegate Tests

- (void)testThatFinishWithResultInformsDelegateOfCompletionWithResult
{
    id delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = delegateMock;
    
    id mockResult = OCMClassMock([NSObject class]);
    
    [self.operation finishWithResult:mockResult];
    
    OCMVerify([delegateMock operation:self.operation didCompleteWithResult:mockResult]);
}

- (void)testThatFinishWithNilResultInformsDelegateOfCompletionWithNil
{
    id delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = delegateMock;
    
    [self.operation finishWithResult:nil];
    
    OCMVerify([delegateMock operation:self.operation didCompleteWithResult:nil]);
}

- (void)testThatFinishWithErrorInformsDelegateOfCompletionWithError
{
    id delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = delegateMock;
    
    id mockError = OCMClassMock([NSError class]);
    
    [self.operation finishWithError:mockError];
    
    OCMVerify([delegateMock operation:self.operation didFailWithError:mockError]);
}

- (void)testThatFinishWithNilErrorInformsDelefateOfCompletionWithNilError
{
    id delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    self.operation.delegate = delegateMock;
    
    [self.operation finishWithError:nil];
    
    OCMVerify([delegateMock operation:self.operation didFailWithError:nil]);
}


@end
