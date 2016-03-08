//
//  ClaimDetailTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ClaimDetailTableViewCell.h"

@implementation ClaimDetailTableViewCell

@synthesize CLIMDT_TOTAL_AMT;
@synthesize CLIMDT_DEDUCT_AMT;
@synthesize CLIMDT_PAYPERCENT;
@synthesize CLIMDT_REALPAY_AMT;
@synthesize CLIM_COMMENT;
@synthesize DEDUCT_DESC_Label;
@synthesize cellBg;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //第一行
        UILabel *reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        [reportLabel setFont:[UIFont systemFontOfSize:13]];
        [reportLabel setTextAlignment:NSTextAlignmentLeft];
        [reportLabel setText:@"责任金额"];
        [reportLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:reportLabel];
        
        if (self.CLIMDT_TOTAL_AMT == nil) {
            CLIMDT_TOTAL_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        }
        [CLIMDT_TOTAL_AMT setTextAlignment:NSTextAlignmentLeft];
        [CLIMDT_TOTAL_AMT setFont:[UIFont systemFontOfSize:13]];
        [CLIMDT_TOTAL_AMT setText:@"0003"];
        [CLIMDT_TOTAL_AMT setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:CLIMDT_TOTAL_AMT];
        
        
        
        
        UILabel *kcLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        [kcLabel setBackgroundColor:[UIColor clearColor]];
        [kcLabel setTextColor:[UIColor blackColor]];
        [kcLabel setText:@"扣除金额"];
        [kcLabel setFont:[UIFont systemFontOfSize:13]];
        [kcLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:kcLabel];
        
        if (self.CLIMDT_DEDUCT_AMT == nil) {
            CLIMDT_DEDUCT_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*0, (self.frame.size.width-20)/4, 27.5)];
        }
        [CLIMDT_DEDUCT_AMT setFont:[UIFont systemFontOfSize:13]];
        [CLIMDT_DEDUCT_AMT setTextColor:[UIColor blackColor]];
        [CLIMDT_DEDUCT_AMT setText:@"90"];
        [self.contentView addSubview:CLIMDT_DEDUCT_AMT];
        
        
        
        //第二行 受理日期 与赔案类型
        UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        [pLabel setBackgroundColor:[UIColor clearColor]];
        [pLabel setTextColor:[UIColor blackColor]];
        [pLabel setText:@"赔付比例"];
        [pLabel setFont:[UIFont systemFontOfSize:13]];
        [pLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:pLabel];
        
        if (self.CLIMDT_PAYPERCENT == nil) {
            CLIMDT_PAYPERCENT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        }
        [CLIMDT_PAYPERCENT setTextAlignment:NSTextAlignmentLeft];
        [CLIMDT_PAYPERCENT setTextColor:[UIColor blackColor]];
        [CLIMDT_PAYPERCENT setText:@"90%"];
        [CLIMDT_PAYPERCENT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIMDT_PAYPERCENT];
        
        
        
        
        UILabel *ppLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*2, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        [ppLabel setBackgroundColor:[UIColor clearColor]];
        [ppLabel setTextColor:[UIColor blackColor]];
        [ppLabel setText:@"赔付金额"];
        [ppLabel setFont:[UIFont systemFontOfSize:13]];
        [ppLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:ppLabel];
        
        if (self.CLIMDT_REALPAY_AMT == nil) {
            CLIMDT_REALPAY_AMT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*3, 10+27.5*1, (self.frame.size.width-20)/4, 27.5)];
        }
        
        [CLIMDT_REALPAY_AMT setTextAlignment:NSTextAlignmentLeft];
        [CLIMDT_REALPAY_AMT setTextColor:[UIColor blackColor]];
        [CLIMDT_REALPAY_AMT setText:@"900"];
        [CLIMDT_REALPAY_AMT setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:CLIMDT_REALPAY_AMT];
        
        //第三行
        UILabel *amtfuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*2, (self.frame.size.width-20)/4, 27.5)];
        [amtfuLabel setBackgroundColor:[UIColor clearColor]];
        [amtfuLabel setTextColor:[UIColor blackColor]];
        [amtfuLabel setText:@"扣费明细:"];
        [amtfuLabel setFont:[UIFont systemFontOfSize:13]];
        [amtfuLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:amtfuLabel];
        
        if (self.CLIM_COMMENT == nil) {
            CLIM_COMMENT = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*2, (self.frame.size.width-20)/4*3, 27.5)];
        }
        [CLIM_COMMENT setTextAlignment:NSTextAlignmentLeft];
        [CLIM_COMMENT setFont:[UIFont systemFontOfSize:13]];
        [CLIM_COMMENT setText:@"￥9000"];
        [CLIM_COMMENT setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:CLIM_COMMENT];
        
        //第四行
        UILabel *rptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*0, 10+27.5*3, (self.frame.size.width-20)/4, 27.5)];
        [rptLabel setBackgroundColor:[UIColor clearColor]];
        [rptLabel setTextColor:[UIColor blackColor]];
        [rptLabel setText:@"审核结论"];
        [rptLabel setFont:[UIFont systemFontOfSize:13]];
        [rptLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rptLabel];
        
        if (self.DEDUCT_DESC_Label == nil) {
            DEDUCT_DESC_Label = [[UILabel alloc] initWithFrame:CGRectMake(10+(self.frame.size.width-20)/4*1, 10+27.5*3, (self.frame.size.width-20)/4*3, 27.5*5)];
        }
        [DEDUCT_DESC_Label setFont:[UIFont systemFontOfSize:13]];
        [DEDUCT_DESC_Label setText:@"0030435"];
        [DEDUCT_DESC_Label setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:DEDUCT_DESC_Label];
                
        
    }
    return self;
}

-(void)setCellValue:(TDutybaseInfo *)model
{
    self.CLIM_COMMENT.text=model.DEDUCT_DESC;
    self.CLIMDT_TOTAL_AMT.text=[NSString stringWithFormat:@"¥%@",model.CLIMDT_TOTAL_AMT];
    self.CLIMDT_REALPAY_AMT.text=[NSString stringWithFormat:@"¥%@",model.CLIMDT_REALPAY_AMT];
    self.DEDUCT_DESC_Label.text=model.CLIM_COMMENT;
    self.CLIMDT_PAYPERCENT.text=model.CLIMDT_PAYPERCENT;
    self.CLIMDT_DEDUCT_AMT.text=[NSString stringWithFormat:@"¥%@",model.CLIMDT_DEDUCT_AMT];
    
    self.DEDUCT_DESC_Label.numberOfLines=0;
    //新的尺寸
    //获取cell高度
    CGSize size=CGSizeMake((self.frame.size.width-20)/4*3, 27.5*5);
    CGSize labelSize = [self.DEDUCT_DESC_Label.text sizeWithFont:self.DEDUCT_DESC_Label.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.DEDUCT_DESC_Label.frame = CGRectMake(self.DEDUCT_DESC_Label.frame.origin.x, self.DEDUCT_DESC_Label.frame.origin.y, labelSize.width, labelSize.height);

    //cellBg.contentMode = UIViewContentModeScaleAspectFit;
    //self.frame=frame;
    
}


- (void)dealloc
{
    self.CLIMDT_TOTAL_AMT = nil;
    self.CLIMDT_DEDUCT_AMT = nil;
    self.CLIMDT_PAYPERCENT = nil;
    self.CLIMDT_REALPAY_AMT = nil;
    self.DEDUCT_DESC_Label=nil;
    self.CLIM_COMMENT=nil;
    
}

@end
