//
//  GoogleImageDownloadOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-05.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>

@interface GoogleImageDownloadOperation : TWGGroupOperation

@property (nonatomic, strong) NSString *searchString;

+ (instancetype) imageDownloadOperationWithSearchString:(NSString *)searchString;

@end
