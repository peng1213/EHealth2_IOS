//
//  MemeListTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-8.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemeListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *mainTitleLable;
@property (nonatomic, strong) UILabel *subTitlelable;

- (void)initListTableCellWith:(NSString *)iconName
                      mainTitle:(NSString *)mainTitle
                       subTitle:(NSString *)subtitle;
@end
