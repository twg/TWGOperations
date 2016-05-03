//
//  TWGRetryOperationIntegrationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import "CheckPassOperation.h"
#import "ReportingOperation.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "TWGRetryOperation.h"

@interface TWGRetryOperationIntegrationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation TWGRetryOperationIntegrationTests

- (void)setUp
{
	[super setUp];
	
	self.operationQueue = [[NSOperationQueue alloc] init];
	self.mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
}

- (void)tearDown
{
	self.operationQueue = nil;
	self.mockDelegate = nil;
	
	[super tearDown];
}

- (void)testWhenRetryableOperationCompletesThatOperationFinishesWithResult
{
	ReportingOperation *retryableOperation = [[ReportingOperation alloc] init];
	ReportingOperation *checkOperation = [[ReportingOperation alloc] init];
	
	TWGRetryOperation *operation = [[TWGRetryOperation alloc] initWithOperation:retryableOperation andCheckOperation:checkOperation];
	operation.delegate = self.mockDelegate;
	
	[self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
	
	OCMVerify([self.mockDelegate operation:operation didCompleteWithResult:nil]);
}

- (void)testWhenRetryableOperationFailsThatRetryableOperationFails
{
	ReportingOperation *retryableOperation = [[ReportingOperation alloc] init];
	retryableOperation.shouldFail = YES;
	ReportingOperation *checkOperation = [[ReportingOperation alloc] init];
	checkOperation.shouldFail = YES;
	
	TWGRetryOperation *operation = [[TWGRetryOperation alloc] initWithOperation:retryableOperation andCheckOperation:checkOperation];
	operation.delegate = self.mockDelegate;
	
	expect(retryableOperation.didRun).to.beFalsy();
	expect(checkOperation.didRun).to.beFalsy();
	
	[self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
	
	expect(retryableOperation.didRun).to.beTruthy();
	expect(checkOperation.didRun).to.beTruthy();
	OCMVerify([self.mockDelegate operation:operation didFailWithError:nil]);
}

- (void)testThatOperationCanRunAgainSuccessfuly
{
	ReportingOperation *retryableOperation = [[ReportingOperation alloc] init];
	retryableOperation.shouldFail = YES;
	CheckPassOperation *checkOperation = [[CheckPassOperation alloc] init];
	checkOperation.maxPasses = 1;
	
	TWGRetryOperation *operation = [[TWGRetryOperation alloc] initWithOperation:retryableOperation andCheckOperation:checkOperation];
	operation.delegate = self.mockDelegate;
	
	[self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
	
	CheckPassOperation *copiedCheckOperation = (CheckPassOperation *)operation.retryOperation.checkOperation;
	expect(copiedCheckOperation.numberOfPasses).to.equal(1);
	
	OCMVerify([self.mockDelegate operation:operation didFailWithError:nil]);
}

- (void)testThatOperationCanRun5TimesSuccessfuly
{
	ReportingOperation *retryableOperation = [[ReportingOperation alloc] init];
	retryableOperation.shouldFail = YES;
	CheckPassOperation *checkOperation = [[CheckPassOperation alloc] init];
	checkOperation.maxPasses = 5;
	
	TWGRetryOperation *operation = [[TWGRetryOperation alloc] initWithOperation:retryableOperation andCheckOperation:checkOperation];
	operation.delegate = self.mockDelegate;
	
	[self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
	
	expect(checkOperation.numberOfPasses).to.equal(1);
	
	TWGRetryOperation *retryOperation = (TWGRetryOperation *)operation.retryOperation;
	CheckPassOperation *copiedCheckOperation = (CheckPassOperation *)retryOperation.checkOperation;
	expect(copiedCheckOperation.numberOfPasses).to.equal(2);
	
	TWGRetryOperation *retry2Operation = (TWGRetryOperation *)operation.retryOperation.retryOperation;
	CheckPassOperation *copied1CheckOperation = (CheckPassOperation *)retry2Operation.checkOperation;
	expect(copied1CheckOperation.numberOfPasses).to.equal(3);
	
	TWGRetryOperation *retry3Operation = (TWGRetryOperation *)operation.retryOperation.retryOperation.retryOperation;
	CheckPassOperation *copied2CheckOperation = (CheckPassOperation *)retry3Operation.checkOperation;
	expect(copied2CheckOperation.numberOfPasses).to.equal(4);
	
	TWGRetryOperation *retry4Operation = (TWGRetryOperation *)operation.retryOperation.retryOperation.retryOperation.retryOperation;
	CheckPassOperation *copied3CheckOperation = (CheckPassOperation *)retry4Operation.checkOperation;
	expect(copied3CheckOperation.numberOfPasses).to.equal(5);
	
	OCMVerify([self.mockDelegate operation:operation didFailWithError:nil]);
}

@end
