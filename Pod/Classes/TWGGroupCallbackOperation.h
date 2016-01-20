//
//  TWGGroupCallbackOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-25.
//
//

#import "TWGOperation.h"

/*
 This operation is used by TWGGroupOperation for delegate callbacks
 */
typedef NS_ENUM(NSUInteger, TWGGroupCallbackOperationAction) {
    TWGGroupCallbackOperationActionSuccess = 0,
    TWGGroupCallbackOperationActionError
};

@interface TWGGroupCallbackOperation : TWGOperation

@property (nonatomic, strong) TWGOperation *proxyOperation;
@property (nonatomic, strong) id value;
@property (nonatomic, assign) TWGGroupCallbackOperationAction action;

+ (instancetype)groupCallbackOperationWithProxyOperation:(TWGOperation *)proxyOperation;
- (void)configureValueForError:(NSError *)error;
- (void)configureValueForResult:(id)result;

@end
