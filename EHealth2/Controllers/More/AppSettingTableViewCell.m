//
//  AppSettingTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/30.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "AppSettingTableViewCell.h"

@implementation AppSettingTableViewCell
@synthesize mainTitleLabel;
@synthesize rightArrowIcon;
@synthesize cellBg;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (self.cellBg == nil) {
            cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,40.0)];
        }
        [cellBg setContentMode:UIViewContentModeScaleAspectFill];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        if (self.mainTitleLabel == nil) {
            mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 7.5, 150.0, 25.0)];
        }
        [mainTitleLabel setBackgroundColor:[UIColor clearColor]];
        [mainTitleLabel setFont:[UIFont systemFontOfSize:18]];
        [mainTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [mainTitleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:mainTitleLabel];
        
        if (self.rightArrowIcon == nil) {
            rightArrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-32, 9, 22, 22)];
        }
        [rightArrowIcon setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
        [self.contentView addSubview:rightArrowIcon];
    }
    return self;
}

- (void)dealloc
{
    self.cellBg = nil;
    self.mainTitleLabel = nil;
    self.rightArrowIcon = nil;
}

@end
