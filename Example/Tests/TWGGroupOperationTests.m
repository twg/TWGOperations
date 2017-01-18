//
//  TWGGroupOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

@interface TWGGroupOperation (Testable)

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSArray<NSOperation *> *operations;

@end

@interface TWGGroupOperationTests : XCTestCase

@property (nonatomic, strong) id mockOperation1;
@property (nonatomic, strong) id mockOperation2;
@property (nonatomic, strong) id mockOperation3;
@property (nonatomic, strong) id mockOperationQueue;

@property (nonatomic, strong) TWGGroupOperation *operation;

@property (nonatomic, strong) id mockDelegate;

@end

@implementation TWGGroupOperationTests

- (void)setUp
{
    [super setUp];

    self.mockOperation1 = OCMClassMock([NSOperation class]);
    self.mockOperation2 = OCMClassMock([NSOperation class]);
    self.mockOperation3 = OCMClassMock([NSOperation class]);

    self.mockOperationQueue = OCMClassMock([NSOperationQueue class]);

    NSArray *operations = @[ self.mockOperation1, self.mockOperation2, self.mockOperation3 ];

    self.operation = [[TWGGroupOperation alloc] initWithOperations:operations];
    self.operation.operationQueue = self.mockOperationQueue;
	
	self.mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
	self.operation.delegate = self.mockDelegate;
}

- (void)tearDown
{
    self.mockOperation1 = nil;
    self.mockOperation2 = nil;
    self.mockOperation3 = nil;

    self.operation = nil;
    self.mockOperationQueue = nil;
	
	[self.mockDelegate stopMocking];
	self.mockDelegate = nil;

    [super tearDown];
}

#pragma mark public interfaces

- (void)testThatInitWithOperationSetsOperations
{
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);

    NSArray *operations = @[ mockOperation1, mockOperation2, mockOperation3 ];

    TWGGroupOperation *groupOperation = [[TWGGroupOperation alloc] initWithOperations:operations];

    expect(groupOperation.operations).to.equal(operations);
}

#pragma mark execute

- (void)testThatExecuteAddsAllOperationsToOperationQueue
{
    [self.operation execute];

    OCMVerify([self.mockOperationQueue addOperations:self.operation.operations waitUntilFinished:NO]);
}

#pragma mark finishWithResult

- (void)testThatFinsihWithResultInformsDelegate
{
	id mockResult = OCMClassMock([NSObject class]);
	
	[self.operation finishWithResult:mockResult];
	
	OCMVerify([self.mockDelegate operation:self.operation didCompleteWithResult:mockResult]);
}

- (void)testThatFinishWithErrorInformsDelegate
{
	id mockError = OCMClassMock([NSError class]);
	
	[self.operation finishWithError:mockError];
	
	OCMVerify([self.mockDelegate operation:self.operation didFailWithError:mockError]);
}

- (void)testThatFinishWithErrorCallsCancelAllRemainingOperations
{
    [self.operation finishWithError:nil];

    OCMVerify([self.mockOperationQueue cancelAllOperations]);
}

- (void)testThatCancelCancelesAllOperationsOnOperationQueue
{
    [self.operation cancel];

    OCMVerify([self.mockOperationQueue cancelAllOperations]);
}

- (void)testThatCancelCallsFinish
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock finish]);

    [operationMock cancel];

    OCMVerify([operationMock finish]);
}

@end
