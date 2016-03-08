//
//  MyCaseTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/1.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "MyCaseTableViewCell.h"
#import "NSMutableArray+FieldConfig.h"

@implementation MyCaseTableViewCell
@synthesize caseNumLabel;
@synthesize moneyLabel;
@synthesize patientLabel;
@synthesize stateLabel;
@synthesize timeLabel;
@synthesize pLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 70.0)];
        [cellBg setImage:[UIImage imageNamed:@"mycase_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        UIImageView *payIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17.5, 35, 35)];
        [payIcon setImage:[UIImage imageNamed:@"mycase_pay_icon.png"]];
        [self.contentView addSubview:payIcon];
        
        UILabel *reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 60, 20)];
        [reportLabel setFont:[UIFont systemFontOfSize:13]];
        [reportLabel setTextAlignment:NSTextAlignmentLeft];
        [reportLabel setText:@"报案号:"];
        [reportLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:reportLabel];
        
        if (self.caseNumLabel == nil) {
            caseNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 180, 20)];
        }
        [caseNumLabel setTextAlignment:NSTextAlignmentLeft];
        [caseNumLabel setFont:[UIFont systemFontOfSize:13]];
        [caseNumLabel setText:@"0114090999999142"];
        [caseNumLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:caseNumLabel];

        if (self.moneyLabel == nil) {
            moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 25, 100, 20)];
        }
        [moneyLabel setFont:[UIFont systemFontOfSize:13]];
        [moneyLabel setTextColor:[UIColor blackColor]];
        [moneyLabel setTextAlignment:NSTextAlignmentRight];
        [moneyLabel setText:@"¥2154"];
        [self.contentView addSubview:moneyLabel];
        
        pLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 60, 20)];
        [pLabel setBackgroundColor:[UIColor clearColor]];
        [pLabel setTextColor:[UIColor blackColor]];
        [pLabel setText:@"就诊人:"];
        [pLabel setFont:[UIFont systemFontOfSize:13]];
        [pLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:pLabel];
        
        if (self.patientLabel == nil) {
            patientLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 150, 20)];
        }
        [patientLabel setTextAlignment:NSTextAlignmentLeft];
        [patientLabel setTextColor:[UIColor blackColor]];
        [patientLabel setText:@"张春华"];
        [patientLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:patientLabel];
        
        if (self.stateLabel == nil) {
            stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 45, 100, 20)];
        }
        [stateLabel setTextAlignment:NSTextAlignmentRight];
        [stateLabel setTextColor:[UIColor blackColor]];
        [stateLabel setText:@"未完成"];
        [stateLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:stateLabel];
        
        if (self.timeLabel == nil) {
            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 45, 150, 20)];
        }
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        [timeLabel setText:@"2015-04-01"];
        [timeLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:timeLabel];
        
        
    }
    return self;
}

-(void)setCellValue:(TReptCaseInfo *)model andConfigList:(NSMutableArray *)fieldConfig
{
    //根据不同状态设置字体颜色
    if ([model.QUEUE_DESC isEqualToString:@"未完成"]) {
        self.stateLabel.textColor = [UIColor redColor];
    }
//    else if ([model.QUEUE_DESC isEqualToString:@"待初审"])
//    {
//        self.stateLabel.textColor = [UIColor blueColor];
//    }
//    else if ([model.QUEUE_DESC isEqualToString:@"初审未通过"])
//    {
//        self.stateLabel.textColor = [UIColor redColor];
//    }
//    else if ([model.QUEUE_DESC isEqualToString:@"已结案"])
//    {
//        self.stateLabel.textColor = [UIColor greenColor];
//    }
    [caseNumLabel setText:model.REPT_ID];
    [moneyLabel setText:[NSString stringWithFormat:@"￥%@", model.APPL_AMT]];
    [patientLabel setText:model.MEME_NAME];
    [timeLabel setText:model.VISIT_FRM_DT];
    [stateLabel setText:model.QUEUE_DESC];
    [pLabel setText:[NSString stringWithFormat:@"%@:",[fieldConfig getConfigByName:@"MEME_NAME"].FIELD_DISP_NAME]] ;
}


- (void)dealloc
{
    self.caseNumLabel = nil;
    self.moneyLabel = nil;
    self.patientLabel = nil;
    self.stateLabel = nil;
    self.timeLabel = nil;
}

@end
