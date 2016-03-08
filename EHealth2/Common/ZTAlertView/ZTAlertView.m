//
//  ZTAlertView.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/2.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ZTAlertView.h"

typedef enum {
    ZTAlertViewTypeNormal,
    ZTAlertViewTypeTextField
} ZTAlertViewType;
@interface ZTAlertView()
@property (nonatomic, strong) ZTAlertViewBlock cancelButtonBlock;
@property (nonatomic, strong) ZTAlertViewBlock otherButtonBlock;
@property (nonatomic, strong) ZTAlertViewStringBlock textFieldBlock;
@end
@implementation ZTAlertView

@synthesize alertView;
@synthesize cancelButtonBlock;
@synthesize otherButtonBlock;
@synthesize textFieldBlock;

#pragma mark --
#pragma mark -- UIAlertViewDelegate methods
- (void) alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && cancelButtonBlock)
        cancelButtonBlock();
    else if (buttonIndex == 1 && theAlertView.tag == ZTAlertViewTypeNormal && otherButtonBlock)
        otherButtonBlock();
    else if (buttonIndex == 1 && theAlertView.tag == ZTAlertViewTypeTextField && textFieldBlock)
        textFieldBlock([alertView textFieldAtIndex:0].text);
    
}

- (void) alertViewCancel:(UIAlertView *)theAlertView
{
    if (cancelButtonBlock)
        cancelButtonBlock();
}

- (id) initWithTitle:(NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(ZTAlertViewBlock)theCancelButtonBlock
    otherButtonBlock:(ZTAlertViewBlock)theOtherButtonBlock
{
    
    if (self.cancelButtonBlock == nil) {
        cancelButtonBlock = [theCancelButtonBlock copy];
    }
    
    if (self.otherButtonBlock == nil) {
        textFieldBlock = [theOtherButtonBlock copy];
    }
    if (self.alertView ==nil) {
        alertView = [[UIAlertView alloc] initWithTitle:title
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:cancelButtonTitle
                                     otherButtonTitles:otherButtonTitles, nil];
        alertView.tag = ZTAlertViewTypeNormal;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title
             message:(NSString *)message
       textFieldHint:(NSString *)textFieldMessage
      textFieldValue:(NSString *)texttFieldValue
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(ZTAlertViewBlock)theCancelButtonBlock
    otherButtonBlock:(ZTAlertViewStringBlock)theOtherButtonBlock
{
    if (self.cancelButtonBlock == nil) {
        cancelButtonBlock = [theCancelButtonBlock copy];
    }
    
    if (self.otherButtonBlock == nil) {
        textFieldBlock = [theOtherButtonBlock copy];
    }

    if (self.alertView ==nil) {
        alertView = [[UIAlertView alloc] initWithTitle:title
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:cancelButtonTitle
                                     otherButtonTitles:otherButtonTitles, nil];
        alertView.tag = ZTAlertViewTypeTextField;
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    }
    
    [[alertView textFieldAtIndex:0] setPlaceholder:textFieldMessage];
    [[alertView textFieldAtIndex:0] setText:texttFieldValue];
    
    return self;
}

- (void)ZTAlertViewShow
{
    [alertView show];
}

- (void)dealloc
{
    [self.alertView setDelegate:nil];
    self.alertView = nil;
    self.cancelButtonBlock = nil;
    self.otherButtonBlock = nil;
    self.textFieldBlock = nil;
}

@end
