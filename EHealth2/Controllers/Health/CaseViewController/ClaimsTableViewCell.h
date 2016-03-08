//
//  ClaimsTableViewCell.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimsTableViewCell : UITableViewCell
//一个图片两个标签的cell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *mainTitleLable;
@property (nonatomic, strong) UILabel *subTitlelable;

- (void)initClaimsTableCellWith:(NSString *)iconName
                      mainTitle:(NSString *)mainTitle
                       subTitle:(NSString *)subtitle;

@end
