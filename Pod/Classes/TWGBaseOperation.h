//
//  TWGBaseOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import <Foundation/Foundation.h>

@interface TWGBaseOperation : NSOperation <NSCopying>

@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;

/*
 called before NSOperation completionBlock
 */
@property (copy) void (^operationCompletionBlock)(id result, NSError *error);

/*
 subclasses override this for execution
 */
- (void)execute;

/*
 subclasses must call this to complete
 */
- (void)finish;

@end
