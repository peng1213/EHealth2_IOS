//
//  QuckClaimsTableViewCell.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuckClaimsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *mainTitleLable;
@property (nonatomic, strong) UILabel *subTitlelable;
@property (nonatomic, strong) UITextField *subTitletext;
@property (nonatomic, strong) UIImageView *rightArrow;
- (void)initQuickClaimsTableCellWithmainTitle:(NSString *)mainTitle
                                     subTitle:(NSString *)subtitle
                                   bshowArrow:(NSString *)bshow;

@end
