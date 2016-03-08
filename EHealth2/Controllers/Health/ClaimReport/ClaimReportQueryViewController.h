//
//  ClaimReportQueryViewController.h
//  EhealthClient
//
//  Created by jiaojunkang on 15-4-27.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
#import "TPolicyInfo.h"

@interface ClaimReportQueryViewController : UIViewController
{
    
    TMemberInfo * currentModel;
    TPolicyInfo * currentPolicy;
}
@property (weak, nonatomic) IBOutlet UILabel *USUS_NAME_Label;
@property (weak, nonatomic) IBOutlet UILabel *PLPL_ID_Label;
@property (weak, nonatomic) IBOutlet UIButton *QUERY_Button;
- (IBAction)btnQuery:(id)sender;
- (IBAction)btnSelectUSUS:(id)sender;
- (IBAction)btnSelectPLPL:(id)sender;

@end
