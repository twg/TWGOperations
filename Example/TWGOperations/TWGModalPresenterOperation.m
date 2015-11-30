//
//  TWGModalPresenterOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "TWGModalPresenterOperation.h"
#import "TWGModalViewController.h"
#import "DelegateCallbackOperation.h"
#import "ModalPresentOperation.h"
#import "ModalDismissOperation.h"

@interface TWGModalPresenterOperation () <TWGOperationDelegate>

@property (nonatomic, strong) TWGModalViewController *viewController;

@property (nonatomic, strong) ModalPresentOperation *presentOperation;
@property (nonatomic, strong) DelegateCallbackOperation *callbackOperation;
@property (nonatomic, strong) ModalDismissOperation *dismissOperation;

@end

@implementation TWGModalPresenterOperation

- (instancetype)init
{
    ModalPresentOperation *presentOperation = [[ModalPresentOperation alloc] init];
    presentOperation.animated = YES;
    DelegateCallbackOperation *callbackOperation = [[DelegateCallbackOperation alloc] init];
    ModalDismissOperation *dismissOperation = [[ModalDismissOperation alloc] init];
    dismissOperation.animated = YES;

    [dismissOperation addDependencies:@[presentOperation, callbackOperation]];
    [callbackOperation addDependency:presentOperation];
    
    self = [super initWithOperations:@[presentOperation, callbackOperation, dismissOperation]];
    if (self) {
        
        self.callbackOperation = callbackOperation;
        self.callbackOperation.delegate = self;
        self.dismissOperation = dismissOperation;
        self.dismissOperation.delegate = self;
        self.presentOperation = presentOperation;
        self.presentOperation.viewController = self.viewController;
        self.presentOperation.delegate = self;
        
        self.viewController = [[TWGModalViewController alloc] initWithNibName:@"TWGModalViewController" bundle:nil];
        self.viewController.delegate = self.callbackOperation;
        self.presentOperation.viewController = self.viewController;
    
    }
    return self;
}

- (void)setParentViewController:(UIViewController *)parentViewController
{
    _parentViewController = parentViewController;
    self.presentOperation.parentViewController = parentViewController;
    self.dismissOperation.parentViewController = parentViewController;
}

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    
}

+(instancetype)modalPresenterOperationWithParentViewController:(UIViewController *)parentViewController
{
    TWGModalPresenterOperation *operation = [[[self class] alloc] init];
    operation.parentViewController = parentViewController;
    return operation;
}

@end
