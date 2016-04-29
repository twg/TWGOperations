//
//  TWGGroupOperation+ImpliedDependency.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-12-07.
//
//

#import "TWGGroupOperation.h"

@interface TWGGroupOperation (ImpliedDependency)

/*
 initWithSerialOperations: adds dependencies to operations recursively

 eg. initWithOperations:@[A, B, C, D]

 implies:
 A & B & C as dependencies of D
 A & B as dependencies of C
 A as a dependency of B

 */
- (instancetype)initWithSerialOperations:(NSArray<NSOperation *> *)operations;

@end
