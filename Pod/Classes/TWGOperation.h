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

@property (nonatomic, strong) id<TWGOperationDelegate>delegate;

/*
 subclasses override this for execution
 */
- (void)execute;

/*
 subclasses must call this to complete
 */
- (void)finish;

/*
 convenience completion
 
 subclasses can use these as short hand for the process:
 - inform delegate of complete or fail
 - finish
 */
- (void) finishWithResult:(id)result;
- (void) finishWithError:(NSError *)error;

@end


/*
 
 */
@protocol TWGOperationDelegate <NSObject>

- (void) operation:(TWGOperation *)operation didCompleteWithResult:(id)result;
- (void) operation:(TWGOperation *)operation didFailWithError:(NSError*)error;

@end