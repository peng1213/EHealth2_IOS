//
//  QueryClaimsViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "QueryClaimsViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "MemeListViewController.h"
#import "ZTPickerView.h"
#import "QueryClaimsListViewController.h"
#import "Pub.h"
#import "HealthViewController.h"

@interface QueryClaimsViewController ()
{
    BOOL isStarDate;
}
@property (nonatomic, strong) UILabel *contentRecognizeeLabel;
@property (nonatomic, strong) UILabel *beginTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *caseStateLabel;
@property(nonatomic,strong)ZTPickerView *datePickerView;
@property (nonatomic, strong) UIActionSheet *pationtActionSheet;

- (void)backToPreViewController;
- (void)backToHomeButtonClick;
- (void)recognizeeButtonClick;
- (void)beginTimeButtonClick;
- (void)endTimeButtonClick;
- (void)caseStateButtonClick;
- (void)queryCaseButtonClick;
@end

@implementation QueryClaimsViewController
@synthesize contentRecognizeeLabel;
@synthesize datePickerView;
@synthesize beginTimeLabel;
@synthesize endTimeLabel;
@synthesize caseStateLabel;
@synthesize pationtActionSheet;

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
    [titleLable setText:@"理赔查询 "];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
//    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 27.0, 30.0, 30.0)];
//    [homeButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_home_icon"] forState:UIControlStateNormal];
//    [homeButton addTarget:self
//                   action:@selector(backToHomeButtonClick)
//         forControlEvents:UIControlEventTouchUpInside];
//    [navigationBarView addSubview:homeButton];
    
    UIButton *recognizeeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,84.0f,self.view.frame.size.width,40.0)];
    [recognizeeButton addTarget:self
                         action:@selector(recognizeeButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    [recognizeeButton setImage:[UIImage imageNamed:@"common_cell_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:recognizeeButton];
    
    UILabel *recognizeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [recognizeeLabel setBackgroundColor:[UIColor clearColor]];
    [recognizeeLabel setFont:[UIFont systemFontOfSize:15]];
    [recognizeeLabel setText:@"被保人"];
    [recognizeeLabel setTextAlignment:NSTextAlignmentLeft];
    [recognizeeLabel setTextColor:[UIColor blackColor]];
    [recognizeeButton addSubview:recognizeeLabel];
     
    if (self.contentRecognizeeLabel == nil) {
        contentRecognizeeLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150-32), 5.0, 150, 30)];
    }
    [contentRecognizeeLabel setText:@"请选择被保人"];
    [contentRecognizeeLabel setTextAlignment:NSTextAlignmentRight];
    [contentRecognizeeLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [contentRecognizeeLabel setBackgroundColor:[UIColor clearColor]];
    [contentRecognizeeLabel setTextColor:[UIColor lightGrayColor]];
    [recognizeeButton addSubview:contentRecognizeeLabel];
    
    UIButton *beginTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,recognizeeButton.frame.origin.y+recognizeeButton.frame.size.height,self.view.frame.size.width,40.0)];
    [beginTimeButton addTarget:self
                        action:@selector(beginTimeButtonClick)
              forControlEvents:UIControlEventTouchUpInside];
    [beginTimeButton setImage:[UIImage imageNamed:@"common_cell_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:beginTimeButton];
    
    UILabel *beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [beginLabel setBackgroundColor:[UIColor clearColor]];
    [beginLabel setFont:[UIFont systemFontOfSize:15]];
    [beginLabel setText:@"开始时间"];
    [beginLabel setTextAlignment:NSTextAlignmentLeft];
    [beginLabel setTextColor:[UIColor blackColor]];
    [beginTimeButton addSubview:beginLabel];
    
    if (self.beginTimeLabel == nil) {
        beginTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150-32), 5.0, 150, 30)];
    }
    [beginTimeLabel setText:@"请选择开始时间"];
    [beginTimeLabel setTextAlignment:NSTextAlignmentRight];
    [beginTimeLabel setBackgroundColor:[UIColor clearColor]];
    [beginTimeLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [beginTimeLabel setTextColor:[UIColor lightGrayColor]];
    [beginTimeButton addSubview:beginTimeLabel];
    
    UIButton *endTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,beginTimeButton.frame.origin.y+beginTimeButton.frame.size.height,self.view.frame.size.width,40.0)];
    [endTimeButton addTarget:self
                      action:@selector(endTimeButtonClick)
            forControlEvents:UIControlEventTouchUpInside];
    [endTimeButton setImage:[UIImage imageNamed:@"common_cell_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:endTimeButton];
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [endLabel setBackgroundColor:[UIColor clearColor]];
    [endLabel setFont:[UIFont systemFontOfSize:15]];
    [endLabel setText:@"结束时间"];
    [endLabel setTextAlignment:NSTextAlignmentLeft];
    [endLabel setTextColor:[UIColor blackColor]];
    [endTimeButton addSubview:endLabel];
    
    if (self.endTimeLabel == nil) {
        endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150-32), 5.0, 150, 30)];
    }
    [endTimeLabel setTextAlignment:NSTextAlignmentRight];
    [endTimeLabel setText:@"请选择结束时间"];
    [endTimeLabel setBackgroundColor:[UIColor clearColor]];
    [endTimeLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [endTimeLabel setTextColor:[UIColor lightGrayColor]];
    [endTimeButton addSubview:endTimeLabel];
    
    
    UIButton *caseStateButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,endTimeButton.frame.origin.y+endTimeButton.frame.size.height,self.view.frame.size.width,40.0)];
    [caseStateButton addTarget:self
                   action:@selector(caseStateButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
    [caseStateButton setImage:[UIImage imageNamed:@"common_cell_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:caseStateButton];
    
    UILabel *caseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [caseLabel setBackgroundColor:[UIColor clearColor]];
    [caseLabel setFont:[UIFont systemFontOfSize:15]];
    [caseLabel setText:@"案件状态"];
    [caseLabel setTextAlignment:NSTextAlignmentLeft];
    [caseLabel setTextColor:[UIColor blackColor]];
    [caseStateButton addSubview:caseLabel];
    
    if (self.caseStateLabel == nil) {
        caseStateLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150-32), 5.0, 150, 30)];
    }
    [caseStateLabel setTextAlignment:NSTextAlignmentRight];
    [caseStateLabel setText:@"所有"];
    [caseStateLabel setBackgroundColor:[UIColor clearColor]];
    [caseStateLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [caseStateLabel setTextColor:[UIColor lightGrayColor]];
    [caseStateButton addSubview:caseStateLabel];
    
    UIButton *queryCaseButton = [[UIButton alloc] initWithFrame:CGRectMake(30, caseStateButton.frame.origin.y+caseStateButton.frame.size.height+20, self.view.frame.size.width-60, 44)];
    [queryCaseButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [queryCaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryCaseButton setTitle:@"查 询" forState:UIControlStateNormal];
    [queryCaseButton addTarget:self
                      action:@selector(queryCaseButtonClick)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryCaseButton];
    //日期
    if (self.datePickerView == nil) {
        NSDate *date = [NSDate date];
        datePickerView = [[ZTPickerView alloc] initDatePickWithDate:date
                                                     datePickerMode:UIDatePickerModeDate
                                                 isHaveNavControler:NO];
    }
    [datePickerView setDelegate:self];
    [datePickerView setToolBarTintColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [datePickerView setBackgroundColor:[UIColor whiteColor]];

    
    
    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
    //
    isStarDate=NO;
    
}

/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    currentMemeber = [theData objectForKey:@"popitemname"];
    
    NSLog(@"username = %@",currentMemeber.MEME_NAME);
    /*获取返回值 刷新本页列表*/
    [self.contentRecognizeeLabel setText:currentMemeber.MEME_NAME];
    
}

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
//被保险人选择
- (void)recognizeeButtonClick
{
    MemeListViewController *policyViewController = [[MemeListViewController alloc] init];
    [self.navigationController pushViewController:policyViewController animated:YES];
    //先获取返回结果 加载到对象中 传递到下一个也没
    
}
//开始时间
- (void)beginTimeButtonClick
{
    
    isStarDate=YES;
    [datePickerView show];

}
//结束时间
- (void)endTimeButtonClick
{
    
    isStarDate=NO;
    
    [datePickerView show];
}


//状态
- (void)caseStateButtonClick
{
    if (self.pationtActionSheet == nil) {
        pationtActionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择案件状态"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"所有", @"处理中",@"已结案",@"已退件",nil];
    }
    [pationtActionSheet showInView:self.view];

}
//查询
- (void)queryCaseButtonClick
{
    BOOL isValid=YES;
    if (currentMemeber==nil) {
        [self.navigationController.view makeToast:@"被保人未选择！"];
        isValid=NO;
    }
    if([beginTimeLabel.text isEqualToString:@"请选择开始时间"])
    {
        [self.navigationController.view makeToast:@"请选择开始时间！"];
        isValid=NO;
    }
    if([endTimeLabel.text isEqualToString:@"请选择结束时间"])
    {
        [self.navigationController.view makeToast:@"请选择结束时间！"];
        isValid=NO;
    }
    NSString * status=self.caseStateLabel.text;
    if ([status isEqualToString:@"所有"]) {
        status=@"";
    }
    
    if(isValid) {
        
        
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_claim_get];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: currentMemeber.MEME_KY forKey: @"MEME_KY"];
        [request setPostValue: status forKey: @"QUEUE_CODE"];
        [request setPostValue: self.beginTimeLabel.text forKey: @"START_TIME"];
        [request setPostValue: self.endTimeLabel.text forKey: @"END_TIME"];
        [request setPostValue: appDelegate.COMP_ID forKey: @"COMP_ID"];
        [request setPostValue: appDelegate.token forKey: @"token"];


        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setDelegate:self];
        [request setTimeOutSeconds:60.0f];
        [request startAsynchronous];
        //显示进度滚动
        [SVProgressHUD show];

    
    
    
        
    }
}


