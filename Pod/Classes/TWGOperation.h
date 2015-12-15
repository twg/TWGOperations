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
 Subclasses override this for execution
 */
- (void)execute;

/*
 Subclasses can call this to complete or use the convenience methods below
 */
- (void)finish;

/*
 Convenience completion

 Subclasses should use these as short hand for the process:
 1. Inform delegate of complete or fail
 2. -finish
 */
- (void)finishWithResult:(id)result;
- (void)finishWithError:(NSError *)error;


/*
 Returns the execution time for the operation under the following conditions
 1. The Operation is finished
	This returns the duration of executaion from -start to -finish
 2. The operation is executing
	This returns the duration of executaion since -start to NOW
	
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