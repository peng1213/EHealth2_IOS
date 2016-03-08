//
//  HelpItemViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/12.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "HelpItemViewController.h"
#import "ConfigTool.h"
#import "JsonTool.h"
#import "Pub.h"
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "HelpDescViewController.h"

@interface HelpItemViewController ()

@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, retain) UITableView *table;
@end

@implementation HelpItemViewController
@synthesize dataList;
@synthesize table;
@synthesize navTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,10.0f,self.view.frame.size.width-80,64.0f)];
    [titleLable setText:navTitle];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    [self loadData];
}

-(void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)loadData
{
    NSURL *url =[NSURL URLWithString:api_help_item_get];
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
    [request setPostValue: navTitle forKey: @"NAV_TITLE"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request startAsynchronous];
    //显示进度滚动
    [SVProgressHUD show];
}

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [SVProgressHUD dismiss];
    NSLog(request.error.description);
    [self.navigationController.view makeToast:[NSString stringWithFormat:@"网络异常！"]];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSMutableArray * navList=[[NSMutableArray alloc]init];
    navList=[[JsonTool defaultTool] getHelpItemList:request.responseString withKey:@"model"];
    dataList=[navList copy];
    [table reloadData];
    [SVProgressHUD dismiss];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    cell.textLabel.text = [(HelpInfo*)[self.dataList objectAtIndex:row] HELP_TITLE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpDescViewController *vc=[[HelpDescViewController alloc]init];
    vc.HELP_TITLE=[(HelpInfo*)[dataList objectAtIndex:indexPath.row] HELP_TITLE];
    vc.nID=[(HelpInfo*)[dataList objectAtIndex:indexPath.row] ID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
