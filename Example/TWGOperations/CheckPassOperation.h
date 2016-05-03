//
//  CheckPassOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;

@interface CheckPassOperation : TWGOperation <NSCopying>

@property (nonatomic, assign) NSUInteger numberOfPasses;
@property (nonatomic, assign) NSUInteger maxPasses;

@end
