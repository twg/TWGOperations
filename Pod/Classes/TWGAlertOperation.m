//
//  TWGAlertOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGAlertOperation.h"

@interface TWGAlertOperation ()

@end

@implementation TWGAlertOperation

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
    TWGAlertOperation *alertOperation = [[[self class] alloc] init];
    alertOperation.title = title;
    alertOperation.message = message;
    
    return alertOperation;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self finish];
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TWGAlertOperation *operation = [super copyWithZone:zone];
    
    operation.title = self.title;
    operation.message = self.message;
    operation.confirmButtonTitle = self.confirmButtonTitle;
    
    return operation;
}


@end
