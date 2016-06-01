//
//  TWGOperationIntegrationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import "FailingOperation.h"
#import "SucceedingOperation.h"
#import "TWGOperation+BlockCompletion.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

@interface TWGOperationIntegrationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation TWGOperationIntegrationTests

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

#pragma mark delegate tests

- (void)testThatASuccedingOperationCallsDelegateSuccess
{
    SucceedingOperation *operation = [[SucceedingOperation alloc] init];
    operation.delegate = self.mockDelegate;

    id mockResult = OCMClassMock([NSObject class]);
    operation.result = mockResult;

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    OCMVerify([self.mockDelegate operation:operation didCompleteWithResult:mockResult]);
}

- (void)testThatAFailingOperationCallsDelegateFailure
{
    FailingOperation *operation = [[FailingOperation alloc] init];
    operation.delegate = self.mockDelegate;

    id mockError = OCMClassMock([NSError class]);
    operation.error = mockError;

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    OCMVerify([self.mockDelegate operation:operation didFailWithError:mockError]);
}

- (void)testThatAFinishedOperationLetsADependentOperationRun
{
    SucceedingOperation *operation = [[SucceedingOperation alloc] init];

    SucceedingOperation *dependantOperation = [[SucceedingOperation alloc] init];
    dependantOperation.delegate = self.mockDelegate;
    [dependantOperation addDependency:operation];

    id mockResult = OCMClassMock([NSObject class]);
    dependantOperation.result = mockResult;

    [self.operationQueue addOperations:@[ operation, dependantOperation ] waitUntilFinished:YES];

    OCMVerify([self.mockDelegate operation:dependantOperation didCompleteWithResult:mockResult]);
}

- (void)testThatClockAndReportIsCalledWhenAnOperationIsFinished
{
    TWGDelayOperation *operation = [TWGDelayOperation delayOperationWithDelay:1.f];

    __block BOOL durationCaptured = NO;

    [operation clockAndReport:^(NSTimeInterval duration) {
        durationCaptured = YES;
    }];

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    expect(durationCaptured).to.beTruthy();
}

- (void)testBlockBasedCallBackCallsSuccess
{
	SucceedingOperation *operation = [[SucceedingOperation alloc] init];
	
	__block BOOL didComplete = NO;
	
	[[operation completion:^(id result) {
		didComplete = YES;
	}] failure:^(NSError *error) {
		
	}];
	
	[self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];
	
	expect(didComplete).to.beFalsy();
	expect(didComplete).will.beTruthy();
}

- (void)testBlockBasedCallBackCallsSuccessWithOnlyCompletionBlock
{
	SucceedingOperation *operation = [[SucceedingOperation alloc] init];
	
	__block BOOL didComplete = NO;
	
	[operation completion:^(id result) {
		didComplete = YES;
	}];
	
	[self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];
	
	expect(didComplete).to.beFalsy();
	expect(didComplete).will.beTruthy();
}

- (void)testBlockBasedCallBackCallsFailure
{
	FailingOperation *operation = [[FailingOperation alloc] init];
	
	__block BOOL didError = NO;
	
	[[operation completion:^(id result) {
		
	}] failure:^(NSError *error) {
		didError = YES;
	}];
	
	expect(didError).to.beFalsy();
	
	[self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];
	
	expect(didError).will.beTruthy();
}

- (void)testBlockBasedCallBackCallsSuccessOnMain
{
    SucceedingOperation *operation = [[SucceedingOperation alloc] init];

    __block BOOL didComplete = NO;

    [[operation completionOnMain:^(id result) {
        if ([NSThread isMainThread]) {
            didComplete = YES;
        }
    }] failureOnMain:^(NSError *error) {
		
	}];

	expect(didComplete).to.beFalsy();
	
    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];

    expect(didComplete).will.beTruthy();
}

- (void)testBlockBasedCallBackCallsFailureOnMain
{
    FailingOperation *operation = [[FailingOperation alloc] init];

    __block BOOL didError = NO;

    [operation failureOnMain:^(NSError *error) {
        if ([NSThread isMainThread]) {
            didError = YES;
        }
    }];

	expect(didError).to.beFalsy();
	
    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];

    expect(didError).will.beTruthy();
}

-(void)testBlockBasedDelegateCanReplaceSuccessBlock
{
	SucceedingOperation *operation = [[SucceedingOperation alloc] init];
	
	__block BOOL didComplete = NO;
	__block BOOL oldBlockCompleted = NO;
	
	[operation completion:^(id result) {
		oldBlockCompleted = YES;
	}];
	
	[operation completion:^(id result) {
		didComplete = YES;
	}];
	
	[self.operationQueue addOperations:@[ operation ] waitUntilFinished:NO];
	
	expect(oldBlockCompleted).will.beFalsy();
	expect(didComplete).will.beTruthy();
}

@end
