//
//  NSOperation+GroupDependacy.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import <Foundation/Foundation.h>

@interface NSOperation (GroupDependencies)

- (void) addDependencies:(NSArray *)operations;

@end
