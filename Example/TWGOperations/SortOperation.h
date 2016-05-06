//
//  TWGSortOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-11.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;

@interface SortableObject : NSObject
@property (nonatomic, assign) NSInteger value;

+ (SortableObject *)randomValueObjectWithLimit:(NSUInteger)limit;

+ (NSArray<SortableObject *> *)createSortableObjectsArrayOfSize:(NSUInteger)size;
+ (NSArray *)sortedArrayOfSortableObjects:(NSArray<SortableObject *> *)objects;

@end

@interface SortOperation : TWGOperation

@property (nonatomic, strong) NSArray<SortableObject *> *objects;

@end
