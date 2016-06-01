//
//  TWGOperation+BlockCompletion.h
//  Pods
//
//  Created by Nicholas Kuhne on 2016-05-02.
//
//

#import "TWGOperation.h"

typedef void(^TWGOperationBlockCompletion)(id _Nullable result);
typedef void(^TWGOperationBlockFailure)(NSError * _Nullable error);

@interface TWGOperation (BlockCompletion)

- (nonnull TWGOperation *)completion:(TWGOperationBlockCompletion _Nonnull)completion;
- (nonnull TWGOperation *)completionOnMain:(TWGOperationBlockCompletion _Nonnull)completion;

- (nonnull TWGOperation *)failure:(TWGOperationBlockFailure _Nonnull)failure;
- (nonnull TWGOperation *)failureOnMain:(TWGOperationBlockFailure _Nonnull)failure;

@end
