//
//  TWGRetryOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
@import TWGOperations;
#import "ReportingOperation.h"
#import <XCTest/XCTest.h>

@interface TWGRetryOperationTests : XCTestCase

@property (nonatomic, strong) TWGRetryOperation *operation;
@property (nonatomic, strong) ReportingOperation *retryableOperation;
@property (nonatomic, strong) ReportingOperation *checkOperation;
@property (nonatomic, strong) id mockOperationQueue;
@property (nonatomic, strong) id operationMock;

@end

@implementation TWGRetryOperationTests

- (void)setUp
{
    [super setUp];

    self.retryableOperation = [[ReportingOperation alloc] init];
    self.checkOperation = [[ReportingOperation alloc] init];

    self.operation =
        [[TWGRetryOperation alloc] initWithOperation:self.retryableOperation andCheckOperation:self.checkOperation];

    self.operationMock = OCMPartialMock(self.operation);
    self.mockOperationQueue = OCMClassMock([NSOperationQueue class]);
    OCMStub([self.operationMock operationQueue]).andReturn(self.mockOperationQueue);
}

- (void)tearDown
{
    self.retryableOperation = nil;
    self.checkOperation = nil;
    self.operation = nil;
    self.mockOperationQueue = nil;
    self.operationMock = nil;

    [super tearDown];
}

- (void)testThatInitWithOperationAndCheckOperaitonSetsPropertiesAndDelegates
{
    TWGRetryOperation *operation =
        [[TWGRetryOperation alloc] initWithOperation:self.retryableOperation andCheckOperation:self.checkOperation];

    expect(operation.operation).to.equal(self.retryableOperation);
    expect(operation.operation.delegate).to.equal(operation);

    expect(operation.checkOperation).to.equal(self.checkOperation);
    expect(operation.checkOperation.delegate).to.equal(operation);
}

- (void)testThatRetryableOperationDidCompleteWithResultCallsFinishWithResult
{
    OCMStub([self.operationMock finishWithResult:OCMOCK_ANY]);
    id mockResult = OCMClassMock([NSObject class]);

    [self.operationMock operation:self.retryableOperation didCompleteWithResult:mockResult];

    OCMVerify([self.operationMock finishWithResult:mockResult]);
}

- (void)testThatCheckOperationDidCompleteWithResultSetsAndAddsRetryOperationToOperationQueue
{
    expect(self.checkOperation.wasCopied).to.beFalsy();
    expect(self.retryableOperation.wasCopied).to.beFalsy();
    expect(self.operation.retryOperation).to.beNil();

    [self.operationMock operation:self.checkOperation didCompleteWithResult:nil];

    expect(self.checkOperation.wasCopied).to.beTruthy();
    expect(self.retryableOperation.wasCopied).to.beTruthy();
    expect(self.operation.retryOperation).toNot.beNil();

    OCMVerify([self.mockOperationQueue addOperation:self.operation.retryOperation]);
}

- (void)testThatRetryOperationDidCompleteWithResultCallsFinishWithResult
{
    id mockRetryOperation = OCMClassMock([TWGRetryOperation class]);
    OCMStub([self.operationMock retryOperation]).andReturn(mockRetryOperation);

    OCMStub([self.operationMock finishWithResult:OCMOCK_ANY]);
    id mockResult = OCMClassMock([NSObject class]);

    [self.operationMock operation:mockRetryOperation didCompleteWithResult:mockResult];

    OCMVerify([self.operationMock finishWithResult:mockResult]);
}

- (void)testThatRetryableOperationDidFailWithErrorDoesNotCallFinishWithError
{
    [[self.operationMock reject] finishWithError:OCMOCK_ANY];

    id mockError = OCMClassMock([NSError class]);
    [self.operationMock operation:self.retryableOperation didFailWithError:mockError];

    OCMVerifyAll(self.operationMock);
}

- (void)testThatCheckOperationDidFailWithErrorCallsFinishWithError
{
    OCMStub([self.operationMock finishWithError:OCMOCK_ANY]);

    id mockError = OCMClassMock([NSError class]);
    [self.operationMock operation:self.checkOperation didFailWithError:mockError];

    OCMVerify([self.operationMock finishWithError:mockError]);
}

- (void)testThatRetryOperationDidFailWithErrorCallsFinishWithError
{
    OCMStub([self.operationMock finishWithError:OCMOCK_ANY]);

    id mockRetryOperation = OCMClassMock([TWGRetryOperation class]);
    OCMStub([self.operationMock retryOperation]).andReturn(mockRetryOperation);

    id mockError = OCMClassMock([NSError class]);
    [self.operationMock operation:self.operation.retryOperation didFailWithError:mockError];

    OCMVerify([self.operationMock finishWithError:mockError]);
}

@end
