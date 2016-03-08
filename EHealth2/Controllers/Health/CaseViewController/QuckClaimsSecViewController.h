//
//  QuckClaimsSecViewController.h
//  citic
//
//  Created by echoliu on 15-4-9.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
#import "TReptCaseInfo.h"
#import "TReptBankInfo.h"


@interface QuckClaimsSecViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
{
    TMemberInfo * currentMemeber;
}
@property NSString * operType;
@property (nonatomic, strong) TReptCaseInfo *currentCaseInfo;
@property NSMutableArray* fieldConfigList;
@end
