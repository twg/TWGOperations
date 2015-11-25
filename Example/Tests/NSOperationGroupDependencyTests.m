//
//  NSOperationGroupDependencyTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface NSOperationGroupDependencyTests : XCTestCase

@property (nonatomic, strong) NSOperation *operation;

@end

@implementation NSOperationGroupDependencyTests

- (void)setUp {
    [super setUp];
    
    self.operation = [[NSOperation alloc] init];
    
}

- (void)tearDown {
    
    self.operation = nil;
    
    [super tearDown];
}

- (void)testThatItAddsAllDependencys
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock addDependency:OCMOCK_ANY]);
    
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);
    
    [operationMock addDependencies:@[mockOperation1, mockOperation2, mockOperation3]];
    
    OCMVerify([operationMock addDependency:mockOperation1]);
    OCMVerify([operationMock addDependency:mockOperation2]);
    OCMVerify([operationMock addDependency:mockOperation3]);
}

- (void)testThatItDoesNotCallAddDependencyWithEmptyArray
{
    id operationMock = OCMPartialMock(self.operation);
    [[operationMock reject] addDependency:OCMOCK_ANY];
    
    [operationMock addDependencies:@[]];
    
    OCMVerifyAll(operationMock);
}

- (void)testThatItDoesNotCallAddDependencyWithNilArray
{
    id operationMock = OCMPartialMock(self.operation);
    [[operationMock reject] addDependency:OCMOCK_ANY];
    
    [operationMock addDependencies:nil];
    
    OCMVerifyAll(operationMock);
}

@end
