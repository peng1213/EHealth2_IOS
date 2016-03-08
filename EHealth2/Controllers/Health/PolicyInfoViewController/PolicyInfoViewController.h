//
//  PolicyInfoViewController.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
#import "TPolicyInfo.h"
@interface PolicyInfoViewController : UIViewController
{
    TMemberInfo * currentMemeber;
    TPolicyInfo * currentTPolicyInfo;
}
@end
