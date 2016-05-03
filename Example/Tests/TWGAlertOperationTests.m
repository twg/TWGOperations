//
//  TWGAlertOperationTests.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
@import TWGOperations;
#import <XCTest/XCTest.h>

@interface TWGAlertOperationTests : XCTestCase

@property (nonatomic, strong) TWGAlertOperation *operation;
@property (nonatomic, strong) id operationMock;

@end

@implementation TWGAlertOperationTests

- (void)setUp
{
    [super setUp];

    self.operation = [[TWGAlertOperation alloc] init];
	self.operationMock = OCMPartialMock(self.operation);
}

- (void)tearDown
{
    self.operation = nil;

    [super tearDown];
}

- (void)testThatCancelableIsTrueByDefault
{
    TWGAlertOperation *operation = [[TWGAlertOperation alloc] init];
    expect(operation.cancelable).to.beTruthy();
}

- (void)testThatPresentingViewControllerIsKeyWindowsRootViewControllerByDefault
{
    TWGAlertOperation *operation = [[TWGAlertOperation alloc] init];
    expect(operation.presentingViewController)
        .to.equal([[[UIApplication sharedApplication] keyWindow] rootViewController]);
}

- (void)testThatConfirmTextIsOkayByDefault
{
    TWGAlertOperation *operation = [[TWGAlertOperation alloc] init];
    expect(operation.confirmText).to.equal(@"Okay");
}

- (void)testThatCancelTextIsCancelByDefault
{
    TWGAlertOperation *operation = [[TWGAlertOperation alloc] init];
    expect(operation.cancelText).to.equal(@"Cancel");
}

- (void)testThatExecuteCallsPresentViewControllerOnPresentingViewControllerWhenOnIOS8AndAbove
{
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {

        id mockViewController = OCMClassMock([UIViewController class]);
        self.operation.presentingViewController = mockViewController;

        [self.operation execute];

        OCMVerify([mockViewController presentViewController:OCMOCK_ANY animated:YES completion:nil]);
    }
}

- (void)testThatExecuteCallsFinishWithErrorIfTryingToPresentOnAnAlreadyPresentingViewControllerWhenOnIOS8AndAbove
{
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {

        id mockViewController = OCMClassMock([UIViewController class]);
        self.operation.presentingViewController = mockViewController;

        [self.operation execute];

        OCMVerify([mockViewController presentViewController:OCMOCK_ANY animated:YES completion:nil]);
    }
}

@end
