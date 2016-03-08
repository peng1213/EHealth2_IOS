//
//  RegisterInfo.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultInfo.h"

@interface RegisterInfo : NSObject

@property (nonatomic,strong) ResultInfo *resultInfo;
@property (nonatomic,strong) NSString *registerID;//注册身份证账号
@property (nonatomic,strong) NSString *registerName;//姓名

@property (nonatomic,strong) NSString *userName;//用户账号
@property (nonatomic,strong) NSString *userPwd;//登录密码
@property (nonatomic,strong) NSString *contactNum;//联系方式
@property (nonatomic,strong) NSString *email;//电子邮箱
@property (nonatomic,strong) NSString *address;//地址
@property (nonatomic,strong) NSString *code;//邮编

@end
