//
//  DelegateCallbackOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "DelegateCallbackOperation.h"

@implementation DelegateCallbackOperation

- (void)execute {
    // do nothign here
}

#pragma mark TWGModalViewControllerDelegate

- (void)modalViewControllerRequestsClose:(TWGModalViewController *)modalViewController
{
    [self finishWithResult:nil];
}

@end
