//
//  ClaimDetailTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDutybaseInfo.h"
@interface ClaimDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *cellBg;//赔案号
@property (nonatomic, strong) UILabel *CLIMDT_TOTAL_AMT;//赔案号
@property (nonatomic, strong) UILabel *CLIMDT_DEDUCT_AMT;//状态
@property (nonatomic, strong) UILabel *CLIMDT_PAYPERCENT;//状态
@property (nonatomic, strong) UILabel *CLIMDT_REALPAY_AMT;//状态
@property (nonatomic, strong) UILabel *CLIM_COMMENT;//申请金额
//CLIM_TYPE_DESC CLIM_REALPAY_AMT
@property (nonatomic, strong) UILabel *DEDUCT_DESC_Label; 
-(void) setCellValue:(TDutybaseInfo * ) model;
@end
