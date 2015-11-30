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

@interface TWGGroupCallbackOperation : TWGOperation

@property (nonatomic, strong) TWGOperation *proxyOperation;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;

+ (instancetype) groupCallbackOperationWithProxyOperation:(TWGOperation *)proxyOperation;

@end
