//
//  TWGRetryOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2016-04-29.
//
//

#import "TWGGroupOperation.h"

/*
 The TWGRetryOperation will "retry" by copying the operation object based on the result of checkOperation
 - checkOperaiton finishWithResult:nil signifies that the operation should try again
 - checkOperaiton finishWIthError:nil(or error) signifies that the operaiton should not be tried again
 */

@interface TWGRetryOperation : TWGGroupOperation <TWGOperationDelegate>

@property (nonatomic, strong, readonly) TWGOperation<NSCopying> *operation;
@property (nonatomic, strong, readonly) TWGOperation<NSCopying> *checkOperation;

@property (nonatomic, strong, readonly) TWGRetryOperation *retryOperation;

- (instancetype)initWithOperation:(TWGOperation<NSCopying> *)operation
                andCheckOperation:(TWGOperation<NSCopying> *)checkOperation;

@end
