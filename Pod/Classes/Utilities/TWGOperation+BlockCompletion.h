//
//  TWGOperation+BlockCompletion.h
//  Pods
//
//  Created by Nicholas Kuhne on 2016-05-02.
//
//

#import "TWGOperation.h"

@interface TWGOperation (BlockCompletion)

- (TWGOperation *)completion:(void (^)(id result))completion;
- (TWGOperation *)completionOnMain:(void (^)(id result))completion;

- (TWGOperation *)failure:(void (^)(NSError *error))failure;
- (TWGOperation *)failureOnMain:(void (^)(NSError *error))failure;

@end
