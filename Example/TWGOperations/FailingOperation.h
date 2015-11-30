//
//  FailingOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-30.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface FailingOperation : TWGOperation
@property (nonatomic, strong) NSError *error;
@end
