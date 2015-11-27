//
//  TWGGroupCompletionOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface TWGGroupCompletionOperationTests : XCTestCase

@property (nonatomic, strong) TWGGroupCompletionOperation *operation;
@property (nonatomic, strong) id delegateMock;
@property (nonatomic, strong) id proxyMock;

@end

@implementation TWGGroupCompletionOperationTests

- (void)setUp {
    [super setUp];
    
    self.operation = [[TWGGroupCompletionOperation alloc] init];
    
    self.proxyMock = OCMClassMock([TWGOperation class]);
    self.delegateMock = OCMProtocolMock(@protocol(TWGOperationDelegate));
    OCMStub([self.proxyMock delegate]).andReturn(self.delegateMock);
    
    self.operation.proxyOperation = self.proxyMock;
}

- (void)tearDown {
    
    self.operation = nil;
    self.proxyMock = nil;
    self.delegateMock = nil;
    
    [super tearDown];
}

- (void)testThatStaticInitalizerSetsProxyOperation
{
    id proxyOperation = OCMClassMock([TWGOperation class]);
    
    TWGGroupCompletionOperation *operation =
        [TWGGroupCompletionOperation groupCompletionOperationWithProxyOperation:proxyOperation];
    
    expect(operation.proxyOperation).to.equal(proxyOperation);
}

- (void)testThatExecuteCallsFinishWithResultWithAResult
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finishWithResult:OCMOCK_ANY]);
    
    id mockResult = OCMClassMock([NSObject class]);
    [operationMock setResult:mockResult];
    
    [operationMock execute];
    
    OCMVerify([operationMock finishWithResult:mockResult]);
}

- (void)testThatExecuteCallsFinishWithResultWithNilResult
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finishWithResult:OCMOCK_ANY]);
    
    [operationMock execute];
    
    OCMVerify([operationMock finishWithResult:nil]);
}

- (void)testThatExecuteCallsFinishWithErrorWithAnError
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finishWithError:OCMOCK_ANY]);
    
    id mockError = OCMClassMock([NSError class]);
    [operationMock setError:mockError];
    
    [operationMock execute];
    
    OCMVerify([operationMock finishWithError:mockError]);
}

- (void)testThatExecuteCallsFinishWithErrorWhenBothErrorAndResult
{
    id operationMock = OCMPartialMock(self.operation);
    
    id mockError = OCMClassMock([NSError class]);
    [operationMock setError:mockError];
    
    id mockResult = OCMClassMock([NSObject class]);
    [operationMock setResult:mockResult];
    
    [[operationMock reject] finishWithResult:mockResult];
    OCMExpect([operationMock finishWithError:mockError]);
    
    [operationMock execute];
    
    OCMVerifyAll(operationMock);
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

- (void)testThatFinishWithResultCallsFinishOnProxy
{
    [self.operation finishWithResult:nil];
    OCMVerify([self.proxyMock finish]);
}

- (void)testThatFinishWithErrorCallsFinishOnProxy
{
    id mockError = OCMClassMock([NSError class]);
    
    [self.operation finishWithError:mockError];
    OCMVerify([self.proxyMock finish]);
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
