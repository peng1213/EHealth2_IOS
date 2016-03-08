//
//  QueryClaimsListTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QueryClaimsListTableViewCell.h"

@implementation QueryClaimsListTableViewCell

@synthesize CLIM_ID_Label;
@synthesize SYSV_QUEUE_Label;
@synthesize CLBC_CREATE_DT_Label;
@synthesize CLIM_TYPE_DESC_Label;
@synthesize CLIM_APPLY_AMT_Label;
@synthesize CLIM_REALPAY_AMT_Label;
@synthesize REPORT_ID_Label;
@synthesize REPORT_TYPE_Label;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //第一行
        UILabel *reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+25*2, (self.frame.size.width-20)/4, 25)];
        [reportLabel setFont:[UIFont systemFontOfSize:13]];
        [reportLabel setTextAlignment:NSTextAlignmentLeft];
        [reportLabel setText:@"赔案号"];
        [reportLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:reportLabel];
        
        if (self.CLIM_ID_Label == nil) {
            CLIM_ID_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+25*2, (self.frame.size.width-20)/4*3, 25)];
        }
        [CLIM_ID_Label setTextAlignment:NSTextAlignmentLeft];
        [CLIM_ID_Label setFont:[UIFont systemFontOfSize:13]];
        [CLIM_ID_Label setText:@"00000000000000000003"];
        [CLIM_ID_Label setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:CLIM_ID_Label];
        
        UILabel *Queue = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10, (self.frame.size.width-20)/4, 25)];
        [Queue setFont:[UIFont systemFontOfSize:13]];
        [Queue setTextAlignment:NSTextAlignmentLeft];
        [Queue setText:@"案件状态"];
        [Queue setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:Queue];
        if (self.SYSV_QUEUE_Label == nil) {
            SYSV_QUEUE_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10, (self.frame.size.width-20)/4, 25)];
        }
        [SYSV_QUEUE_Label setTextAlignment:NSTextAlignmentLeft];
        [SYSV_QUEUE_Label setFont:[UIFont systemFontOfSize:13]];
        [SYSV_QUEUE_Label setTextColor:[UIColor blackColor]];
        [SYSV_QUEUE_Label setText:@"已结案"];
        [self.contentView addSubview:SYSV_QUEUE_Label];
        
        
        
        //第二行 受理日期 与赔案类型
        UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.frame.size.width-20)/4, 25)];
        [pLabel setBackgroundColor:[UIColor clearColor]];
        [pLabel setTextColor:[UIColor blackColor]];
        [pLabel setText:@"受理日期"];
        [pLabel setFont:[UIFont systemFontOfSize:13]];
        [pLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:pLabel];
        
        if (self.CLBC_CREATE_DT_Label == nil) {
            CLBC_CREATE_DT_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4, 10, (self.frame.size.width-20)/4, 25)];
        }
        [CLBC_CREATE_DT_Label setTextAlignment:NSTextAlignmentLeft];
        [CLBC_CREATE_DT_Label setTextColor:[UIColor blackColor]];
        [CLBC_CREATE_DT_Label setText:@"2015-03-01"];
        [CLBC_CREATE_DT_Label setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLBC_CREATE_DT_Label];
        
        
        
        
        UILabel *ppLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+25, (self.frame.size.width-20)/4, 25)];
        [ppLabel setBackgroundColor:[UIColor clearColor]];
        [ppLabel setTextColor:[UIColor blackColor]];
        [ppLabel setText:@"赔案类型"];
        [ppLabel setFont:[UIFont systemFontOfSize:13]];
        [ppLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:ppLabel];

        if (self.CLIM_TYPE_DESC_Label == nil) {
            CLIM_TYPE_DESC_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+25, (self.frame.size.width-20)/4, 25)];
        }
        
        [CLIM_TYPE_DESC_Label setTextAlignment:NSTextAlignmentLeft];
        [CLIM_TYPE_DESC_Label setTextColor:[UIColor blackColor]];
        [CLIM_TYPE_DESC_Label setText:@"医疗"];
        [CLIM_TYPE_DESC_Label setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIM_TYPE_DESC_Label];
        
        //第三行
        UILabel *amtfuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+25*4, (self.frame.size.width-20)/4, 25)];
        [amtfuLabel setBackgroundColor:[UIColor clearColor]];
        [amtfuLabel setTextColor:[UIColor blackColor]];
        [amtfuLabel setText:@"申请金额"];
        [amtfuLabel setFont:[UIFont systemFontOfSize:13]];
        [amtfuLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:amtfuLabel];

        if (self.CLIM_APPLY_AMT_Label == nil) {
            CLIM_APPLY_AMT_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+25*4, (self.frame.size.width-20)/4, 25)];
        }
        [CLIM_APPLY_AMT_Label setTextAlignment:NSTextAlignmentLeft];
        [CLIM_APPLY_AMT_Label setFont:[UIFont systemFontOfSize:13]];
        [CLIM_APPLY_AMT_Label setText:@"￥9000"];
        [self.contentView addSubview:CLIM_APPLY_AMT_Label];
        
        UILabel *pfLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+25*4, (self.frame.size.width-20)/4, 25)];
        [pfLabel setBackgroundColor:[UIColor clearColor]];
        [pfLabel setTextColor:[UIColor blackColor]];
        [pfLabel setText:@"赔付金额"];
        [pfLabel setFont:[UIFont systemFontOfSize:13]];
        [pfLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:pfLabel];
        
        if (self.CLIM_REALPAY_AMT_Label == nil) {
            CLIM_REALPAY_AMT_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+25*4, (self.frame.size.width-20)/4, 25)];
        }
        
        [CLIM_REALPAY_AMT_Label setTextAlignment:NSTextAlignmentLeft];
        [CLIM_REALPAY_AMT_Label setTextColor:[UIColor blackColor]];
        [CLIM_REALPAY_AMT_Label setText:@"￥9010"];
        [CLIM_REALPAY_AMT_Label setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIM_REALPAY_AMT_Label];
        
        //第四行
        UILabel *rptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+25*3, (self.frame.size.width-20)/4, 25)];
        [rptLabel setBackgroundColor:[UIColor clearColor]];
        [rptLabel setTextColor:[UIColor blackColor]];
        [rptLabel setText:@"报案号"];
        [rptLabel setFont:[UIFont systemFontOfSize:13]];
        [rptLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rptLabel];
        
        if (self.REPORT_ID_Label == nil) {
            REPORT_ID_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+25*3, (self.frame.size.width-20)/4*3, 25)];
        }
        [REPORT_ID_Label setTextAlignment:NSTextAlignmentLeft];
        [REPORT_ID_Label setFont:[UIFont systemFontOfSize:13]];
        [REPORT_ID_Label setText:@"0030435"];
        [self.contentView addSubview:REPORT_ID_Label];
        
        UILabel *rtypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+25, (self.frame.size.width-20)/4, 25)];
        [rtypeLabel setBackgroundColor:[UIColor clearColor]];
        [rtypeLabel setTextColor:[UIColor blackColor]];
        [rtypeLabel setText:@"理赔类型"];
        [rtypeLabel setFont:[UIFont systemFontOfSize:13]];
        [rtypeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rtypeLabel];
        
        if (self.REPORT_TYPE_Label == nil) {
            REPORT_TYPE_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+25, (self.frame.size.width-20)/4, 25)];
        }
        
        [REPORT_TYPE_Label setTextAlignment:NSTextAlignmentLeft];
        [REPORT_TYPE_Label setTextColor:[UIColor blackColor]];
        [REPORT_TYPE_Label setText:@"-"];
        [REPORT_TYPE_Label setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:REPORT_TYPE_Label];
    }
    return self;
}

