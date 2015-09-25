//
//  TWGRetryDecisionDelegate.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-25.
//
//

#ifndef Pods_TWGRetryDecisionDelegate_h
#define Pods_TWGRetryDecisionDelegate_h

@protocol TWGRetryDecisionDelegate <NSObject>

- (void) retryDecisionDelegateDidDecide:(BOOL)retry;

@end


@protocol TWGRetryDecisionOperation <NSObject>

@property (nonatomic, weak) id<TWGRetryDecisionDelegate>delegate;

@end

#endif
