//
//  TWGAlertOperation.m
//  TWGOperations
//
//  Created by Alex Stroulger on 2016-04-29.
//  Copyright (c) 2016 TWG. All rights reserved.
//

#import "TWGAlertOperation.h"

@interface TWGAlertOperation () <UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertController *alertController;

#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (strong, nonatomic) UIAlertView *alertView;
#pragma clang diagnostic pop

@end

@implementation TWGAlertOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cancelable = YES;
    }
    return self;
}

- (void)execute
{
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
        [self performSelectorOnMainThread:@selector(presentAlertController) withObject:nil waitUntilDone:YES];
    }
    else {
        [self performSelectorOnMainThread:@selector(presentAlert) withObject:nil waitUntilDone:NO];
    }
}

- (NSString *)confirmText
{
    if (!_confirmText) {
        _confirmText = @"Okay";
    }
    return _confirmText;
}

- (NSString *)cancelText
{
    if (!_cancelText) {
        _cancelText = @"Cancel";
    }
    return _cancelText;
}

#pragma mark UIAlertController for iOS8 and above
- (void)presentAlertController
{
    if (self.presentingViewController.presentedViewController == nil) {
        [self.presentingViewController presentViewController:self.alertController animated:YES completion:nil];
    }
    else {
        [self finishWithError:nil];
    }
}

- (UIAlertController *)alertController
{
    if (_alertController == nil) {

        _alertController = [UIAlertController alertControllerWithTitle:self.alertTitle
                                                               message:self.alertMessage
                                                        preferredStyle:UIAlertControllerStyleAlert];

        if (self.cancelable) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:self.cancelText
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *_Nonnull action) {
                                                                     [self finishWithError:nil];
                                                                 }];
            [_alertController addAction:cancelAction];
        }

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:self.confirmText
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *_Nonnull action) {
                                                             [self finishWithResult:nil];
                                                         }];

        [_alertController addAction:okAction];
    }

    return _alertController;
}

- (UIViewController *)presentingViewController
{
    if (_presentingViewController == nil) {
        return [[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
    return _presentingViewController;
}

#pragma mark UIAlertView for iOS7 and below
- (void)presentAlert
{
    [self.alertView show];
}

#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIAlertView *)alertView
{
    if (_alertView == nil) {
        _alertView = [[UIAlertView alloc] initWithTitle:self.alertTitle
                                                message:self.alertMessage
                                               delegate:self
                                      cancelButtonTitle:(self.cancelable) ? self.cancelText : nil
                                      otherButtonTitles:self.confirmText, nil];
    }
    return _alertView;
}
#pragma clang diagnostic pop

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self finishWithError:nil];
    }
    else {
        [self finishWithResult:nil];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    TWGAlertOperation *operation = [[[self class] alloc] init];

    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
        operation.presentingViewController = self.presentingViewController;
    }

    operation.delegate = self.delegate;
    operation.cancelable = self.cancelable;
    operation.confirmText = self.confirmText;
    operation.cancelText = self.cancelText;
    operation.alertTitle = self.alertTitle;
    operation.alertMessage = self.alertMessage;

    return operation;
}

@end
