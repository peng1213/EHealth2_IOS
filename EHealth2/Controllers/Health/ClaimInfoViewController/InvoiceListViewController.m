//
//  InvoiceListViewController.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "InvoiceListViewController.h"
#import "Pub.h"
#import "QuckClaimsViewController.h"
#import "InvoiceListTableViewCell.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "ImageListViewController.h"
#import "ImageShowViewController.h"


@interface InvoiceListViewController ()
{
    ASIFormDataRequest *request1;
    ASIFormDataRequest *request2;
    UITableView *mainTableView ;
}
- (void)backToPreViewController;
-(void)loadData;
@end

@implementation InvoiceListViewController
@synthesize  currentDutybaseInfo;

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
    [titleLable setText:@"发票信息"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置表格部分
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,64.0f,self.view.frame.size.width, self.view.frame.size.height-64.0f) style:UITableViewStylePlain];
    [mainTableView setDataSource:self];
    [mainTableView setDelegate:self];
    [mainTableView setRowHeight:70];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    //[mainTableView setTableHeaderView:tableHeaderView];
    [self.view addSubview:mainTableView];
    
    [self.view insertSubview:navigationBarView aboveSubview:mainTableView];
    //初始化数据
    [self loadData];
    
}
-(void)loadData
{
    //从缓存中获取
    //采用ASIHttp框架来实现
    NSURL *url =[NSURL URLWithString:api_cliv_baseinfo_get];
    request1 =[ASIFormDataRequest requestWithURL:url];
    [request1 setPostValue: currentDutybaseInfo.CLIM_KY forKey: @"CLIM_KY"];
    [request1 setPostValue: currentDutybaseInfo.GETDUTY_CD forKey: @"GETDUTY_CD"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request1 setPostValue: appDelegate.token forKey: @"token"];
    [request1 setPostValue: appDelegate.COMP_ID forKey: @"COMP_ID"];
    [request1 setRequestMethod:@"POST"];
    [request1 buildPostBody];
    [request1 setDelegate:self];
    [request1 setTimeOutSeconds:60.0f];
    [request1 startAsynchronous];
    [SVProgressHUD show];
    
}


/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"请检查网络！"];
    [SVProgressHUD dismiss];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    //清除历史缓存
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(request==request1)
    {
    if(model.ResultCode==0 ){
        mlist=[[JsonTool defaultTool] getTClivbaseInfoList:request.responseString withKey:@"clivList"];
        [mainTableView reloadData];
        
    }else{
        
        [self.navigationController.view makeToast:model.ResultDesc];
    }
    }
    else if (request==request2)
    {
        if(model.ResultCode==0 ){
            TImgInfo* img=[[JsonTool defaultTool] getTImgInfo:request.responseString withKey:@"imgList"];
                ImageShowViewController *imgView = [[ImageShowViewController alloc] init];
                
            imgView.imageURL=[[NSURL alloc]initWithString:img.IMG_PATH];
                [self.navigationController pushViewController:imgView animated:YES];
            
        }else{
            
            [self.navigationController.view makeToast:model.ResultDesc];
        }

    }
}
/*ASIHttp异步请求 结束*/


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
    InvoiceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[InvoiceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TClivbaseInfo *model=[[TClivbaseInfo alloc] init];
    model=mlist[rowNum];
    [cell setCellValue:model ];
    return cell;
}

/**
 * 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 212.5;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = [indexPath row];
    TClivbaseInfo *paperModel = mlist[rowNum];
    NSURL *url =[NSURL URLWithString:api_img_get];
    request2 =[ASIFormDataRequest requestWithURL:url];
    [request2 setPostValue: 0 forKey: @"CLIM_KY"];
    [request2 setPostValue: paperModel.IMG_KY forKey: @"IMG_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request2 setPostValue: appDelegate.token forKey: @"token"];
    [request2 setPostValue: appDelegate.COMP_ID forKey: @"COMP_ID"];
    [request2 setRequestMethod:@"POST"];
    [request2 buildPostBody];
    [request2 setDelegate:self];
    [request2 setTimeOutSeconds:60.0f];
    [request2 startAsynchronous];
    [SVProgressHUD show];
    

}


@end
