//
//  NSOperation+Timing.m
//  Pods
//
//  Created by Nicholas Kuhne on 2016-05-02.
//
//

#import "NSOperation+Timing.h"
#import <objc/runtime.h>

@interface NSOperationObserver : NSObject

@property (nonatomic, weak) NSOperation *operation;
@property (nonatomic, strong) void (^block)(NSTimeInterval);

@property (nonatomic, strong) NSDate *startDate;

+ (instancetype)operationObserverWithOperation:(NSOperation *)operation
                                andReportBlock:(void (^)(NSTimeInterval duration))block;

@end

static NSString *kIsExecutingKey = @"isExecuting";

@implementation NSOperationObserver

+ (instancetype)operationObserverWithOperation:(NSOperation *)operation
                                andReportBlock:(void (^)(NSTimeInterval duration))block
{
    if ([operation isExecuting] == NO) {
        NSOperationObserver *observer = [[NSOperationObserver alloc] init];
        observer.operation = operation;
        observer.block = block;

        [observer beginObserving];

        return observer;
    }
    return nil;
}

- (void)beginObserving
{
    if ([self.operation isExecuting] == NO) {
        [self.operation addObserver:self forKeyPath:kIsExecutingKey options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context
{
    NSNumber *executing = change[@"new"];
    if ([executing isEqualToNumber:@YES]) {
        self.startDate = [NSDate date];
    }
    else if ([executing isEqualToNumber:@NO]) {
        NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:self.startDate];
        if (self.block) {
            self.block(duration);
        }
    }
}

- (void)dealloc
{
    [self.operation removeObserver:self forKeyPath:kIsExecutingKey context:nil];
}

@end

@implementation NSOperation (Timing)

static const char *OPERATION_TIMING_OBJECT_KEY = "OPERATION_TIMING_OBJECT_KEY";

- (void)clockAndReport:(void (^)(NSTimeInterval duration))block;
{
    if ([self isExecuting] == NO) {
        NSOperationObserver *observer =
            [NSOperationObserver operationObserverWithOperation:self andReportBlock:block];
        if (observer) {
            objc_setAssociatedObject(self, OPERATION_TIMING_OBJECT_KEY, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

@end
