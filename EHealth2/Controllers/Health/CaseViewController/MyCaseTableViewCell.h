//
//  MyCaseTableViewCell.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/1.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptCaseInfo.h"
@interface MyCaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *caseNumLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *patientLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *pLabel;
-(void) setCellValue:(TReptCaseInfo * ) model andConfigList:(NSMutableArray *)fieldConfig;

@end
