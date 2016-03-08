//
//  MyCaseViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//
#import "Pub.h"
#import "MyCaseViewController.h"
#import "CommonUtil.h"
#import "MyCaseTableViewCell.h"
#import "QuckClaimsViewController.h"
#import "TReptCaseInfo.h"
#import "HealthViewController.h"
#import "SVProgressHUD.h"
#import "ReviewDescViewController.h"

@interface MyCaseViewController ()
{
    NSMutableArray * mlist;
    int _dataType;
    int _reportKY;
    NSMutableArray *fieldConfigList;
}
@property (nonatomic,strong) UITableView *mainTableView;
- (void)backToPreViewController;
- (void)homeCaseButtonClick;
- (void)segmentAction:(UISegmentedControl *)segment;
//by fishpro
-(void )reloadData:(int ) datatype;
@end

@implementation MyCaseViewController
@synthesize mainTableView;
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
    [titleLable setText:@"我的案件"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.frame.size.width, 70.0)];
    [topImageView setImage:[UIImage imageNamed:@"mycase_topview_bg.png"]];
    [topImageView setUserInteractionEnabled:YES];
    [self.view addSubview:topImageView];
    
    //初始化SegmentedControl 注意最后一个是nil
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"全部",@"未完成",@"已完成",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake((self.view.frame.size.width-250)/2.0, 15.0, 250.0,30.0);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    segmentedControl.tintColor = [CommonUtil getColor:@"519CEA" withAlpha:1.0];
    [segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
    [topImageView addSubview:segmentedControl];
    
    UILabel *comment=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-250)/2.0, 55, 250, 10)];
    comment.text=@"向左滑动可删除未完成报案";
    comment.textAlignment=UITextAlignmentCenter;
    comment.textColor=[UIColor grayColor];
    comment.font=[UIFont systemFontOfSize:10];
    [topImageView addSubview:comment];
    //[topImageView]
    //初始化表格
    if(mainTableView==nil){
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, topImageView.frame.origin.y+topImageView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(topImageView.frame.origin.y+topImageView.frame.size.height)-50) style:UITableViewStylePlain];
    }
    [mainTableView setRowHeight:70];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:mainTableView];
    //初始化底部的按钮
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height - 50),self.view.frame.size.width,50)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [self.view addSubview:bottomView];
    
    UIButton *quckClaimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2.0, 7.5, 140, 35)];
    [quckClaimsButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [quckClaimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quckClaimsButton setTitle:@"快速报案" forState:UIControlStateNormal];
    [quckClaimsButton addTarget:self
                         action:@selector(claimsButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:quckClaimsButton];
    
    //test data
    [self reloadData:0];
    
    //建立通知消息机制
    
    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerMyCaseCompletion:)
                                                 name:@"RegisterMyCaseNotification"
                                               object:nil];
    
}

-(void)registerMyCaseCompletion:(NSNotification*)notification
{
    [self reloadData:_dataType];
}


- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

//分段控件的事件 的按钮事件
- (void)segmentAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)index);
    switch (index) {
        case 0:
            [self reloadData:0];
            break;
        case 1:
            [self reloadData:1];
            
            break;
        case 2:
            [self reloadData:2];
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
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
    return [mlist count];
}

