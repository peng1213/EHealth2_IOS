//
//  PolicyResponseViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "PolicyResponseViewController.h"
#import "Pub.h"
#import "QuckClaimsViewController.h"
#import "PolicyResponseTableViewCell.h"
#import "CommonUtil.h"
#import "HealthViewController.h"

@interface PolicyResponseViewController ()

- (void)backToPreViewController;
-(void)loadData;
@end

@implementation PolicyResponseViewController

//01. 初始化UI界面事件
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置滚动自适应
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
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
    
//        UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 27.0, 30.0, 30.0)];
//        [homeButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_home_icon"] forState:UIControlStateNormal];
//        [homeButton addTarget:self
//                       action:@selector(backToHomeButtonClick)
//             forControlEvents:UIControlEventTouchUpInside];
//        [navigationBarView addSubview:homeButton];
    
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"保障责任"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置表格部分
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,64.0f,self.view.frame.size.width, self.view.frame.size.height-64.0f) style:UITableViewStylePlain];
    [mainTableView setDataSource:self];
    [mainTableView setDelegate:self];
    [mainTableView setRowHeight:70];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[mainTableView setTableHeaderView:tableHeaderView];
    [self.view addSubview:mainTableView];
    
    [self.view insertSubview:navigationBarView aboveSubview:mainTableView];
    //初始化数据
    [self loadData];
    
}
-(void)loadData
{
    //从缓存中获取
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_duty_desc_get];
    NSLog(@"CACHE==================:%@",cacheString);
    mlist=[[JsonTool defaultTool] getTDutyDescList:cacheString withKey:@"dutyDescList"];
    NSLog(@"this count is %i",[mlist count]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToHomeButtonClick
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
    PolicyResponseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[PolicyResponseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TDutyDesc *model=[[TDutyDesc alloc] init];
    model=mlist[rowNum];
    //initPolicyResponseTableViewCellWith
    [cell initPolicyResponseTableViewCellWith:model.DESC_TITLE content:model.DESC_CONTENT ];
    return cell;
}

/**
 * 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PolicyResponseTableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    //return 271;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
