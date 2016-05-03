//
//  TWGGroupOperation+ImpliedDependency.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-12-07.
//
//

#import "NSOperation+GroupDependencies.h"
#import "TWGGroupOperation+ImpliedDependency.h"

@implementation TWGGroupOperation (ImpliedDependency)

- (instancetype)initWithSerialOperations:(NSArray<NSOperation *> *)operations
{
    [operations enumerateObjectsWithOptions:NSEnumerationReverse
                                 usingBlock:^(NSOperation *_Nonnull operation, NSUInteger idx, BOOL *_Nonnull stop) {

                                     NSIndexSet *previousOperationsIndexes =
                                         [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, idx)];
                                     NSArray *previousOperations =
                                         [operations objectsAtIndexes:previousOperationsIndexes];

                                     if ([previousOperations count]) {
                                         [operation addDependencies:previousOperations];
                                     }
                                 }];

    return [self initWithOperations:operations];
}

@end
