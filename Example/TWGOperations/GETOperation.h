//
//  GETOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

@import TWGOperations;

@interface GETOperation : TWGOperation

@property (nonatomic, strong) NSURL *url;

- (id)parsedObject:(NSData *)data;

@end
