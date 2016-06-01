//
//  TWGOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "NSObject+PerformBlock.h"
#import "NSOperation+GroupDependencies.h"
#import <Foundation/Foundation.h>

@class TWGOperation;
/*
 TWGOperationDelegate for callbacks for completion and passing of result data
 */
@protocol TWGOperationDelegate <NSObject>

- (void)operation:(nonnull TWGOperation *)operation didCompleteWithResult:(nullable id)result NS_SWIFT_NAME(operationDidComplete(operation:withResult:));
- (void)operation:(nonnull TWGOperation *)operation didFailWithError:(nullable NSError *)error NS_SWIFT_NAME(operationDidFail(operation:withError:));

@end

@interface TWGOperation : NSOperation

@property (nonatomic, weak, nullable) id<TWGOperationDelegate> delegate;

@end

@interface TWGOperation (SubclassingHooks)

/*
 Override this to implement execution
 */
- (void)execute;

/*
 TWGOperation subclasses must call this to complete execution of the operation
 */
- (void)finish;

@end

@interface TWGOperation (QuickDelegate)

/*
 Convenience completion

 Subclasses should use these as short hand for the process:
 1. Inform delegate of complete or fail
 2. -finish
 */
- (void)finishWithResult:(id _Nullable)result NS_SWIFT_NAME(finish(withResult:));
- (void)finishWithError:(NSError * _Nullable)error NS_SWIFT_NAME(finish(withError:));

@end
