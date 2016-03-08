//
//  ReportInfo.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/1.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultInfo.h"
@interface ReportInfo : NSObject
@property (nonatomic, strong) ResultInfo *resultInfo;
@property (nonatomic, strong) NSString *compID;//项目ID
@property (nonatomic, strong) NSString *compName;//项目名称
@property (nonatomic, strong) NSString *mngID;//所属分支ID
@property (nonatomic, strong) NSString *mngName;//所属分支名
@property (nonatomic, strong) NSString *clbcKey;//批次Key
@property (nonatomic, strong) NSString *clbcID;//批次号
@property (nonatomic, strong) NSString *applyKey;//申请key
@property (nonatomic, strong) NSString *meKey;//mekey
@property (nonatomic, strong) NSString *userName;//用户名
@property (nonatomic, strong) NSString *userIC;//证件号
@property (nonatomic, strong) NSString *caseType;//报案类型
@property (nonatomic, strong) NSString *applyMoney;//申请金额
@property (nonatomic, strong) NSString *illDesc;//疾病描述
@property (nonatomic, strong) NSString *frmDate;//就诊时间
@property (nonatomic, strong) NSString *toDate;//出院时间
@property (nonatomic, strong) NSString *queueCode;//任务状态Code
@property (nonatomic, strong) NSString *queueDesc;//任务状态描述
@property (nonatomic, strong) NSString *syncFlag;//同步标志
@property (nonatomic, strong) NSString *bankCode;//银行代码
@property (nonatomic, strong) NSString *bacnkName;//银行名
@property (nonatomic, strong) NSString *accountNum;//卡号
@property (nonatomic, strong) NSString *accountName;//开户行
@property (nonatomic, strong) NSString *zipCode;//邮编
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, strong) NSString *phoneNum;//手机号
@property (nonatomic, strong) NSString *reportCreateUser;//报案人
@property (nonatomic, strong) NSString *platForm;//平台

@end
