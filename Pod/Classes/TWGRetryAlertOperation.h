//
//  TWGRetryAlertOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGAlertOperation.h"
#import "TWGRetryDecisionDelegate.h"

@interface TWGRetryAlertOperation : TWGAlertOperation <TWGRetryDecisionOperation>

@property (nonatomic, weak) id<TWGRetryDecisionDelegate>delegate;


/*
 Alert retry button text
 Default "Retry"
 */
@property (nonatomic, copy) NSString *retryButtonTitle;

/*
 Alert cancel button text
 Default "Cancel"
 */
@property (nonatomic, copy) NSString *cancelButtonTitle;

@end
