//
//  QuckClaimsTableViewCell.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "QuckClaimsTableViewCell.h"

@implementation QuckClaimsTableViewCell

@synthesize mainTitleLable;
@synthesize subTitlelable;
@synthesize rightArrow;
@synthesize subTitletext;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,44.0)];
        [cellBg setContentMode:UIViewContentModeScaleAspectFill];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        if (self.mainTitleLable == nil) {
            mainTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 9.5, 120.0, 25.0)];
        }
        [mainTitleLable setBackgroundColor:[UIColor clearColor]];
        [mainTitleLable setFont:[UIFont systemFontOfSize:15]];
        [mainTitleLable setTextAlignment:NSTextAlignmentLeft];
        [mainTitleLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:mainTitleLable];
        
        if (self.subTitlelable == nil) {
            subTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-170-32, 9.5, 170.0, 25.0)];
        }
        [subTitlelable setBackgroundColor:[UIColor clearColor]];
        [subTitlelable setFont:[UIFont systemFontOfSize:15]];
        [subTitlelable setTextAlignment:NSTextAlignmentRight];
        [subTitlelable setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:subTitlelable];
        //add by fishpro
        if (self.subTitletext == nil) {
            subTitletext = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width-170-32, 9.5, 170.0, 25.0)];
        }
        [subTitletext setBackgroundColor:[UIColor clearColor]];
        [subTitletext setFont:[UIFont systemFontOfSize:15]];
        [subTitletext setTextAlignment:NSTextAlignmentRight];
        [subTitletext setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:subTitletext];

        
        if (self.rightArrow == nil) {
            rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-32, 11, 22, 22)];
        }
        [rightArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
        [self.contentView addSubview:rightArrow];
        
    }
    return self;
}

- (void)initQuickClaimsTableCellWithmainTitle:(NSString *)mainTitle
                                     subTitle:(NSString *)subtitle
                                   bshowArrow:(NSString *)bshow
{
    if (mainTitle != nil && mainTitle.length > 0) {
        [mainTitleLable setText:mainTitle];
    }
    
    if (subtitle != nil && subtitle.length > 0) {
        [subTitlelable setText:subtitle];
        [subTitletext setPlaceholder:subtitle];
    }
    
    if (bshow != nil && [bshow isEqualToString:@"0"]) {
        [rightArrow setHidden:YES];
    }else if (bshow != nil && [bshow isEqualToString:@"1"]) {
        [rightArrow setHidden:NO];
    }
}

@end
