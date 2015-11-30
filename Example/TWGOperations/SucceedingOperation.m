//
//  SucceedingOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "SucceedingOperation.h"

@implementation SucceedingOperation

- (void)execute
{
    [self finishWithResult:self.result];
}

@end
