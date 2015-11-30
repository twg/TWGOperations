//
//  ModalPresentOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface ModalPresentOperation : TWGOperation

@property (nonatomic, strong) UIViewController *parentViewController;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) BOOL animated;

@end
