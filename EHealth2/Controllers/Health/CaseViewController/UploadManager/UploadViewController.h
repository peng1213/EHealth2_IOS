//
//  UploadViewController.h
//  EHealth2
//
//  Created by 刘祯 on 15/12/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptCaseInfo.h"
@interface UploadViewController : UIViewController
@property NSString *operType;
@property BOOL *editing;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TReptCaseInfo *currentCaseInfo;
@end
