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
	if(self.shouldFail) {
		[self finishWithError:nil];
	}
	else {
		[self finishWithResult:nil];
	}
}

- (id)copyWithZone:(NSZone *)zone
{
	self.wasCopied = YES;
	
	ReportingOperation *operation = [[[self class] alloc] init];
	operation.delegate = self.delegate;
	operation.shouldFail = self.shouldFail;
	return operation;
}


@end
