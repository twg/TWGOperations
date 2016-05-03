//
//  TWGOperationSpeedTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "SortOperation.h"
#import <XCTest/XCTest.h>

@interface TWGOperationSpeedTests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation TWGOperationSpeedTests

- (void)setUp
{
    [super setUp];

    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)tearDown
{
    self.operationQueue = nil;

    sleep(0.5);

    [super tearDown];
}

- (void)testAMillionObjectsBareMetalSortBaseline
{
    __block NSArray *sortedArray = nil;

    NSArray *millionObjects = [self millionObjects];

    [self measureBlock:^{
        sortedArray = [SortableObject sortedArrayOfSortableObjects:millionObjects];
    }];
}

- (void)testAMillionObjectsSortOperationOnBackgroundQOS
{
    self.operationQueue.qualityOfService = NSQualityOfServiceBackground;

    NSArray *millionObjects = [self millionObjects];

    [self measureBlock:^{
        SortOperation *operation = [[SortOperation alloc] init];
        operation.objects = millionObjects;

        [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];
    }];
}

- (void)testAMillionObjectsSortOperationOnUtilityQOS
{
    self.operationQueue.qualityOfService = NSQualityOfServiceUtility;

    NSArray *millionObjects = [self millionObjects];

    [self measureBlock:^{
        SortOperation *operation = [[SortOperation alloc] init];
        operation.objects = millionObjects;

        [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];
    }];
}

- (void)testAMillionObjectsSortOperationOnUserInitiatedQOS
{
    self.operationQueue.qualityOfService = NSQualityOfServiceUserInitiated;

    NSArray *millionObjects = [self millionObjects];

    [self measureBlock:^{
        SortOperation *operation = [[SortOperation alloc] init];
        operation.objects = millionObjects;

        [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];
    }];
}

- (void)testAMillionObjectsSortOperationOnUserInteractiveQOS
{
    self.operationQueue.qualityOfService = NSQualityOfServiceUserInteractive;

    NSArray *millionObjects = [self millionObjects];

    [self measureBlock:^{
        SortOperation *operation = [[SortOperation alloc] init];
        operation.objects = millionObjects;

        [self.operationQueue addOperations:@[ operation ] waitUntilFinished:YES];
    }];
}

- (NSArray *)millionObjects
{
    NSUInteger million = 1000000;
    return [SortableObject createSortableObjectsArrayOfSize:million];
}

@end
