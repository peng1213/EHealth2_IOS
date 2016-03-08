//
//  PolicyInfoListViewController.h
//  citic
//
//  Created by echoliu on 15-4-13.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
@interface PolicyInfoListViewController: UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * mlist;
}
@property TMemberInfo *memeber;
@end
