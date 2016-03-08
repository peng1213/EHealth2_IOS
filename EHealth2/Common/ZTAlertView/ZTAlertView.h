//
//  ZTAlertView.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/2.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZTAlertViewBlock)();
typedef void (^ZTAlertViewStringBlock)(NSString *);

@interface ZTAlertView : NSObject<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

/**
 *  ZTAlertView初始化
 *
 *  @param title
 *  @param message
 *  @param cancelButtonTitle
 *  @param otherButtonTitles
 *  @param cancelButtonBlock
 *  @param otherButtonBlock
 *
 *  @return
 */
- (id) initWithTitle:(NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(ZTAlertViewBlock)cancelButtonBlock
    otherButtonBlock:(ZTAlertViewBlock)otherButtonBlock;

/**
 *  ZTAlertView初始化
 *
 *  @param title
 *  @param message
 *  @param textFieldMessage
 *  @param texttFieldValue
 *  @param cancelButtonTitle
 *  @param otherButtonTitles
 *  @param cancelButtonBlock
 *  @param otherButtonBlock
 *
 *  @return
 */
- (id) initWithTitle:(NSString *)title
             message:(NSString*)message
       textFieldHint:(NSString *)textFieldMessage
      textFieldValue:(NSString *)texttFieldValue
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(ZTAlertViewBlock)cancelButtonBlock
    otherButtonBlock:(ZTAlertViewStringBlock)otherButtonBlock;

- (void)ZTAlertViewShow;

@end
