//
//  AlertOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "AlertOperation.h"

@implementation AlertOperation

- (void)execute
{
    [self configureAlert];
    [self.alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

- (void)configureAlert
{
    self.alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                message:self.message
                                               delegate:self
                                      cancelButtonTitle:self.confirmButtonTitle
                                      otherButtonTitles:nil];
}

- (NSString *)confirmButtonTitle
{
    if(_confirmButtonTitle == nil) {
        _confirmButtonTitle = @"Okay";
    }
    return _confirmButtonTitle;
}


+ (instancetype)alertOperationWithTitle:(NSString *)title andMessage:(NSString *)message
{
    AlertOperation *alertOperation = [[[self class] alloc] init];
    alertOperation.title = title;
    alertOperation.message = message;
    
    return alertOperation;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self finishWithResult:@(buttonIndex)];
}


@end
