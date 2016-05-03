//
//  ReportingOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;

@interface ReportingOperation : TWGOperation <NSCopying>

@property (nonatomic, assign) BOOL shouldFail;

// Not copied, specific to each instance
@property (nonatomic, assign) BOOL didRun;
@property (nonatomic, assign) BOOL wasCopied;

@end
