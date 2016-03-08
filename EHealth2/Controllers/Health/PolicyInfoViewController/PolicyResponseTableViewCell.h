//
//  PolicyResponseTableViewCell.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyResponseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)initPolicyResponseTableViewCellWith:(NSString *)title content:(NSString *)contentText;

@end
