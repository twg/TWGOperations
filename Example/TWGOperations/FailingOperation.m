//
//  FailingOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "FailingOperation.h"

@implementation FailingOperation

- (void)execute
{
    [self finishWithError:self.error];
}

@end
