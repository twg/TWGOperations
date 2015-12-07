//
//  TWGGroupOperationImpliedDependencyTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-07.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface TWGGroupOperationImpliedDependencyTests : XCTestCase

@property (nonatomic, strong) TWGGroupOperation *operation;

@end

@implementation TWGGroupOperationImpliedDependencyTests

- (void)setUp {
    [super setUp];
    
    self.operation = [[TWGGroupOperation alloc] init];
    
}

- (void)tearDown {

    self.operation = nil;
    
    [super tearDown];
}


- (void)testThatInitWithOperationsIsCalled
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock initWithOperations:OCMOCK_ANY]).andReturn(operationMock);
    
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);
    
    NSArray *operations = @[mockOperation1, mockOperation2, mockOperation3];
    
    operationMock = [operationMock initWithSerialOperations:operations];
    
    OCMVerify([operationMock initWithOperations:operations]);
}


- (void)testThatOperationsGetsAllPreviousOperationsAddedAsDependencies
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock initWithOperations:OCMOCK_ANY]).andReturn(operationMock);
    
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);
    
    NSArray *operations = @[mockOperation1, mockOperation2, mockOperation3];
    NSArray *dependantOperations = @[mockOperation1, mockOperation2];
    
    [[mockOperation3 expect] addDependencies:dependantOperations];
    
    operationMock = [operationMock initWithSerialOperations:operations];
    
    OCMVerifyAll(mockOperation3);
}


- (void)testThatTheFirstOperationGetsDoesNotGetAnyDependencies
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock initWithOperations:OCMOCK_ANY]).andReturn(operationMock);
    
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);
    
    NSArray *operations = @[mockOperation1, mockOperation2, mockOperation3];
    
    [[mockOperation1 reject] addDependencies:OCMOCK_ANY];
    
    operationMock = [operationMock initWithSerialOperations:operations];
    
    OCMVerifyAll(mockOperation1);
}

@end
