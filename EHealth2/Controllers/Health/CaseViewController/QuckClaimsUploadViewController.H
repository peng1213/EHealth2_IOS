//
//  QuckClaimsUploadViewController.h
//  citic
//
//  Created by echoliu on 15-4-9.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptCaseInfo.h"

@interface QuckClaimsUploadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property NSString *operType;
@property (nonatomic, strong) TReptCaseInfo *currentCaseInfo;
@end
