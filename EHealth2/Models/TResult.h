//
//  TResult.h
//  citic
//
//  Created by jiaojunkang on 15-4-3.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TResult : NSObject


@property (assign ,nonatomic) int ResultCode ;// 0是成功 1是错误 2是 异常 网络的api有问题 没有分清是否是正确

@property (nonatomic, strong) NSString *ResultDesc;

@end
