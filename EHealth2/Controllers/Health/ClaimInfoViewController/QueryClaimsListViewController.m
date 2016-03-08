//
//  QueryClaimsListViewController.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QueryClaimsListViewController.h"
#import "Pub.h"
#import "MyCaseViewController.h"
#import "CommonUtil.h"
#import "MyCaseTableViewCell.h"
#import "QueryClaimsListTableViewCell.h"
#import "TClaimInfo.h"
#import "ClaimDetailViewController.h"
#import "HealthViewController.h"

@interface QueryClaimsListViewController ()
{
    //未完成列表
    NSMutableArray * mlist;
}
- (void)backToPreViewController;
- (void)homeCaseButtonClick;
//by fishpro
-(void )reloadData;
@end

@implementation QueryClaimsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"理赔列表"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 27.0, 30.0, 30.0)];
    //    [homeButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_home_icon"] forState:UIControlStateNormal];
    //    [homeButton addTarget:self
    //                   action:@selector(homeCaseButtonClick)
    //         forControlEvents:UIControlEventTouchUpInside];
    //    [navigationBarView addSubview:homeButton];
    
    //设置表格部分
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,64.0f,self.view.frame.size.width, self.view.frame.size.height-64.0f) style:UITableViewStylePlain];
    [mainTableView setDataSource:self];
    [mainTableView setDelegate:self];
    [mainTableView setRowHeight:70];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    //[mainTableView setTableHeaderView:tableHeaderView];
    [self.view addSubview:mainTableView];
    
    //test data
    [self reloadData];
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)homeCaseButtonClick
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HealthViewController class]]) {
            [self.navigationController popToViewController:controller
                                                  animated:YES];
        }
    }
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
    return [mlist count];
}

//单元格cell初始化
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    //注意这里自定义了Cell
    QueryClaimsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[QueryClaimsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TClaimInfo *model=[[TClaimInfo alloc] init];
    model=mlist[rowNum];
    [cell setCellValue:model];
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //观察者模式 可以匹配任何弹出页面
    NSUInteger rowNum = [indexPath row];
    TClaimInfo *paperModel = mlist[rowNum];
    if([paperModel.SYSV_QUEUE isEqualToString:@"处理中"])
    {
        [self.navigationController.view makeToast:@"案件处理中，请耐心等候！"];
    }
    else
    {
        ClaimDetailViewController *claimView=[[ClaimDetailViewController alloc]init];
        [claimView setCurrentClaimInfo:paperModel];
        [self.navigationController pushViewController:claimView animated:YES];
    }
}

/**
 * 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

//加载数据
-(void)reloadData{
    //从缓存中获取
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_claim_get];
    NSLog(@"CACHE==================:%@",cacheString);
    mlist=[[JsonTool defaultTool] getTClaimInfoList:cacheString withKey:@"claimList"];
    NSLog(@"this count is %i",[mlist count]);
    
}


- (void)dealloc
{
    
}

@end
