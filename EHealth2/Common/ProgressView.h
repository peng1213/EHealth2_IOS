//
//  ProgressView.h
//  EHealth2
//
//  Created by 刘祯 on 15/10/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
@interface ProgressView : UIView

//中心颜色
@property (strong, nonatomic)UIColor *centerColor;
//圆环背景色
@property (strong, nonatomic)UIColor *arcBackColor;
//圆环色
@property (strong, nonatomic)UIColor *arcFinishColor;
@property (strong, nonatomic)UIColor *arcUnfinishColor;


//百分比数值（0-1）
@property (assign, nonatomic)float percent;

//圆环宽度
@property (assign, nonatomic)float width;

@property (strong, nonatomic)ASIFormDataRequest *request;
@end