-(void)setCellValue:(TClaimInfo *)model
{
    self.CLIM_APPLY_AMT_Label.text=[NSString stringWithFormat:@"¥%@",model.CLIM_APPLY_AMT];
    self.CLIM_ID_Label.text=model.CLIM_ID;
    self.CLIM_REALPAY_AMT_Label.text=[NSString stringWithFormat:@"¥%@",model.CLIM_REALPAY_AMT];
    self.CLIM_TYPE_DESC_Label.text=model.CLIM_TYPE_DESC;
    self.REPORT_ID_Label.text=model.REPORT_ID;
    self.REPORT_TYPE_Label.text=model.REPORT_TYPE;
    self.CLBC_CREATE_DT_Label.text=model.CLBC_CREATE_DT;
    self.SYSV_QUEUE_Label.text=model.SYSV_QUEUE;
}


- (void)dealloc
{
    self.CLIM_ID_Label = nil;
    self.SYSV_QUEUE_Label = nil;
    self.CLBC_CREATE_DT_Label = nil;
    self.CLIM_TYPE_DESC_Label = nil;
    self.REPORT_TYPE_Label = nil;
    self.REPORT_ID_Label=nil;
    self.CLIM_REALPAY_AMT_Label=nil;
    self.CLIM_APPLY_AMT_Label=nil;
         
}

@end
