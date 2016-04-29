//
//  AppDelegate.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 09/22/2015.
//  Copyright (c) 2015 Nicholas Kuhne. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithStyle:UITableViewStylePlain];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];

    [self.window setRootViewController:self.navigationController];
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

@end
