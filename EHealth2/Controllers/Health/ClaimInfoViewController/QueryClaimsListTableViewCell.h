//
//  QueryClaimsListTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TClaimInfo.h"
@interface QueryClaimsListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *CLIM_ID_Label;//赔案号
@property (nonatomic, strong) UILabel *SYSV_QUEUE_Label;//状态
@property (nonatomic, strong) UILabel *CLBC_CREATE_DT_Label;//状态
@property (nonatomic, strong) UILabel *CLIM_TYPE_DESC_Label;//状态
@property (nonatomic, strong) UILabel *CLIM_APPLY_AMT_Label;//申请金额
@property (nonatomic, strong) UILabel *CLIM_REALPAY_AMT_Label;//陪付金额
//CLIM_TYPE_DESC CLIM_REALPAY_AMT
@property (nonatomic, strong) UILabel *REPORT_ID_Label;
@property (nonatomic, strong) UILabel *REPORT_TYPE_Label;
-(void) setCellValue:(TClaimInfo * ) model;
@end
