//
//  ReviewDescViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/9/2.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "ReviewDescViewController.h"
#import "CommonUtil.h"
#import "QuckClaimsViewController.h"

@interface ReviewDescViewController ()

@end

@implementation ReviewDescViewController
@synthesize caseInfo;
@synthesize fieldConfigList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条的View
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    //设置导航View上的返回按钮 定义事件为backToPreViewController
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置导航View上的标题 快速报案
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"初审信息"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    [self.view setBackgroundColor:[CommonUtil getColor:@"EFEEEB" withAlpha:1.0]];
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    [icon setImage:[UIImage imageNamed:@"ic_notice"]];
    [icon setContentMode:UIViewContentModeCenter];
    [self.view addSubview:icon];
    
    UILabel * reviewTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 20)];
    [reviewTitle setTextAlignment:NSTextAlignmentCenter];
    [reviewTitle setTextColor:[CommonUtil getColor:@"808080" withAlpha:1]];
    [reviewTitle setFont:[UIFont systemFontOfSize:18]];
    [reviewTitle setText:@"抱歉！您的报案未通过初审！"];
    [self.view addSubview:reviewTitle];
    
    UILabel * reasonTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 20)];
    [reasonTitle setTextAlignment:NSTextAlignmentCenter];
    [reasonTitle setTextColor:[CommonUtil getColor:@"808080" withAlpha:1]];
    [reasonTitle setText:@"失败原因："];
    [reasonTitle setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:reasonTitle];
    
    UILabel * reason=[[UILabel alloc]initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, 80)];
    [reason setTextAlignment:NSTextAlignmentCenter];
    [reason setTextColor:[UIColor redColor]];
    [reason setText:caseInfo.REPT_REVIEW_COMMENT];
    reason.numberOfLines = 0;
    [reason setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:reason];
    
    UILabel * notice=[[UILabel alloc]initWithFrame:CGRectMake(20, 340, self.view.frame.size.width-20, 40)];
    [notice setTextAlignment:NSTextAlignmentCenter];
    [notice setTextColor:[CommonUtil getColor:@"808080" withAlpha:1]];
    [notice setFont:[UIFont systemFontOfSize:12]];
    [notice setText:@"您还可以根据失败原因修改报案信息"];
    [self.view addSubview:notice];
    
    UIButton *editButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 380, self.view.frame.size.width-40, 40)];
    
    [editButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editButton setTitle:@"修改报案" forState:UIControlStateNormal];
    [editButton addTarget:self
                        action:@selector(editReport)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
    // Do any additional setup after loading the view.
}

-(void)editReport
{
    QuckClaimsViewController *vc=[[QuckClaimsViewController alloc]init];
    [vc setCurrentCaseInfo:caseInfo];
    [vc setFieldConfigList:fieldConfigList];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
