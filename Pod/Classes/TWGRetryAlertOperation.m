//
//  TWGRetryAlertOperation.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGRetryAlertOperation.h"

NSString *const TWGRetryAlertOperationResultCancel  = @"TWGRetryAlertOperationResultCancel";
NSString *const TWGRetryAlertOperationResultRetry   = @"TWGRetryAlertOperationResultRetry";

@interface TWGRetryAlertOperation ()
@end


@implementation TWGRetryAlertOperation

- (void)configureAlert
{
    self.alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                message:self.message
                                               delegate:self
                                      cancelButtonTitle:self.cancelButtonTitle
                                      otherButtonTitles:self.retryButtonTitle, nil];
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
    if([self.delegate respondsToSelector:@selector(retryDecisionDelegateDidDecide:)]) {
        [self.delegate retryDecisionDelegateDidDecide:(buttonIndex == 1)];
    }
    
    [self finish];
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TWGRetryAlertOperation *copyOperation = [super copyWithZone:zone];
    
    copyOperation.retryButtonTitle = self.retryButtonTitle;
    copyOperation.cancelButtonTitle = self.cancelButtonTitle;
    
    return copyOperation;
}

@end
