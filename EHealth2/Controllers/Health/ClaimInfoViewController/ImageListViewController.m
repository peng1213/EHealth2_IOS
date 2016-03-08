//
//  ImageListViewController.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ImageListViewController.h"
#import "Pub.h"
#import "QuckClaimsViewController.h"
#import "ImageListTableViewCell.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "TReptImgInfo.h"
#import "ImageShowViewController.h"

@interface ImageListViewController ()
- (void)backToPreViewController;
-(void)loadData;
@end

@implementation ImageListViewController
@synthesize CLIM_KY;
@synthesize IMG_KY;

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
    [titleLable setText:@"赔案影像"];
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
    //采用ASIHttp框架来实现
    NSURL *url =[NSURL URLWithString:api_img_get];
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
    [request setPostValue: CLIM_KY forKey: @"CLIM_KY"];
    [request setPostValue: IMG_KY forKey: @"IMG_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.COMP_ID forKey: @"COMP_ID"];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60.0f];
    [request startSynchronous];
    //显示进度滚动
    mlist=[[JsonTool defaultTool] getTImgInfoList:request.responseString withKey:@"imgList"];
    
}


/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"请检查网络！"];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    //清除历史缓存
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        NSLog(@"登陆成功，跳转到tab页面");
        mlist=[[JsonTool defaultTool] getTClivbaseInfoList:request.responseString withKey:@"clivList"];
        
        //获取TUSERINFO对象
        //取消等等框并提示
        [SVProgressHUD dismiss];
        
    }else{
        
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
        NSLog(@"登陆失败，请检查用户名与密码是否正确");
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
    ImageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[ImageListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TImgInfo *model=[[TImgInfo alloc] init];
    model=mlist[rowNum];
    [cell setCellValue:model ];
    return cell;
}

/**
 * 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    //return 271;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = [indexPath row];
    TImgInfo *paperModel = mlist[rowNum];
    ImageShowViewController *cellView=[[ImageShowViewController alloc]init];
   // [cellView setImageModel:paperModel];
    cellView.imageURL=[[NSURL alloc]initWithString:paperModel.IMG_PATH];
//    [cellView setIMAGE_PATH:paperModel.IMG_PATH];
//    [cellView setFRM:@"CLIM"];
    [self.navigationController pushViewController:cellView animated:YES];

}


@end