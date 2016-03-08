//
//  InvoiceListTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "InvoiceListTableViewCell.h"

@implementation InvoiceListTableViewCell

@synthesize CLIV_ID;
@synthesize CLIV_TYPE_DESC;
@synthesize CLIV_FRM_DT;
@synthesize CLIV_TO_DT;
@synthesize CLIV_HPHP_NAME;
@synthesize IVDT_TOTAL_AMT;
@synthesize IVDT_REALPAY_AMT;
@synthesize IVDT_DEDUCT_AMT;
@synthesize IVDT_RESONABLE_AMT;
@synthesize CLIV_SHIP_AMT;
@synthesize IVDT_DEDUCT_DESC;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        [reportLabel setFont:[UIFont systemFontOfSize:13]];
        [reportLabel setTextAlignment:NSTextAlignmentLeft];
        [reportLabel setText:@"发票号"];
        [reportLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:reportLabel];
        
        if (self.CLIV_ID == nil) {
            CLIV_ID = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        }
        [CLIV_ID setTextAlignment:NSTextAlignmentLeft];
        [CLIV_ID setFont:[UIFont systemFontOfSize:13]];
        [CLIV_ID setText:@"0000"];
        [CLIV_ID setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:CLIV_ID];
        
        
        
        
        
        UILabel *ptsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        [ptsLabel setBackgroundColor:[UIColor clearColor]];
        [ptsLabel setTextColor:[UIColor blackColor]];
        [ptsLabel setText:@"发票类型"];
        [ptsLabel setFont:[UIFont systemFontOfSize:13]];
        [ptsLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:ptsLabel];

        
        if (self.CLIV_TYPE_DESC == nil) {
            CLIV_TYPE_DESC = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        } 
        [CLIV_TYPE_DESC setFont:[UIFont systemFontOfSize:13]];
        [CLIV_TYPE_DESC setTextColor:[UIColor blackColor]];
        [CLIV_TYPE_DESC setText:@"已结案"];
        [self.contentView addSubview:CLIV_TYPE_DESC];
        
        
        
        //第二行 受理日期 与赔案类型
        UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        [pLabel setBackgroundColor:[UIColor clearColor]];
        [pLabel setTextColor:[UIColor blackColor]];
        [pLabel setText:@"就诊日期"];
        [pLabel setFont:[UIFont systemFontOfSize:13]];
        [pLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:pLabel];
        
        if (self.CLIV_FRM_DT == nil) {
            CLIV_FRM_DT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        }
        [CLIV_FRM_DT setTextAlignment:NSTextAlignmentLeft];
        [CLIV_FRM_DT setTextColor:[UIColor blackColor]];
        [CLIV_FRM_DT setText:@"2015-03-01"];
        [CLIV_FRM_DT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIV_FRM_DT];
        
        
        
        
        UILabel *ppLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        [ppLabel setBackgroundColor:[UIColor clearColor]];
        [ppLabel setTextColor:[UIColor blackColor]];
        [ppLabel setText:@"出院日期"];
        [ppLabel setFont:[UIFont systemFontOfSize:13]];
        [ppLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:ppLabel];
        
        if (self.CLIV_TO_DT == nil) {
            CLIV_TO_DT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        }
        
        [CLIV_TO_DT setTextAlignment:NSTextAlignmentLeft];
        [CLIV_TO_DT setTextColor:[UIColor blackColor]];
        [CLIV_TO_DT setText:@"医疗"];
        [CLIV_TO_DT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIV_TO_DT];
        
        //第三行
        UILabel *amtfuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*2, (self.frame.size.width-20)/4, 27.5)];
        [amtfuLabel setBackgroundColor:[UIColor clearColor]];
        [amtfuLabel setTextColor:[UIColor blackColor]];
        [amtfuLabel setText:@"就诊医院"];
        [amtfuLabel setFont:[UIFont systemFontOfSize:13]];
        [amtfuLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:amtfuLabel];
        
        if (self.CLIV_HPHP_NAME == nil) {
            CLIV_HPHP_NAME = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*2, (self.frame.size.width-20)/4*3, 27.5)];
        }
        [CLIV_HPHP_NAME setTextAlignment:NSTextAlignmentLeft];
        [CLIV_HPHP_NAME setFont:[UIFont systemFontOfSize:13]];
        [CLIV_HPHP_NAME setText:@"￥9000"];
        CLIV_HPHP_NAME.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:CLIV_HPHP_NAME];
        
        //第四行
        UILabel *rptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*3, (self.frame.size.width-20)/4, 27.5)];
        [rptLabel setText:@"总金额"];
        [rptLabel setFont:[UIFont systemFontOfSize:13]];
        [rptLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rptLabel];
        
        if (self.IVDT_TOTAL_AMT == nil) {
            IVDT_TOTAL_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*3, (self.frame.size.width-20)/4, 27.5)];
        }
        [IVDT_TOTAL_AMT setTextAlignment:NSTextAlignmentLeft];
        [IVDT_TOTAL_AMT setFont:[UIFont systemFontOfSize:13]];
        [IVDT_TOTAL_AMT setText:@"0030435"];
        [self.contentView addSubview:IVDT_TOTAL_AMT];
        
        UILabel *shipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*3, (self.frame.size.width-20)/4, 27.5)];
        [shipLabel setBackgroundColor:[UIColor clearColor]];
        [shipLabel setTextColor:[UIColor blackColor]];
        [shipLabel setText:@"统筹支付"];
        [shipLabel setFont:[UIFont systemFontOfSize:13]];
        [shipLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:shipLabel];
        
        if (self.CLIV_SHIP_AMT == nil) {
            CLIV_SHIP_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*3, (self.frame.size.width-20)/4, 27.5)];
        }
        
        [CLIV_SHIP_AMT setTextAlignment:NSTextAlignmentLeft];
        [CLIV_SHIP_AMT setTextColor:[UIColor blackColor]];
        [CLIV_SHIP_AMT setText:@"-"];
        [CLIV_SHIP_AMT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIV_SHIP_AMT];
        
        UILabel *deductLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*4, (self.frame.size.width-20)/4, 27.5)];
        [deductLabel setBackgroundColor:[UIColor clearColor]];
        [deductLabel setTextColor:[UIColor blackColor]];
        [deductLabel setText:@"扣除金额"];
        [deductLabel setFont:[UIFont systemFontOfSize:13]];
        [deductLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:deductLabel];
        
        if (self.IVDT_DEDUCT_AMT == nil) {
            IVDT_DEDUCT_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*4, (self.frame.size.width-20)/4, 27.5)];
        }
        
        [IVDT_DEDUCT_AMT setTextAlignment:NSTextAlignmentLeft];
        [IVDT_DEDUCT_AMT setTextColor:[UIColor blackColor]];
        [IVDT_DEDUCT_AMT setText:@"-"];
        [IVDT_DEDUCT_AMT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:IVDT_DEDUCT_AMT];
        
        UILabel *rtypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*4, (self.frame.size.width-20)/4, 27.5)];
        [rtypeLabel setBackgroundColor:[UIColor clearColor]];
        [rtypeLabel setTextColor:[UIColor blackColor]];
        [rtypeLabel setText:@"合理金额"];
        [rtypeLabel setFont:[UIFont systemFontOfSize:13]];
        [rtypeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rtypeLabel];
        
        if (self.IVDT_RESONABLE_AMT == nil) {
            IVDT_RESONABLE_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*4, (self.frame.size.width-20)/4, 27.5)];
        }
        
        [IVDT_RESONABLE_AMT setTextAlignment:NSTextAlignmentLeft];
        [IVDT_RESONABLE_AMT setTextColor:[UIColor blackColor]];
        [IVDT_RESONABLE_AMT setText:@"-"];
        [IVDT_RESONABLE_AMT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:IVDT_RESONABLE_AMT];
        
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*5, (self.frame.size.width-20)/4, 27.5)];
        [descLabel setBackgroundColor:[UIColor clearColor]];
        [descLabel setTextColor:[UIColor blackColor]];
        [descLabel setText:@"扣费描述"];
        [descLabel setFont:[UIFont systemFontOfSize:13]];
        [descLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:descLabel];
        
        if (self.IVDT_DEDUCT_DESC == nil) {
            IVDT_DEDUCT_DESC = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*5, (self.frame.size.width-20)/4*3, 27.5*2)];
        }
        
        [IVDT_DEDUCT_DESC setTextAlignment:NSTextAlignmentLeft];
        [IVDT_DEDUCT_DESC setTextColor:[UIColor blackColor]];
        [IVDT_DEDUCT_DESC setText:@"-"];
        [IVDT_DEDUCT_DESC setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:IVDT_DEDUCT_DESC];
        
        
    }
    return self;
}