//获取cell的定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    NSUInteger secNum = [indexPath section];
    MyCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%lu%lu",CellIdentifier,(unsigned long)secNum,(unsigned long)rowNum]];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[MyCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
        //初始化cell的数据源信息
        [cell setCellValue:mlist[rowNum]andConfigList:fieldConfigList];
    }
    return cell;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = [indexPath row];
    NSUInteger secNum = [indexPath section];
    TReptCaseInfo *model=[[TReptCaseInfo alloc]init];
    model=mlist[rowNum];
    if(model!=nil)
    {
        //设置需要传递的参数
        //跳转到指定页面
        QuckClaimsViewController *quckClaimsViewController = [[QuckClaimsViewController alloc] init];
        [quckClaimsViewController  setCurrentCaseInfo:model ];/*参数的传递*/
        [quckClaimsViewController setFieldConfigList:fieldConfigList];
        if([model.QUEUE_DESC isEqualToString:@"未完成"])
        {
            [quckClaimsViewController setOperType:@"upadte"];
        }
        else if([model.QUEUE_DESC isEqualToString:@"初审未通过"])
        {
            //跳转至未通过原因界面，重新提交报案
            ReviewDescViewController *vc=[[ReviewDescViewController alloc]init];
            [vc setCaseInfo:model];
            [vc setFieldConfigList:fieldConfigList];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        else
        {
            [quckClaimsViewController setOperType:@"read"];
        }
        [self.navigationController pushViewController:quckClaimsViewController animated:YES];
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TReptCaseInfo*caseInfo= mlist[indexPath.row];
        _reportKY=caseInfo.REPT_KY;
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"确认删除该报案？"
                              delegate: self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定",nil];
        alert.tag=3;
        [alert show]; //显示

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    TReptCaseInfo*caseInfo= mlist[indexPath.row];
    if([caseInfo.QUEUE_CODE isEqualToString:@"Q1001"])
        return YES;
    else
        return NO;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0) {
        if (buttonIndex==0){
            QuckClaimsViewController *quckClaimsViewController = [[QuckClaimsViewController alloc] init];
            [quckClaimsViewController setFieldConfigList:fieldConfigList];
            [self.navigationController pushViewController:quckClaimsViewController animated:YES];
        }
        
    }else if(alertView.tag==3){

    if(buttonIndex==1)
    {
        NSURL *url=[[NSURL alloc] initWithString:api_case_delete];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[NSString stringWithFormat:@"%d",_reportKY ] forKey:@"REPT_KY"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setDelegate:self];
        request.tag=100002;
        [request setTimeOutSeconds:60];
        //设定同步还是异步方式
        [request startAsynchronous];
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadConfig{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *COMP_ID = [appInfo objectForKey:@"COMP_ID"];
    
    NSURL *url=[[NSURL alloc] initWithString:api_field_config];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:COMP_ID forKey:@"COMP_ID"];
    [request setPostValue:@"自助理赔" forKey:@"FUNC_NAME"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    request.tag=100001;
    [request setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request startAsynchronous];
    //同步方式在此处理返回结果
    
}

//加载数据 0所有 1未完成 2已完成
-(void)reloadData :(int) datatype{
    _dataType=datatype;
    NSURL *url=[[NSURL alloc] initWithString:api_case_list];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue:appDelegate.User.USUS_ID forKey:@"USUS_ID"];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60];
    request.tag=100000;
    //设定同步还是异步方式
    [request startAsynchronous];
    //同步方式在此处理返回结果
    [SVProgressHUD show];
    
}
#pragma mark--快速报案按钮事件
//快速报案事件按钮
-(void)claimsButtonClick
{
    NSURL *url=[[NSURL alloc] initWithString:api_report_check];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue:appDelegate.COMP_ID forKey:@"COMP_ID"];
    [request setPostValue:appDelegate.token forKey: @"token"];
    [request setPostValue:appDelegate.User.USUS_ID forKey:@"USUS_ID"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTag:10];
    [request setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request startAsynchronous];
    [SVProgressHUD show];
    
}
- (void)dealloc
{
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(request.error.description);
    [self.navigationController.view makeToast:[NSString stringWithFormat:@"网络异常！"]];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    if(request.tag==100000)
    {
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        NSLog(@"mlist count:%@",request.responseString);
        //如果返回成功显示
        if (result.ResultCode==0)
        {
            mlist=[[NSMutableArray alloc]init];
            if(_dataType==0)
            {
                mlist = [[JsonTool defaultTool] getTReptCaseInfoList:request.responseString withKey:@"Table"];
                [mlist addObjectsFromArray:[[[JsonTool defaultTool] getTReptCaseInfoList:request.responseString withKey:@"Table1"] copy]];
            }
            else if(_dataType==1)
            {
                mlist = [[JsonTool defaultTool] getTReptCaseInfoList:request.responseString withKey:@"Table"];
            }
            else if(_dataType==2)
            {
                mlist = [[JsonTool defaultTool] getTReptCaseInfoList:request.responseString withKey:@"Table1"];
            }
            
        }
        [self loadConfig];
    }
    else if(request.tag==100001)
    {
        [SVProgressHUD dismiss];
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if (result.ResultCode==0)
        {
            fieldConfigList=[[JsonTool defaultTool]getFieldConfigList:request.responseString withKey:@"model"];
            [self.mainTableView reloadData];
        }
    }
    else if(request.tag==100002)
    {
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if(result.ResultCode==0)
        {
            [self reloadData:_dataType];
        }
        else
        {
            NSLog(@"%@",result.ResultDesc);
            [self.navigationController.view makeToast:@"删除失败！"];
        }
    }
    else if(request.tag==10)
    {
        [SVProgressHUD dismiss];
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if(result.ResultCode==0)
        {
            if(![result.ResultDesc isEqualToString:@""])
            {
                //显示
                NSLog(@"%@",result.ResultDesc);
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:result.ResultDesc
                                      delegate: self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"确定",nil];
                alert.tag=0;
                [alert show]; //显示
                
                
            }
            else{
                QuckClaimsViewController *quckClaimsViewController = [[QuckClaimsViewController alloc] init];
                [quckClaimsViewController setFieldConfigList:fieldConfigList];
                [self.navigationController pushViewController:quckClaimsViewController animated:YES];
            }
            
        }
        else if (result.ResultCode==1){
            NSLog(@"%@",result.ResultDesc);
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:result.ResultDesc
                                  delegate: self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"确定",nil];
            alert.tag=1;
            [alert show]; //显示
            
        }
        else{
            NSLog(@"%@",result.ResultDesc);
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:result.ResultDesc
                                  delegate: self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"确定",nil];
            alert.tag=2;
            [alert show]; //显示
            
            
        }
    }

}

@end
