//
//  TWGGroupCompletionOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-11-25.
//
//

#import "TWGBaseOperation.h"

@interface TWGGroupCompletionOperation : TWGBaseOperation

@property (nonatomic, strong) TWGBaseOperation *proxyOperation;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;

+ (instancetype) groupCompletionOperationWithProxyOperation:(TWGBaseOperation *)proxyOperation;

@end
