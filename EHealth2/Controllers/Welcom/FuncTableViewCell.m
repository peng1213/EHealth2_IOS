//
//  FuncTableViewCell.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/11.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "FuncTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FuncTableViewCell
{
    NSString * pvKY;
}
@synthesize btnChecked;
@synthesize icon;
@synthesize funcName;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 50)];
        [cellBg setImage:[UIImage imageNamed:@"common_cell_bg"]];
        [self.contentView addSubview:cellBg];

        if (self.icon == nil) {
            icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 9, 32, 32)];
        }
        if (self.btnChecked == nil) {
            
            btnChecked = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-52, 9, 30, 30)];
            [btnChecked setContentMode:UIViewContentModeScaleAspectFit];
            [btnChecked setImage:[UIImage imageNamed:@"comon_checkbox_default"]forState:UIControlStateNormal];
            [btnChecked setImage:[UIImage imageNamed:@"comon_checkbox_focused"]forState:UIControlStateSelected];
            [btnChecked addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (self.funcName == nil) {
            funcName = [[UILabel alloc] initWithFrame:CGRectMake(72, 9, 150, 32)];
            [funcName setTextAlignment:NSTextAlignmentLeft];
        }
        [self.contentView addSubview:icon];
        [self.contentView addSubview:btnChecked];
        [self.contentView addSubview:funcName];
    }
    return self;
}

-(void)checkboxClick:(UIButton*)btn{
    btn.selected=!btn.selected;//每次点击都改变按钮的状态
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSArray* array= [defaults objectForKey:@"fastFuncs"];
    NSMutableArray *mArray=[array mutableCopy];
    if(btn.selected)
    {
        [mArray addObject:pvKY];
    }
    else
    {
        for (int i=0; i<mArray.count; i++) {
            if([[mArray objectAtIndex:i] isEqualToString:pvKY])
            {
                [mArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    array=[mArray copy];
    [defaults setObject:array forKey:@"fastFuncs"];
}

-(void)setCellValue:(TFunctionInfo *)model
{
    [funcName setText:model.FUNC_NAME];
    pvKY=model.PV_KY;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSArray* array= [defaults objectForKey:@"fastFuncs"];
    BOOL checked=NO;
    for (NSString *pvKY in array) {
        if([pvKY isEqualToString:model.PV_KY])
        {
            checked=YES;
            break;
        }
    }
    [btnChecked setSelected:checked];
    [icon sd_setImageWithURL:[NSURL URLWithString:model.FUNC_ICON]];
}


- (void)dealloc
{
    self.funcName = nil;
    self.btnChecked = nil;
    self.icon = nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
