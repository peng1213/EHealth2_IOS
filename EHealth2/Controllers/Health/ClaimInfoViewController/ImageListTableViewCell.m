//
//  ImageListTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ImageListTableViewCell.h"

@implementation ImageListTableViewCell
@synthesize IMG_NAME;
@synthesize IMG_TYPE_DESC;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 35.0)];
        [cellBg setImage:[UIImage imageNamed:@"mycase_cell_bg.png"]];
        [self.contentView addSubview:cellBg];
        
        //第一行
        
        if (self.IMG_NAME == nil) {
            IMG_NAME = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 150, 20)];
        }
        [IMG_NAME setTextAlignment:NSTextAlignmentLeft];
        [IMG_NAME setFont:[UIFont systemFontOfSize:13]];
        [IMG_NAME setText:@"0000"];
        [IMG_NAME setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:IMG_NAME];
        
        
        
        
        
        if (self.IMG_TYPE_DESC == nil) {
            IMG_TYPE_DESC = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 20)];
        }
        [IMG_TYPE_DESC setFont:[UIFont systemFontOfSize:13]];
        [IMG_TYPE_DESC setTextColor:[UIColor blackColor]];
        [IMG_TYPE_DESC setText:@"暂无"];
        [self.contentView addSubview:IMG_TYPE_DESC];
        
        
        
    }
    return self;
}

-(void)setCellValue:(TImgInfo *)model
{
    self.IMG_NAME.text=model.IMG_NAME;
    self.IMG_TYPE_DESC.text=model.IMG_TYPE_DESC;
}


- (void)dealloc
{
    self.IMG_NAME = nil;
    self.IMG_TYPE_DESC = nil;
    
}

@end
