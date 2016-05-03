//
//  TWGOperation+BlockCompletion.m
//  Pods
//
//  Created by Nicholas Kuhne on 2016-05-02.
//
//

#import "NSObject+PerformBlock.h"
#import "TWGOperation+BlockCompletion.h"
#import <objc/runtime.h>

@class TWGBlockDelegate;
@interface TWGOperation (BlockCompletionInternal)

@property (nonatomic) TWGBlockDelegate *blockDelegate;

@end

@interface TWGBlockDelegate : NSObject <TWGOperationDelegate>

@property (nonatomic, strong) void (^completion)(id result);
@property (nonatomic, assign) BOOL mainCompletion;

@property (nonatomic, strong) void (^failure)(NSError *error);
@property (nonatomic, assign) BOOL mainFailure;

@end

@implementation TWGBlockDelegate

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    void (^successBlock)(void) = ^(void) {
        if (self.completion) {
            self.completion(result);
        }
    };

    if (self.mainCompletion) {
        [self performBlockOnMainThread:successBlock waitUntilDone:YES];
    }
    else {
        successBlock();
    }
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    void (^errorBlock)(void) = ^(void) {
        if (self.failure) {
            self.failure(error);
        }
    };

    if (self.mainFailure) {
        [self performBlockOnMainThread:errorBlock waitUntilDone:YES];
    }
    else {
        errorBlock();
    }
}

@end

@implementation TWGOperation (BlockCompletion)

- (TWGOperation *)completion:(void (^)(id result))completion
{
    return [self addCompletion:completion onMain:NO];
}
- (TWGOperation *)completionOnMain:(void (^)(id result))completion
{
    return [self addCompletion:completion onMain:YES];
}

- (TWGOperation *)addCompletion:(void (^)(id result))completion onMain:(BOOL)onMain
{
    TWGBlockDelegate *blockDelegate = self.blockDelegate;
    if (blockDelegate == nil) {
        blockDelegate = [[TWGBlockDelegate alloc] init];
    }

    blockDelegate.completion = completion;
    blockDelegate.mainCompletion = onMain;

    self.blockDelegate = blockDelegate;
    self.delegate = blockDelegate;

    return self;
}

- (TWGOperation *)failure:(void (^)(NSError *error))failure
{
    return [self addFailure:failure onMain:NO];
}

- (TWGOperation *)failureOnMain:(void (^)(NSError *error))failure
{
    return [self addFailure:failure onMain:YES];
}

- (TWGOperation *)addFailure:(void (^)(NSError *error))completion onMain:(BOOL)onMain
{
    TWGBlockDelegate *blockDelegate = self.blockDelegate;
    if (blockDelegate == nil) {
        blockDelegate = [[TWGBlockDelegate alloc] init];
    }

    blockDelegate.failure = completion;
    blockDelegate.mainFailure = onMain;

    self.blockDelegate = blockDelegate;
    self.delegate = blockDelegate;

    return self;
}

@end

@implementation TWGOperation (BlockCompletionInternal)

static const char *TWG_OPERATION_BLOCK_DELEGATE_KEY = "TWG_OPERATION_BLOCK_DELEGATE_KEY";

- (TWGBlockDelegate *)blockDelegate
{
    return objc_getAssociatedObject(self, TWG_OPERATION_BLOCK_DELEGATE_KEY);
}

- (void)setBlockDelegate:(TWGBlockDelegate *)blockDelegate
{
    objc_setAssociatedObject(self, TWG_OPERATION_BLOCK_DELEGATE_KEY, blockDelegate,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end