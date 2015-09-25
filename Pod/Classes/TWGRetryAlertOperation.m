//
//  TWGRetryAlertOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGRetryAlertOperation.h"

@interface TWGRetryAlertOperation ()

@end


@implementation TWGRetryAlertOperation

- (void)execute
{
    self.alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                message:self.message
                                               delegate:self
                                      cancelButtonTitle:self.retryButtonTitle
                                      otherButtonTitles:self.cancelButtonTitle, nil];
    
    [self.alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

- (NSString *)retryButtonTitle
{
    if(_retryButtonTitle == nil) {
        _retryButtonTitle = @"Retry";
    }
    return _retryButtonTitle;
}

- (NSString *)cancelButtonTitle
{
    if(_cancelButtonTitle == nil) {
        _cancelButtonTitle = @"Cancel";
    }
    return _cancelButtonTitle;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.result = TWGRetryAlertOperationResultRetry;
            break;
        case 1:
        default:
            self.result = TWGRetryAlertOperationResultCancel;
            break;
    }
    
    [self finish];
}


@end
