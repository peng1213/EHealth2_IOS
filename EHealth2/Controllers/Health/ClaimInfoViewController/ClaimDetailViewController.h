//
//  ClaimDetailViewController.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TClaimInfo.h"
@interface ClaimDetailViewController  : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UILabel *CLIM_INSURED_NAME_Label;//赔案号
@property (nonatomic, strong) UILabel *CLIM_RETURN_DT_Label;//赔案号
@property (nonatomic, strong) UILabel *SYSV_QUEUE_Label;//状态
@property (nonatomic, strong) UILabel *PSPS_DT_Label;//状态
@property (nonatomic, strong) UILabel *bank;
@property (nonatomic, strong) UILabel *accno;
//plist用于接收外部页面传递的参数
@property(nonatomic,retain)  TClaimInfo *currentClaimInfo;
@end
