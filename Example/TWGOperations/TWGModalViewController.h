//
//  TWGModalViewController.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-27.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWGModalViewController;

@protocol TWGModalViewControllerDelegate <NSObject>

- (void) modalViewControllerRequestsClose:(TWGModalViewController *)modalViewController;

@end

@interface TWGModalViewController : UIViewController

@property (nonatomic, strong) id<TWGModalViewControllerDelegate>delegate;

@end
