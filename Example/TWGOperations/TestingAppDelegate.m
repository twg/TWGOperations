//
//  TestingAppDelegate.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-06.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "TestingAppDelegate.h"

@implementation TestingAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [TestingAppDelegate twg_GreenColour];

    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];

    return YES;
}

- (UIWindow *)window
{
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

+ (UIColor *)twg_GreenColour
{
    return [UIColor colorWithRed:152.f / 255.f green:194.f / 255.f blue:61.f / 255.f alpha:1.f];
}

@end