/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"登陆失败检查用户名或密码！"];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    //清除历史缓存
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"responseString:%@",request.responseString);
    if(model.ResultCode==0 ){
        //获取TUSERINFO对象
        [[ConfigTool Instance] saveCacheWithKey:cache_claim_get andData:request.responseString];
        //取消等等框并提示
        [SVProgressHUD dismiss];
        
        //进行叶面跳转
        QueryClaimsListViewController *viewController = [[QueryClaimsListViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else{
        
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
    }
}
/*ASIHttp异步请求 结束*/





- (void)dealloc
{
    self.contentRecognizeeLabel = nil;
    self.beginTimeLabel = nil;
    self.endTimeLabel = nil;
    self.caseStateLabel = nil;
}
//日期回调函数
-(void)pickerBarDoneClick:(ZTPickerView *)pickView resultString:(NSString *)resultString{
    if (isStarDate) {
        self.beginTimeLabel.text=resultString;
    }
    else{
        self.endTimeLabel.text=resultString;
    }
}
#pragma mark -- UIActionSheetDelegate methods 弹框回调函数
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.pationtActionSheet) {
        if (buttonIndex == 4) {
            return;
        }else {
             self.caseStateLabel.text = [actionSheet buttonTitleAtIndex:buttonIndex];
            
        }
    }
}
@end
