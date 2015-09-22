//
//  TWGAlertOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGAlertOperation.h"

@interface TWGAlertOperation () <UIAlertViewDelegate>

@property (nonatomic, strong, readwrite) UIAlertView *alertView;

@end

@implementation TWGAlertOperation

- (void)execute
{
    self.alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                message:self.message
                                               delegate:self
                                      cancelButtonTitle:self.cancelButtonTitle
                                      otherButtonTitles:nil];
    
    [self.alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

- (NSString *)cancelButtonTitle
{
    if(_cancelButtonTitle == nil) {
        _cancelButtonTitle = @"Okay";
    }
    return _cancelButtonTitle;
}


+ (TWGAlertOperation *)alertOperationWithTitle:(NSString *)title andMessage:(NSString *)message
{
    TWGAlertOperation *alertOperation = [[TWGAlertOperation alloc] init];
    alertOperation.title = title;
    alertOperation.message = message;
    
    return alertOperation;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self finish];
}


@end
