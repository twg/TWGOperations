//
//  TWGModalViewController.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "TWGModalViewController.h"

@interface TWGModalViewController ()

@end

@implementation TWGModalViewController


- (IBAction)closeButtonPressed:(id)sender
{
    if([self.delegate respondsToSelector:@selector(modalViewControllerRequestsClose:)]) {
        [self.delegate modalViewControllerRequestsClose:self];
    }
}

@end
