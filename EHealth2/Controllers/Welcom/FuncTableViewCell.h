//
//  FuncTableViewCell.h
//  EHealth2
//
//  Created by 刘祯 on 15/8/11.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFunctionInfo.h"

@interface FuncTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *funcName;
@property (nonatomic, strong) UIButton *btnChecked;
-(void) setCellValue:(TFunctionInfo * ) model ;
-(void)checkboxClick:(UIButton*)btn;
@end
