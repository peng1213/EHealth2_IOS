//
//  BankListTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "BankListTableViewCell.h"

@implementation BankListTableViewCell
@synthesize icon;
@synthesize mainTitleLable;
@synthesize subTitlelable;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,50.0)];
        [cellBg setContentMode:UIViewContentModeScaleAspectFill];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        if (self.icon == nil) {
            icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        }
        [icon setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:icon];
        
        if (self.mainTitleLable == nil) {
            mainTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 12.5f, cellBg.frame.size.width-20, 25.0)];
        }
        [mainTitleLable setBackgroundColor:[UIColor clearColor]];
        [mainTitleLable setFont:[UIFont systemFontOfSize:13]];
        [mainTitleLable setTextAlignment:NSTextAlignmentLeft];
        [mainTitleLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:mainTitleLable];
        
        if (self.subTitlelable == nil) {
            subTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(cellBg.frame.size.width-100, 12.5f, 100.0f, 25.0f)];
        }
        [subTitlelable setBackgroundColor:[UIColor clearColor]];
        [subTitlelable setFont:[UIFont systemFontOfSize:13]];
        [subTitlelable setTextAlignment:NSTextAlignmentLeft];
        [subTitlelable setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:subTitlelable];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)initListTableCellWith:(NSString *)iconName mainTitle:(NSString *)mainTitle subTitle:(NSString *)subtitle
{
    if (iconName != nil && iconName.length > 0) {
        [icon setImage:[UIImage imageNamed:iconName]];
    }
    
    if (mainTitle != nil && mainTitle.length > 0) {
        [mainTitleLable setText:mainTitle];
    }
    
    if (subtitle != nil && subtitle.length > 0) {
        [subTitlelable setText:@""];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self.icon = nil;
    self.mainTitleLable = nil;
    self.subTitlelable = nil;
}

@end
