//
//  TWGRetryOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2016-04-29.
//
//

#import "TWGGroupOperation.h"

/*
 A TWGRetryOperation will "retry" by copying the operation object based on the result of checkOperation when the
 initial operaiton has failed
 - if the initial operationw as successful, the check operation is not run and a TWGRetryOperation will also
 finishWithResult:
 - checkOperaiton finishWithResult: signifies that the operation should try again
 - checkOperaiton finishWIthError: signifies that the operaiton should not be tried again
 */

@interface TWGRetryOperation : TWGGroupOperation <TWGOperationDelegate>

@property (nonatomic, strong, readonly) TWGOperation<NSCopying> *operation;
@property (nonatomic, strong, readonly) TWGOperation<NSCopying> *checkOperation;

@property (nonatomic, strong, readonly) TWGRetryOperation *retryOperation;

- (instancetype)initWithOperation:(TWGOperation<NSCopying> *)operation
                andCheckOperation:(TWGOperation<NSCopying> *)checkOperation;

@end
