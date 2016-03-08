//
//  BankListViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "BankListViewController.h"
#import "Pub.h"
#import "QuckClaimsViewController.h"
#import "CommonUtil.h"
#import "BankListTableViewCell.h"
#import "SVProgressHUD.h"
#import "CommonUtil.h"
@interface BankListViewController ()
{
    UITableView *mainTableView;
    UISearchBar *searchBar;
}
- (void)backToPreViewController;
-(void)loadData;
@end

@implementation BankListViewController

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
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"选择银行"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width-60, 40)];
    searchBar.backgroundColor=[UIColor clearColor];
    searchBar.delegate=self;
    [self setReturnKeyType];
    for (UIView *view in searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 64, 60, 40)];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(cancel)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    
    [self.view addSubview:searchBar];
    //设置表格部分
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,104.0f,self.view.frame.size.width, self.view.frame.size.height-104.0f) style:UITableViewStylePlain];
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

-(void)setReturnKeyType{
    //ios7 不用这个有问题
    for (UIView *searchBarSubview in [searchBar subviews]) {
        for (UIView *subView in [searchBarSubview subviews]) {
            if ([subView conformsToProtocol:@protocol(UITextInputTraits)]) {
                @try {
                    [(UITextField *)subView setReturnKeyType:UIReturnKeySearch];
                    //[(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
                }
                @catch (NSException * e) {
                    // ignore exception
                }
            }
        }
    }
}

-(void)cancel
{
    searchBar.text=@"";
    mlist=resultlist;
    [mainTableView reloadData];
    [searchBar resignFirstResponder];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    for (int i=0; i<resultlist.count; i++) {
        TReptBankInfo *bank= (TReptBankInfo*)resultlist[i];
        if([CommonUtil contains:bank.BANK_NAME conStr:searchBar.text])
        {
            [temp addObject:bank];
        }
    }
    mlist=temp;
    [mainTableView reloadData];
    NSLog(@"searchBarTextDidEndEditing");
}

-(void)loadData
{
    //从缓存中获取
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    TUserInfo *userModel=[[JsonTool defaultTool] getTUserInfoEntity:cacheString withKey:@"model"];
    
    NSURL *url =[ NSURL URLWithString : api_bank_list];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    //获取全局变量
    [request setPostValue:userModel.COMP_ID forKey: @"COMP_ID"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60.0f];
    [request startAsynchronous];//异步请求
    [SVProgressHUD show];
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [SVProgressHUD dismiss];
    [self.navigationController.view makeToast:[NSString stringWithFormat:@"读取报案列表错误！"]];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"mlist count:%@",request.responseString);
    //如果返回成功显示
    if (result.ResultCode==0)
    {
        resultlist=[[JsonTool defaultTool] getTReptBankInfoList:request.responseString withKey:@"model"];
        mlist=resultlist;
        [mainTableView reloadData];
    }
    
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
    BankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BankListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TReptBankInfo *model=[[TReptBankInfo alloc] init];
    model=mlist[rowNum];
    
    [cell initListTableCellWith:model.BANK_NAME
                      mainTitle:model.BANK_NAME
                       subTitle:model.BANK_CODE];
    
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //观察者模式 可以匹配任何弹出页面
    TReptBankInfo *paperModel = mlist[indexPath.row];
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:paperModel
                                                         forKey:@"popitemname"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterBankNotification"
     object:nil
     userInfo:dataDict];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
