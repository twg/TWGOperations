//
//  AlertOperation.h
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-25.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import <TWGOperations/TWGOperations-umbrella.h>
#import <UIKit/UIKit.h>

@interface AlertOperation : TWGBaseOperation <UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

+ (instancetype)alertOperationWithTitle:(NSString *)title andMessage:(NSString *)message;


/*
 Alert cancel button text
 Default "Okay"
 */
@property (nonatomic, copy) NSString *confirmButtonTitle;

/*
 Alert title
 Required
 */
@property (nonatomic, copy) NSString *title;

/*
 Alert message
 Required
 */
@property (nonatomic, copy) NSString *message;

//protected
- (void) configureAlert;

/*
 TWGAlertOperation uses:
 - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
 to capture result and finish;
 */


@end
