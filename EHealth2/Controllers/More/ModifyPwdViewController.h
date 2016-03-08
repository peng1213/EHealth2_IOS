//
//  ModifyPwdViewController.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/31.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestManager.h"
#import "UIKeyboardViewController.h"

@interface ModifyPwdViewController : UIViewController<UITextFieldDelegate,HttpRequestManagerDelegate>
{
    UIKeyboardViewController *keyBoardController;
}
@end
