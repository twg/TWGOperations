//
//  TWGGroupOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TWGOperations/TWGOperations-umbrella.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

@interface TWGGroupOperation (Testable)

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSArray<NSOperation*>* operations;
@property (nonatomic, strong) TWGGroupCompletionOperation *completionOperation;

- (void)cancelAllRemainingOperations;

@end

@interface TWGGroupOperationTests : XCTestCase

@property (nonatomic, strong) id mockOperation1;
@property (nonatomic, strong) id mockOperation2;
@property (nonatomic, strong) id mockOperation3;
@property (nonatomic, strong) id mockOperationQueue;
@property (nonatomic, strong) id mockGroupCompletionOperation;

@property (nonatomic, strong) TWGGroupOperation *operation;

@end

@implementation TWGGroupOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockOperation1 = OCMClassMock([NSOperation class]);
    self.mockOperation2 = OCMClassMock([NSOperation class]);
    self.mockOperation3 = OCMClassMock([NSOperation class]);
    
    self.mockOperationQueue = OCMClassMock([NSOperationQueue class]);
    
    NSArray *operations = @[self.mockOperation1, self.mockOperation2, self.mockOperation3];
    
    self.operation = [[TWGGroupOperation alloc] initWithOperations:operations];
    self.operation.operationQueue = self.mockOperationQueue;

    self.mockGroupCompletionOperation = OCMClassMock([TWGGroupCompletionOperation class]);
    OCMStub([self.mockGroupCompletionOperation groupCompletionOperationWithProxyOperation:OCMOCK_ANY]).andReturn(self.mockGroupCompletionOperation);

}

- (void)tearDown {
    
    self.mockOperation1 = nil;
    self.mockOperation2 = nil;
    self.mockOperation3 = nil;
    
    self.operation = nil;
    
    [super tearDown];
}


#pragma mark public interfaces

- (void)testThatInitWithOperationSetsOperations
{
    id mockOperation1 = OCMClassMock([NSOperation class]);
    id mockOperation2 = OCMClassMock([NSOperation class]);
    id mockOperation3 = OCMClassMock([NSOperation class]);
    
    NSArray *operations = @[mockOperation1, mockOperation2, mockOperation3];
    
    TWGGroupOperation *groupOperation = [[TWGGroupOperation alloc] initWithOperations:operations];
    
    expect(groupOperation.operations).to.equal(operations);
}

#pragma mark execute

- (void)testThatExecuteSetsCompletionOperation
{
    [self.operation execute];
    
    expect(self.operation.completionOperation).to.equal(self.mockGroupCompletionOperation);
}

- (void)testThatExecureSetsCompletionOperationsProxyOperation
{
    [self.operation execute];
    
    OCMVerify([self.mockGroupCompletionOperation groupCompletionOperationWithProxyOperation:self.operation]);
}

- (void)testThatExecuteAddsCompletionOperationAsDependancyToAllOperations
{
    [self.operation execute];
    
    OCMVerify([self.mockGroupCompletionOperation addDependencies:self.operation.operations]);
}

- (void)testThatExecuteDoesNotAddAnyDependencysToCompletionOperationWithNoOperations
{
    self.operation.operations = nil;
    
    [[self.mockGroupCompletionOperation reject] addDependencies:OCMOCK_ANY];
    
    [self.operation execute];
    
    OCMVerifyAll(self.mockGroupCompletionOperation);
}

- (void)testThatExecuteAddsAllOperationsToOperationQueue
{
    [self.operation execute];
    
    OCMVerify([self.mockOperationQueue addOperations:self.operation.operations waitUntilFinished:NO]);
}

- (void)testThatExecuteAddsCompletionOperationToOperationQueue
{
    [self.operation execute];
    
    OCMVerify([self.mockOperationQueue addOperation:self.mockGroupCompletionOperation]);
}

#pragma mark finishWithResult

- (void)testThatFinishWithResultSetsCompletionOperationsResult
{
    self.operation.completionOperation = self.mockGroupCompletionOperation;
    
    id mockResult = OCMClassMock([NSObject class]);
    
    [self.operation finishWithResult:mockResult];
    
    OCMVerify([self.mockGroupCompletionOperation setResult:mockResult]);
}

- (void)testThatFinishWithResultCallsCancelAllRemainingOperations
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock cancelAllRemainingOperations]);
    
    [self.operation finishWithResult:nil];
    
    OCMVerify([operationMock cancelAllRemainingOperations]);
}

#pragma mark finishWithError

- (void)testThatFinishWithErrorSetsCompletionOperationsError
{
    self.operation.completionOperation = self.mockGroupCompletionOperation;
    
    id mockError = OCMClassMock([NSError class]);
    
    [self.operation finishWithError:mockError];
    
    OCMVerify([self.mockGroupCompletionOperation setError:mockError]);
}

- (void)testThatFinishWithErrorCallsCancelAllRemainingOperations
{
    id operationMock = OCMPartialMock(self.operation);
    OCMStub([operationMock cancelAllRemainingOperations]);
    
    [self.operation finishWithError:nil];
    
    OCMVerify([operationMock cancelAllRemainingOperations]);
}

#pragma mark cancelAllRemainingOperations

- (void)testThatCancelAllRemainingOperationsCancelesANotFinishedNotExecutingOperation
{
    OCMStub([self.mockOperation1 isFinished]).andReturn(NO);
    OCMStub([self.mockOperation1 isExecuting]).andReturn(NO);
    
    [self.operation cancelAllRemainingOperations];
    
    OCMVerify([self.mockOperation1 cancel]);
}

- (void)testThatCancelAllRemainingOperationsDoesNotCancelAFinishedOperation
{
    OCMStub([self.mockOperation1 isFinished]).andReturn(YES);
    OCMStub([self.mockOperation1 isExecuting]).andReturn(NO);
    [[self.mockOperation1 reject] cancel];
    
    [self.operation cancelAllRemainingOperations];
    
    OCMVerifyAll(self.mockOperation1);
}

- (void)testThatCancelAllRemainingOperationsDoesNotCancelAnExecutingOperation
{
    OCMStub([self.mockOperation1 isFinished]).andReturn(NO);
    OCMStub([self.mockOperation1 isExecuting]).andReturn(YES);
    [[self.mockOperation1 reject] cancel];
    
    [self.operation cancelAllRemainingOperations];
    
    OCMVerifyAll(self.mockOperation1);
}

- (void)testThatCancelAllRemainingOperationsDoesNotCancelWhenAllOperationsAreComplete
{
    OCMStub([self.mockOperation1 isFinished]).andReturn(YES);
    [[self.mockOperation1 reject] cancel];
    OCMStub([self.mockOperation2 isFinished]).andReturn(YES);
    [[self.mockOperation2 reject] cancel];
    OCMStub([self.mockOperation3 isFinished]).andReturn(YES);
    [[self.mockOperation3 reject] cancel];
    
    [self.operation cancelAllRemainingOperations];
    
    OCMVerifyAll(self.mockOperation1);
    OCMVerifyAll(self.mockOperation2);
    OCMVerifyAll(self.mockOperation3);
}

- (void)testThatCancelAllRemainingOperationsDoesNotCancelCompletionOperation
{
    [[self.mockGroupCompletionOperation reject] cancel];
    
    [self.operation cancelAllRemainingOperations];
    
    OCMVerifyAll(self.mockGroupCompletionOperation);
}

@end
