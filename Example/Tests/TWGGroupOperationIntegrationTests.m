//
//  TWGGroupOperationIntegrationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
@import TWGOperations;
#import "CompletionOrderReportOperation.h"
#import "DelegateForwardingGroupOperation.h"
#import "FailingOperation.h"
#import "ReportingOperation.h"
#import "SucceedingOperation.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

@interface TWGGroupOperationIntegrationTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation TWGGroupOperationIntegrationTests

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

#pragma mark Operation Canceling

- (void)testThatAGroupOperationDoesNotRunOperationsAfterFinishingWithAResult
{
    SucceedingOperation *subOperation1 = [[SucceedingOperation alloc] init];
    ReportingOperation *subOperation2 = [[ReportingOperation alloc] init];
    [subOperation2 addDependency:subOperation1];

    DelegateForwardingGroupOperation *operation =
        [[DelegateForwardingGroupOperation alloc] initWithOperations:@[ subOperation1, subOperation2 ]];

    subOperation1.delegate = operation;
    subOperation2.delegate = operation;

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    expect(subOperation2.didRun).to.beFalsy();
}

- (void)testThatAGroupOperationDoesNotRunOperationsAfterFinishingWithAnError
{
    FailingOperation *subOperation1 = [[FailingOperation alloc] init];
    ReportingOperation *subOperation2 = [[ReportingOperation alloc] init];
    [subOperation2 addDependency:subOperation1];

    DelegateForwardingGroupOperation *operation =
        [[DelegateForwardingGroupOperation alloc] initWithOperations:@[ subOperation1, subOperation2 ]];

    subOperation1.delegate = operation;
    subOperation2.delegate = operation;

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    expect(subOperation2.didRun).to.beFalsy();
}

#pragma mark Implied Dependency

- (void)testThatImpliedDependencyRunsOperationsInSeries
{
    TWGDelayOperation *subOperation1 = [TWGDelayOperation delayOperationWithDelay:0.1f];
    SucceedingOperation *subOperation2 = [[SucceedingOperation alloc] init];
    SucceedingOperation *subOperation3 = [[SucceedingOperation alloc] init];

    NSArray *operations = @[ subOperation1, subOperation2, subOperation3 ];

    CompletionOrderReportOperation *operation =
        [[CompletionOrderReportOperation alloc] initWithSerialOperations:operations];
    subOperation1.delegate = subOperation2.delegate = subOperation3.delegate = operation;

    [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];

    expect(operation.completedOperations).to.equal(operations);
}

@end
