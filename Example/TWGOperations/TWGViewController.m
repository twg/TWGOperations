//
//  TWGViewController.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 09/22/2015.
//  Copyright (c) 2015 Nicholas Kuhne. All rights reserved.
//

#import "TWGViewController.h"

#import <TWGOperations/Pods-TWGOperations_Example-TWGOperations-umbrella.h>

@interface TWGViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) TWGGroupOperation *groupOP;

@end

@implementation TWGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    TWGGroupOperation *groupOP = [[TWGGroupOperation alloc] init];
    groupOP.serial = YES;
    
    //self.groupOP = groupOP;
    
    [groupOP setCompletionBlock:^{
        NSLog(@"Completed Both Alerts");
    }];
    
    TWGAlertOperation *alert1 = [TWGAlertOperation alertOperationWithTitle:@"Alert 1" andMessage:@"This is alert 1"];
    TWGAlertOperation *alert2 = [TWGAlertOperation alertOperationWithTitle:@"Alert 2" andMessage:@"This is alert 2"];
    
    groupOP.operations = @[alert1, alert2];
    
    [self.operationQueue addOperation:groupOP];
}


- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}


@end
