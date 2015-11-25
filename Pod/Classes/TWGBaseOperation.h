//
//  TWGBaseOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import <Foundation/Foundation.h>

@class TWGBaseOperation;

@protocol TWGOperationDelegate <NSObject>

- (void) operation:(TWGBaseOperation *)operation didCompleteWithResult:(id)result;
- (void) operation:(TWGBaseOperation *)operation didFailWithError:(NSError*)error;

@end

@interface TWGBaseOperation : NSOperation

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
 */
- (void) finishWithResult:(id)result;
- (void) finishWithError:(NSError *)error;

@end
