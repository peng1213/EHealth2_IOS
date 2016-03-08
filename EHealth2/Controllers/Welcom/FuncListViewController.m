//
//  FuncManageViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/11.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "FuncListViewController.h"
#import "CommonUtil.h"
#import "JsonTool.h"
#import "ConfigTool.h"
#import "Pub.h"
#import "UIImageView+WebCache.h"
#import "FuncTableViewCell.h"

@interface FuncManageViewController ()
{
    NSMutableArray * fastFuncs;
    NSMutableArray * funcs;
}
@property (nonatomic,strong) UITableView *mainTableView;
@end

@implementation FuncManageViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [titleLable setText:@"快捷功能"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    [self initData];
    if(mainTableView==nil){
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, navigationBarView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-navigationBarView.frame.size.height) style:UITableViewStylePlain];
    }
    [mainTableView setRowHeight:50];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:mainTableView];
}

-(void)initData{
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    funcs=[[JsonTool defaultTool] getTFunctionInfoList:cacheString withKey:@"funList"];
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

//tableview的事件
#pragma mark --
#pragma mark --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return funcs.count;
}

//返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    
}


//获取cell的定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    NSUInteger secNum = [indexPath section];
    FuncTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%lu%lu",CellIdentifier,(unsigned long)secNum,(unsigned long)rowNum]];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[FuncTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
        //初始化cell的数据源信息
        [cell setCellValue:funcs[rowNum] ];
    }
    return cell;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuncTableViewCell*cell= [tableView cellForRowAtIndexPath:indexPath];
    [cell checkboxClick:cell.btnChecked];
}


@end
