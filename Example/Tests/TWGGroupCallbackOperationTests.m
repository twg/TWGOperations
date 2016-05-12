//
//  TWGGroupCallbackOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
@import TWGOperations;
#import <XCTest/XCTest.h>

@interface TWGGroupCallbackOperationTests : XCTestCase

@property (nonatomic, strong) TWGGroupCallbackOperation *operation;
@property (nonatomic, strong) id delegateMock;
@property (nonatomic, strong) id proxyMock;

@end

@implementation TWGGroupCallbackOperationTests

- (void)setUp
{
    [super setUp];

    self.operation = [[TWGGroupCallbackOperation alloc] init];

    self.proxyMock = OCMClassMock([TWGOperation class]);
    self.delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    OCMStub([self.proxyMock delegate]).andReturn(self.delegateMock);

    self.operation.proxyOperation = self.proxyMock;
}

- (void)tearDown
{

    self.operation = nil;
    self.proxyMock = nil;
    self.delegateMock = nil;

    [super tearDown];
}

- (void)testThatStaticInitalizerSetsProxyOperation
{
    id proxyOperation = OCMClassMock([TWGOperation class]);

    TWGGroupCallbackOperation *operation =
        [TWGGroupCallbackOperation groupCallbackOperationWithProxyOperation:proxyOperation];

    expect(operation.proxyOperation).to.equal(proxyOperation);
}

- (void)testThatExecuteCallsFinishWithResultWithAResult
{
    self.operation.action = TWGGroupCallbackOperationActionSuccess;
    id mockResult = OCMClassMock([NSObject class]);
    self.operation.value = mockResult;
    id operationMock = OCMPartialMock(self.operation);

    [operationMock execute];

    OCMVerify([operationMock finishWithResult:mockResult]);
}

- (void)testThatExecuteCallsFinishWithResultWithNilResult
{
    self.operation.action = TWGGroupCallbackOperationActionSuccess;
    self.operation.value = nil;
    id operationMock = OCMPartialMock(self.operation);

    [operationMock execute];

    OCMVerify([operationMock finishWithResult:nil]);
}

- (void)testThatExecuteCallsFinishWithErrorWithAnError
{
    self.operation.action = TWGGroupCallbackOperationActionError;
    id mockError = OCMClassMock([NSError class]);
    self.operation.value = mockError;
    id operationMock = OCMPartialMock(self.operation);

    [operationMock execute];

    OCMVerify([operationMock finishWithError:mockError]);
}

- (void)testThatExecuteCallsFinishWithErrorWithANilError
{
    self.operation.action = TWGGroupCallbackOperationActionError;
    self.operation.value = nil;
    id operationMock = OCMPartialMock(self.operation);

    [operationMock execute];

    OCMVerify([operationMock finishWithError:nil]);
}

- (void)testThatExecuteCallsFinishWithResulyForAnUnknownAction
{
	self.operation.action = 100;
	
	id mockResult = OCMClassMock([NSObject class]);
	
	self.operation.value = mockResult;
	id operationMock = OCMPartialMock(self.operation);
	
	[operationMock execute];
	
	OCMVerify([operationMock finishWithResult:mockResult]);
}

- (void)testThatConfigureValueForResultSetsTheValue
{
    [self.operation configureValueForResult:nil];

    expect(self.operation.action).to.equal(TWGGroupCallbackOperationActionSuccess);
}

- (void)testThatConfigureValueForErrorSetsTheError
{
    [self.operation configureValueForError:nil];

    expect(self.operation.action).to.equal(TWGGroupCallbackOperationActionError);
}

- (void)testThatConfigureValueForErrorSetsTheAction
{
    id mockError = OCMClassMock([NSError class]);

    [self.operation configureValueForError:mockError];
    expect(self.operation.value).to.equal(mockError);
}

- (void)testThatConfigureValueForResultSetsTheAction
{
    id mockResult = OCMClassMock([NSObject class]);

    [self.operation configureValueForResult:mockResult];
    expect(self.operation.value).to.equal(mockResult);
}

#pragma mark delegate tests

- (void)testThatFinishWithResultCallsProxyDelegateWithProxyAndResult
{
    id mockResult = OCMClassMock([NSObject class]);

    [self.operation finishWithResult:mockResult];

    OCMVerify([self.delegateMock operation:self.proxyMock didCompleteWithResult:mockResult]);
}

- (void)testThatFinishWithNilResultCallsProxyDelegateWithProxyAndNilResult
{
    [self.operation finishWithResult:nil];

    OCMVerify([self.delegateMock operation:self.proxyMock didCompleteWithResult:nil]);
}

- (void)testThatFinishWithErrorCallsProxyDelegateWithProxyAndError
{
    id mockError = OCMClassMock([NSError class]);

    [self.operation finishWithError:mockError];

    OCMVerify([self.delegateMock operation:self.proxyMock didFailWithError:mockError]);
}

- (void)testThatFinishWithResultCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);

    [operationMock finishWithResult:nil];

    OCMVerify([operationMock finish]);
}

- (void)testThatFinishWithErrorCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);

    id mockError = OCMClassMock([NSError class]);
    [operationMock finishWithError:mockError];

    OCMVerify([operationMock finish]);
}

@end
