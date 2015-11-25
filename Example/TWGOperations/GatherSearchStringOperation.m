//
//  GatherSearchStringOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GatherSearchStringOperation.h"

@implementation GatherSearchStringOperation

+ (instancetype) gatherSearchStringOperation
{
    GatherSearchStringOperation *operation = [[self class] alertOperationWithTitle:@"Search" andMessage:@"Enter a search term."];
    return operation;
}

- (void)configureAlert
{
    self.confirmButtonTitle = @"Search";
    [super configureAlert];
    self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [self.alertView textFieldAtIndex:0];
    [textField resignFirstResponder];
    [self finishWithResult:textField.text];
}

@end
