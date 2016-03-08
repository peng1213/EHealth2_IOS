//
//  InvoiceListViewController.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDutybaseInfo.h"
@interface InvoiceListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * mlist;
}
@property(nonatomic,retain)  TDutybaseInfo *currentDutybaseInfo;
@end 
