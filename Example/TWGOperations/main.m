//
//  main.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 09/22/2015.
//  Copyright (c) 2015 Nicholas Kuhne. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"
#import "TestingAppDelegate.h"

static BOOL isRunningTests(void)
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSString *testing = environment[@"TESTING"];
    return [testing isEqualToString:@"1"];
}

int main(int argc, char *argv[])
{
    @autoreleasepool {

        Class appDelegateClass = [AppDelegate class];
        if (isRunningTests()) {
            appDelegateClass = [TestingAppDelegate class];
        }

        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}