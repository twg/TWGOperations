//
//  TWGAlertOperation.h
//  Pods
//
//  Created by Nicholas Kuhne on 2015-09-22.
//
//

#import "TWGBaseOperation.h"
#import <UIKit/UIKit.h>

@interface TWGAlertOperation : TWGBaseOperation <UIAlertViewDelegate>

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

@end
