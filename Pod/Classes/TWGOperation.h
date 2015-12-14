//
//  TWGBaseOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import <Foundation/Foundation.h>

@protocol TWGOperationDelegate;

@interface TWGOperation : NSOperation

@property(nonatomic, weak) id<TWGOperationDelegate> delegate;

/*
 subclasses override this for execution
 */
- (void)execute;

/*
 subclasses can call this to complete or use the convenience methods below
 */
- (void)finish;

/*
 convenience completion

 subclasses can use these as short hand for the process:
 - inform delegate of complete or fail
 - finish
 */
- (void)finishWithResult:(id)result;
- (void)finishWithError:(NSError *)error;


/*
 returns the duration time for the operaiton either current or after completion
 the total
 */
@property(nonatomic, readonly) NSTimeInterval executionDuration;

@property(nonatomic, assign, readonly) clock_t startTime;
@property(nonatomic, assign, readonly) clock_t endTime;

@end

/*
 TWGOperationDelegate for callbacks for completion and passing of result data
 */
@protocol TWGOperationDelegate <NSObject>

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result;
- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error;

@end