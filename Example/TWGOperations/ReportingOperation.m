//
//  ReportingOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "ReportingOperation.h"

@implementation ReportingOperation

- (void)execute
{
    self.didRun = YES;
    [self finish];
}

@end
