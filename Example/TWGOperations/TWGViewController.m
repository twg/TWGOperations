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

@end

@implementation TWGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TWGRetryingOperation *operation = [[TWGRetryingOperation alloc] init];
    
    [operation setOperationCompletionBlock:^(id result, NSError *error) {
        NSLog(@"Fin");
    }];
    
    TWGRetryAlertOperation *retryAlert = [TWGRetryAlertOperation alertOperationWithTitle:@"Retry Alert" andMessage:@"Do you want to retry?"];
    operation.retryOperation = retryAlert;
    
    [self.operationQueue addOperation:operation];
}


- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}


@end
