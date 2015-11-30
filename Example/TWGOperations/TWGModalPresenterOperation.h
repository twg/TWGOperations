//
//  TWGModalPresenterOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface TWGModalPresenterOperation : TWGGroupOperation

@property (nonatomic, strong) UIViewController *parentViewController;

+ (instancetype) modalPresenterOperationWithParentViewController:(UIViewController *)parentViewController;

@end
