//
//  RegisterThirdStepViewController.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUserInfo.h"
#import "HttpRequestManager.h"
#import "UIKeyboardViewController.h"
@interface RegisterThirdStepViewController : UIViewController<HttpRequestManagerDelegate>
{
    UIKeyboardViewController *keyBoardController;
}
@property (nonatomic, strong) TUserInfo *registerInfo;
@end
