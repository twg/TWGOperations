//
//  TWGAlertOperation.h
//  TWGOperations
//
//  Created by Alex Stroulger on 2016-04-29.
//  Copyright (c) 2016 TWG. All rights reserved.
//

#import "TWGOperation.h"

/*
 A TWGAlertOperation provides a UIAlertView or UIAlertController for notification on confirmation

 Subclassing Notes:
 You may find that subclassing a TWGAlertOperation to provide standard defaults for text options is a good option for
 common connection and retry alerts

 */

@interface TWGAlertOperation : TWGOperation <NSCopying>

/*
 Optionally provide a view controller for presetation, default is rootViewController of the key UIWindow
 Note: this operation will finishWithError: if the presentingViewController is already presenting
 */
@property (weak, nonatomic, nullable) UIViewController *presentingViewController NS_AVAILABLE_IOS(8.0);

/*
 should the alery show a cancel button
 */
@property (assign, nonatomic) BOOL cancelable;

/*
 set text for title, message, and buttons in the alert
 */
@property (strong, nonatomic, nullable) NSString *alertMessage;
@property (strong, nonatomic, nullable) NSString *alertTitle;
@property (strong, nonatomic, nullable) NSString *confirmText;
@property (strong, nonatomic, nullable) NSString *cancelText;

@end
