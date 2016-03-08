//
//  QuckClaimsViewController.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
#import "TReptCaseInfo.h" 
@interface QuckClaimsViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
{
    TMemberInfo * currentMemeber;
}
//plist用于接收外部页面传递的参数
@property(nonatomic,retain)  TReptCaseInfo *currentCaseInfo;
@property(nonatomic,strong)NSMutableArray *fieldConfigList;
@property NSString * operType;
@end
