//
//  ClaimsTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ClaimsTableViewCell.h"

@implementation ClaimsTableViewCell
@synthesize icon;
@synthesize mainTitleLable;
@synthesize subTitlelable;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,70.0)];
        [cellBg setContentMode:UIViewContentModeScaleAspectFill];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        if (self.icon == nil) {
            icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        }
        [icon setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:icon];
        
        if (self.mainTitleLable == nil) {
            mainTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 10, 150.0, 25.0)];
        }
        [mainTitleLable setBackgroundColor:[UIColor clearColor]];
        [mainTitleLable setFont:[UIFont systemFontOfSize:18]];
        [mainTitleLable setTextAlignment:NSTextAlignmentLeft];
        [mainTitleLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:mainTitleLable];
        
        if (self.subTitlelable == nil) {
            subTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 35, 250.0, 25.0)];
        }
        [subTitlelable setBackgroundColor:[UIColor clearColor]];
        [subTitlelable setFont:[UIFont systemFontOfSize:13]];
        [subTitlelable setTextAlignment:NSTextAlignmentLeft];
        [subTitlelable setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:subTitlelable];
        
    }
    return self;
}

- (void)initClaimsTableCellWith:(NSString *)iconName mainTitle:(NSString *)mainTitle subTitle:(NSString *)subtitle
{
    if (iconName != nil && iconName.length > 0) {
        [icon setImage:[UIImage imageNamed:iconName]];
    }
    
    if (mainTitle != nil && mainTitle.length > 0) {
        [mainTitleLable setText:mainTitle];
    }
    
    if (subtitle != nil && subtitle.length > 0) {
        [subTitlelable setText:subtitle];
    }
}

- (void)dealloc
{
    self.icon = nil;
    self.mainTitleLable = nil;
    self.subTitlelable = nil;
}

@end
