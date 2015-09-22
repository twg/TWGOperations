//
//  TWGBaseOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TWGOperationState) {
    TWGOperationStateReady,
    TWGOperationStateStarting,
    TWGOperationStateExecuting,
    TWGOperationStateFinishing,
    TWGOperationStateFinished,
    TWGOperationStateCanceled
};

@interface TWGBaseOperation : NSOperation

@property (nonatomic, assign) TWGOperationState state;

/*
 subclasses override this for execution
 */
- (void)execute;


/*
 subclasses must call this to complete
 */
- (void)finish;

@end
