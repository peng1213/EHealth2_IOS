//
//  VerifyCodeView.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/31.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeView : UIView
@property (nonatomic, strong) NSString *codeStr;

- (void)changeVerifyCode;
@end
