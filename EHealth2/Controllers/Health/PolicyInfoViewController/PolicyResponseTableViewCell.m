//
//  PolicyResponseTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "PolicyResponseTableViewCell.h"
#import "CommonUtil.h"
#import "TDutyDesc.h"

@implementation PolicyResponseTableViewCell
@synthesize mainTitleLabel;
@synthesize contentLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
//        UIImageView *titleBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0, self.frame.size.width, 45)];
//        [titleBg setContentMode:UIViewContentModeScaleAspectFill];
//        [titleBg setImage:[UIImage imageNamed:@"common_input_bg.png"]];
//        [self.contentView addSubview:titleBg];
        if (self.mainTitleLabel == nil) {
            mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-30, 45)];
        }
        [mainTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [mainTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [mainTitleLabel setTextColor:[CommonUtil getColor:@"2b6add" withAlpha:1]];
        [self.contentView addSubview:mainTitleLabel];
        
        if (self.contentLabel == nil) {
            contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 48, self.frame.size.width-30, 45.0)];
        }
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setFont:[UIFont systemFontOfSize:13]];
        [contentLabel setTextAlignment:NSTextAlignmentLeft];
        [contentLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:contentLabel];

        
    }
    return self;
}

- (void)initPolicyResponseTableViewCellWith:(NSString *)title content:(NSString *)contentText
{
    [self.mainTitleLabel setText:title];
     NSString *str = [contentText stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    [self.contentLabel setText:str];
    
    
    self.contentLabel.lineBreakMode=UILineBreakModeWordWrap;
    //设置label最大行
    self.contentLabel.numberOfLines=0;
    //新的尺寸
    //获取cell高度
    CGRect frame=[self frame];
    CGSize size=CGSizeMake(320-30,1000);
    CGSize labelSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+60;
    
    self.frame=frame;

}

- (void)dealloc
{
    self.mainTitleLabel = nil;
    self.contentLabel = nil;
}

@end
