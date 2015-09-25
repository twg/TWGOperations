//
//  TWGRetryingOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#import "TWGGroupOperation.h"
#import "TWGRetryDecisionDelegate.h"

/*
 A TWGRetryingOperation will query the user to retry a given operation when the following conditions are met
    a) that operation sets an error and does not set a result after completion
 */
@interface TWGRetryingOperation : TWGGroupOperation

@property (nonatomic, assign, readonly) NSUInteger retryCount;

/*
 Retrying operations will be copied with copy:
 Default TWGDelayOperation with 1 second delay
 */
@property (nonatomic, strong) TWGBaseOperation *operation;

- (void) setupOperation;

/*
 retrying alert operations will be copied with copy:
 Default TWGRetryAlertOperation with title=@"Error" message=@"There was an error"
 */
@property (nonatomic, strong) TWGBaseOperation <TWGRetryDecisionOperation>*retryOperation;

- (void) setupRetryAlertOperation;

@end
