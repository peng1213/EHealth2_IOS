//
//  PolicyInfoListTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-13.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "PolicyInfoListTableViewCell.h"

@implementation PolicyInfoListTableViewCell
@synthesize mainTitleLable;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,50)];
        [cellBg setContentMode:UIViewContentModeScaleAspectFill];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        if (self.mainTitleLable == nil) {
            mainTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 18.5, self.frame.size.width, 15.0)];
        }
        [mainTitleLable setBackgroundColor:[UIColor clearColor]];
        [mainTitleLable setFont:[UIFont systemFontOfSize:18]];
        [mainTitleLable setTextAlignment:NSTextAlignmentCenter];
        [mainTitleLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:mainTitleLable];

    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)initListTableCellWith:(NSString *)mainTitle
{

    if (mainTitle != nil && mainTitle.length > 0) {
        [mainTitleLable setText:mainTitle];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{

    self.mainTitleLable = nil;
}

@end
