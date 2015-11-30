//
//  ModalDismissOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "ModalDismissOperation.h"

@implementation ModalDismissOperation

- (void)execute
{
    if(self.parentViewController.presentedViewController != nil) {
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.parentViewController dismissViewControllerAnimated:weakSelf.animated completion:^{
                [weakSelf finishWithResult:nil];
            }];
            
        });
        
    }
    else {
        [self finishWithError:[NSError errorWithDomain:NSStringFromClass([self class])
                                                  code:000
                                              userInfo:@{@"error":@"parentViewController is not presenting presenting"}]];
    }
}

@end
