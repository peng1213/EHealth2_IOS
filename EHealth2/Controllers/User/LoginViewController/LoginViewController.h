//
//  LoginViewController.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestManager.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate,HttpRequestManagerDelegate>

@property (strong, nonatomic)  UITextField *userTextField;
@property (strong, nonatomic)  UITextField *userPwdTextField;


@end
