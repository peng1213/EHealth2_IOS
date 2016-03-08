//
//  ClaimsViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ClaimsViewController.h"
#import "ClaimsTableViewCell.h"
#import "QuckClaimsViewController.h"
#import "CommonUtil.h"
#import "MyCaseViewController.h"
#import "PolicyInfoViewController.h"
#import "QueryClaimsViewController.h"

//定义常量
static NSString *liestAarray[3][3] ={{@"claims_case_icon.png",@"我的案件",@"自助报案未完成/未通过/待初审的案件查询"}};
//,
//    {@"claims_policy_icon.png",@"保单信息",@"保单信息查询"},
//    {@"claims_query_icon.png",@"理赔查询",@"所有/处理中/已结案/已退案件进度查询"}};

@interface ClaimsViewController ()
- (void)backToPreViewController;

@end

@implementation ClaimsViewController

//01. 初始化UI界面事件
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置滚动自适应
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    //设置被颜色
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    //设置导航View
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationBarView];
    //设置返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"自助理赔"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置表格头图片
    UIImageView *tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 202)];
    [tableHeaderView setImage:[UIImage imageNamed:@"clamis_headview_bg.png"]];
    [tableHeaderView setUserInteractionEnabled:YES];
    //设置理赔按钮 快速报案
    UIButton *claimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-160)/2.0, 142, 160, 40.0)];
    [claimsButton setBackgroundImage:[UIImage imageNamed:@"claims_button_bg.png"] forState:UIControlStateNormal];
    [claimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [claimsButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [claimsButton setTitle:@"快速报案" forState:UIControlStateNormal];
    [claimsButton addTarget:self
                     action:@selector(claimsButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:claimsButton];
    //设置表格部分
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [mainTableView setDataSource:self];
    [mainTableView setDelegate:self];
    [mainTableView setRowHeight:70];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setTableHeaderView:tableHeaderView];
    [self.view addSubview:mainTableView];
    
    [self.view insertSubview:navigationBarView aboveSubview:mainTableView];
    
}
//02.快速理赔界面跳转
- (void)claimsButtonClick
{
    QuckClaimsViewController *quckClaimsViewController = [[QuckClaimsViewController alloc] init];
    [self.navigationController pushViewController:quckClaimsViewController animated:YES];
}
//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

//03.表格相关事件
#pragma mark --
#pragma mark -- UITableViewDelegate UITableViewDataSource
//表格分组事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//表格最大行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//单元格cell初始化
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    //注意这里自定义了Cell
    ClaimsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[ClaimsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    [cell initClaimsTableCellWith:liestAarray[rowNum][0]
                        mainTitle:liestAarray[rowNum][1]
                         subTitle:liestAarray[rowNum][2]];
    
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = [indexPath row];
    if (rowNum == 0) {
        //我的案件
        MyCaseViewController *mycaseViewController = [[MyCaseViewController alloc] init];
        [self.navigationController pushViewController:mycaseViewController animated:YES];
    }else if (rowNum == 1) {
        //保单信息
        PolicyInfoViewController *policyViewController = [[PolicyInfoViewController alloc] init];
        [self.navigationController pushViewController:policyViewController animated:YES];
    }else if (rowNum == 2) {
        //理赔查询
        QueryClaimsViewController *queryClaimsViewController = [[QueryClaimsViewController alloc] init];
        [self.navigationController pushViewController:queryClaimsViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end
