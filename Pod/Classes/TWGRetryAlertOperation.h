//
//  TWGRetryAlertOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-23.
//
//

#import "TWGAlertOperation.h"

typedef NS_ENUM(NSUInteger, TWGRetryAlertOperationResult) {
    TWGRetryAlertOperationResultCancel,
    TWGRetryAlertOperationResultRetry,
};

@interface TWGRetryAlertOperation : TWGAlertOperation

@property (nonatomic, assign) TWGRetryAlertOperationResult result;


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