-(void)setCellValue:(TClivbaseInfo *)model
{
    self.CLIV_HPHP_NAME.text=[NSString stringWithFormat:@"¥%@",model.CLIV_HPHP_NAME];
    self.CLIV_ID.text=model.CLIV_ID;
    self.CLIV_TO_DT.text=model.CLIV_TO_DT;
    self.IVDT_TOTAL_AMT.text=[NSString stringWithFormat:@"¥%@",model.IVDT_TOTAL_AMT];
    self.IVDT_REALPAY_AMT.text=[NSString stringWithFormat:@"¥%@",model.IVDT_REALPAY_AMT];
    self.CLIV_FRM_DT.text=model.CLIV_FRM_DT;
    self.CLIV_TYPE_DESC.text=model.CLIV_TYPE_DESC;
    
    self.CLIV_SHIP_AMT.text=[NSString stringWithFormat:@"¥%@",model.CLIV_SHIP_AMT];
    self.IVDT_DEDUCT_DESC.text=model.IVDT_DEDUCT_DESC;
    self.IVDT_DEDUCT_AMT.text=[NSString stringWithFormat:@"¥%@",model.IVDT_DEDUCT_AMT];
    self.IVDT_RESONABLE_AMT.text=[NSString stringWithFormat:@"¥%@",model.IVDT_REASONABLE_AMT];
    self.IVDT_DEDUCT_DESC.numberOfLines=0;
    //新的尺寸
    //获取cell高度
    CGSize size=CGSizeMake((self.frame.size.width-20)/4*3, 27.5*2);
    CGSize labelSize = [self.IVDT_DEDUCT_DESC.text sizeWithFont:self.IVDT_DEDUCT_DESC.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.IVDT_DEDUCT_DESC.frame = CGRectMake(self.IVDT_DEDUCT_DESC.frame.origin.x, self.IVDT_DEDUCT_DESC.frame.origin.y, labelSize.width, labelSize.height);
}


- (void)dealloc
{
    self.CLIV_ID = nil;
    self.CLIV_TYPE_DESC = nil;
    self.CLIV_FRM_DT = nil;
    self.CLIV_TO_DT = nil;
    self.IVDT_REALPAY_AMT = nil;
    self.IVDT_TOTAL_AMT=nil;
    self.CLIV_HPHP_NAME=nil;
    self.CLIV_SHIP_AMT=nil;
    self.IVDT_DEDUCT_DESC=nil;
    self.IVDT_DEDUCT_AMT=nil;
    self.IVDT_RESONABLE_AMT=nil;
}

@end
