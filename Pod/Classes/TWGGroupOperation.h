//
//  TWGGroupOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGBaseOperation.h"

@interface TWGGroupOperation : TWGBaseOperation

@property (nonatomic, assign, getter=isSerial) BOOL serial;

@property (nonatomic, strong) NSArray *operations;


/*
 Subclasses override this
 */
- (void) setupOperations;

@end
