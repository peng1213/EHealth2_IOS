//
//  ClaimReportListViewController.h
//  EhealthClient
//
//  Created by jiaojunkang on 15-4-27.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMemberInfo.h"
#import "TPolicyInfo.h"
#import "TClaimReportInfo.h"
@interface ClaimReportListViewController : UIViewController
{
    
    NSMutableArray * mlist;
}

- (NSString *)stringFormDict:(NSDictionary*)dict;
@property (weak, nonatomic) IBOutlet UISegmentedControl *RrptTypeSegment;
- (IBAction)RptTypeSegmentChange:(id)sender;
-(void)reloadReportData:(NSString*) rpttype;

@property (nonatomic, strong) TMemberInfo   *currentMember;
@property (nonatomic, strong) TPolicyInfo   *currentPolicy;
@property (nonatomic,strong) NSString *REPORT_TYPE;
@property (nonatomic, strong) TClaimReportInfo   *currentReport;
@property (weak, nonatomic) IBOutlet UILabel *CREATE_DT_Label;

@property (weak, nonatomic) IBOutlet UIButton *QUERY_BTN;
@property (weak, nonatomic) IBOutlet UILabel *FILE_SIZE_Label;
@property (weak, nonatomic) IBOutlet UILabel *FILE_TYPE_Label;
- (IBAction)btnQueryClick:(id)sender;
-(void) initViewData:(TClaimReportInfo *) rpt;
@end
