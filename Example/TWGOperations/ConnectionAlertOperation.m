//
//  ConnectionAlertOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-05-04.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "ConnectionAlertOperation.h"

@implementation ConnectionAlertOperation

- (NSString *)alertTitle
{
    return NSLocalizedString(@"Unable to connect", @"");
}

- (NSString *)alertMessage
{
    return NSLocalizedString(@"We are having trouble connecting to Flickr,\nTry again?", @"");
}

- (NSString *)confirmText
{
    return NSLocalizedString(@"Retry", @"");
}

- (NSString *)cancelText
{
    return NSLocalizedString(@"Cancel", @"");
}

@end
