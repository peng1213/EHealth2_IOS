//
//  InvoiceListTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TClivbaseInfo.h"
@interface InvoiceListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *CLIV_ID;//赔案号
@property (nonatomic, strong) UILabel *CLIV_TYPE_DESC;//状态
@property (nonatomic, strong) UILabel *CLIV_FRM_DT;//状态
@property (nonatomic, strong) UILabel *CLIV_TO_DT;//状态
@property (nonatomic, strong) UILabel *CLIV_HPHP_NAME;//申请金额
//CLIM_TYPE_DESC CLIM_REALPAY_AMT
@property (nonatomic, strong) UILabel *IVDT_TOTAL_AMT;
@property (nonatomic, strong) UILabel *CLIV_SHIP_AMT;
@property (nonatomic, strong) UILabel *IVDT_DEDUCT_AMT;
@property (nonatomic, strong) UILabel *IVDT_RESONABLE_AMT;
@property (nonatomic, strong) UILabel *IVDT_REALPAY_AMT;
@property (nonatomic, strong) UILabel *IVDT_DEDUCT_DESC;
-(void) setCellValue:(TClivbaseInfo * ) model;
@end
