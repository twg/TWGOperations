//
//  TWGOperationIntegrationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>
#import "SucceedingOperation.h"
#import "FailingOperation.h"

@interface TWGOperationIntegrationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation TWGOperationIntegrationTests

- (void)setUp {
    [super setUp];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.mockDelegate = OCMProtocolMock(@protocol(TWGOperationDelegate));
}

- (void)tearDown {
    
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
    
    [self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
    
    OCMVerify([self.mockDelegate operation:operation didCompleteWithResult:mockResult]);
}

- (void)testThatAFailingOperationCallsDelegateFailure
{
    FailingOperation *operation = [[FailingOperation alloc] init];
    operation.delegate = self.mockDelegate;
    
    id mockError = OCMClassMock([NSError class]);
    operation.error = mockError;
    
    [self.operationQueue addOperations:@[operation] waitUntilFinished:YES];
    
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
    
    [self.operationQueue addOperations:@[operation, dependantOperation] waitUntilFinished:YES];
    
    OCMVerify([self.mockDelegate operation:dependantOperation didCompleteWithResult:mockResult]);
}

@end

