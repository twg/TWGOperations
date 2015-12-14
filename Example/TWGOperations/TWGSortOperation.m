//
//  TWGSortOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "TWGSortOperation.h"

@implementation TWGSortOperation

- (void)execute
{
    NSArray *sortedArray = [SortableObject sortedArrayOfSortableObjects:self.objects];
    [self finishWithResult:sortedArray];
}

@end


@implementation SortableObject

+ (SortableObject *)randomValueObjectWithLimit:(NSUInteger)limit
{
    SortableObject *object = [[SortableObject alloc] init];
    object.value = arc4random_uniform((u_int32_t)limit);
    return object;
}

+ (NSArray<SortableObject *> *)createSortableObjectsArrayOfSize:(NSUInteger)size
{
    static NSUInteger bulkSize = 10;
    
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:size];
    
    for (NSUInteger i = 0; i < size; i++) {
        SortableObject *object = [[SortableObject alloc] init];
        object.value = bulkSize - (i % bulkSize);
        [objects addObject:object];
    }
    
    return objects;
}

+ (NSArray *)sortedArrayOfSortableObjects:(NSArray<SortableObject*>*)objects
{
    NSMutableArray *sortableArray = [objects mutableCopy];
    
    NSArray *sortedArray = [sortableArray sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(SortableObject *obj1, SortableObject *obj2) {
        if(obj1.value > obj2.value)
            return NSOrderedAscending;
        if(obj1.value > obj2.value)
            return NSOrderedDescending;
        
        return NSOrderedSame;
    }];
    
    return sortedArray;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%ld", (long)self.value];
}

@end
