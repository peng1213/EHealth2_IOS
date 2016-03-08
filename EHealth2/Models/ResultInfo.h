//
//  ResultInfo.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/30.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultInfo : NSObject

@property (nonatomic, strong) NSString *resultCode;// 0是成功 1是错误 2是 异常
@property (nonatomic, strong) NSString *resultDesc;

@end
