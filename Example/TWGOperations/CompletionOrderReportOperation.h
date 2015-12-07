//
//  ExecutionOrderReportOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-12-07.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface CompletionOrderReportOperation : TWGGroupOperation <TWGOperationDelegate>

@property (nonatomic, strong) NSMutableArray *completedOperations;

@end
