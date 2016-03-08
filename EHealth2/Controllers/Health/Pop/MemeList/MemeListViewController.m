//
//  MemeListViewController.m
//  citic
//
//  Created by echoliu on 15-4-8.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//
#import "Pub.h"
#import "MemeListViewController.h"
#import "QuckClaimsViewController.h"
#import "CommonUtil.h"
#import "MemeListTableViewCell.h"
@interface MemeListViewController ()
- (void)backToPreViewController;
-(void)loadData;
@end


@implementation MemeListViewController


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
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"选择人员"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
        //设置表格部分
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,64.0f,self.view.frame.size.width, self.view.frame.size.height-64.0f) style:UITableViewStylePlain];
    [mainTableView setDataSource:self];
    [mainTableView setDelegate:self];
    [mainTableView setRowHeight:50];
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
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    NSLog(@"CACHE==================:%@",cacheString);
    mlist=[[JsonTool defaultTool] getTMemberInfoList:cacheString withKey:@"relationList"];
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
    MemeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[MemeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TMemberInfo *model=[[TMemberInfo alloc] init];
    model=mlist[rowNum];
    
    [cell initListTableCellWith:model.MEME_NAME
                        mainTitle:model.MEME_NAME
                         subTitle:model.MEME_RELATION_DESC];
    
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //观察者模式 可以匹配任何弹出页面
    NSUInteger rowNum = [indexPath row];
    TMemberInfo *paperModel = mlist[indexPath.row];
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:paperModel
                                                         forKey:@"popitemname"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterCompletionNotification"
     object:nil
     userInfo:dataDict];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
