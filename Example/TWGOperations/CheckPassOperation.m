//
//  CheckPassOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "CheckPassOperation.h"

@implementation CheckPassOperation

- (void)execute
{
	if(self.numberOfPasses < self.maxPasses) {
		self.numberOfPasses++;
		[self finishWithResult:nil];
	}
	else {
		[self finishWithError:nil];
	}
}

- (id)copyWithZone:(NSZone *)zone
{
	CheckPassOperation *operation = [[[self class] alloc] init];
	operation.delegate = self.delegate;
	operation.maxPasses = self.maxPasses;
	operation.numberOfPasses = self.numberOfPasses;
	return operation;
}

@end
