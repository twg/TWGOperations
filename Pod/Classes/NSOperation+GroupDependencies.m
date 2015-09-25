//
//  NSOperation+GroupDependacy.m
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "NSOperation+GroupDependencies.h"

@implementation NSOperation (Dependencies)

- (void) addDependencies:(NSArray *)operations
{
    for (NSOperation *operation in operations) {
        [self addDependency:operation];
    }
}

@end
