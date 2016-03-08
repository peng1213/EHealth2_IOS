//
//  BankListTableViewCell.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *mainTitleLable;
@property (nonatomic, strong) UILabel *subTitlelable;

- (void)initListTableCellWith:(NSString *)iconName
                    mainTitle:(NSString *)mainTitle
                     subTitle:(NSString *)subtitle;


@end
