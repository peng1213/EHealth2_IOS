//
//  PolicyInfoListTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-13.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyInfoListTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *mainTitleLable;


- (void)initListTableCellWith:(NSString *)mainTitle;

@end
