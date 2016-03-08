//
//  PolicyInfoViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "PolicyInfoViewController.h"
#import "CommonUtil.h"
#import "PolicyInfoListViewController.h"
#import "MemeListViewController.h"
#import "SVProgressHUD.h"
#import "PolicyResponseViewController.h"

#import "Pub.h"

@interface PolicyInfoViewController ()

- (void)backToPreViewController;
- (void)backToHomeButtonClick;
- (void)recognizeeButtonClick;
- (void)policyButtonClick;
- (void)responsibilityQueryButtonClick;

@property (nonatomic, strong) UILabel *recognizeeNameLabel;
@property (nonatomic, strong) UILabel *recognizeePolicyLabel;

@end


@implementation PolicyInfoViewController
@synthesize recognizeeNameLabel;
@synthesize recognizeePolicyLabel;

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
    [titleLable setText:@"保单信息"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    

    //导航结束
    
    
    //搜索收入框开始
    UIButton *recognizeeView = [[UIButton alloc] initWithFrame:CGRectMake(0, navigationBarView.frame.size.height+30, self.view.frame.size.width, 57)];
    [recognizeeView addTarget:self
                       action:@selector(recognizeeButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
    [recognizeeView setImage:[UIImage imageNamed:@"common_input_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:recognizeeView];
    
    UILabel *recognizeeLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 57)];
    [recognizeeLable setText:@"被保人"];
    [recognizeeLable setFont:[UIFont systemFontOfSize:17]];
    [recognizeeLable setTextAlignment:NSTextAlignmentLeft];
    [recognizeeLable setTextColor:[UIColor blackColor]];
    [recognizeeView addSubview:recognizeeLable];
    
    if (self.recognizeeNameLabel == nil) {
        recognizeeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 230, 57)];
    }
    [recognizeeNameLabel setTextColor:[UIColor lightGrayColor]];
    [recognizeeNameLabel setTextAlignment:NSTextAlignmentRight];
    [recognizeeNameLabel setFont:[UIFont systemFontOfSize:15]];
    [recognizeeNameLabel setText:@"请选择被保人"];
    [recognizeeView addSubview:recognizeeNameLabel];
    
    UIImageView *recognizeeArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 17.5, 22, 22)];
    [recognizeeArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
    [recognizeeView addSubview:recognizeeArrow];
    
    UIButton *policyView = [[UIButton alloc] initWithFrame:CGRectMake(0, recognizeeView.frame.size.height+recognizeeView.frame.origin.y+1, self.view.frame.size.width, 57)];
    [policyView addTarget:self
                       action:@selector(policyButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
    [policyView setImage:[UIImage imageNamed:@"common_input_bg.png"] forState:UIControlStateNormal];
    [self.view addSubview:policyView];
    
    UILabel *policyLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 57)];
    [policyLable setText:@"保单"];
    [policyLable setFont:[UIFont systemFontOfSize:17]];
    [policyLable setTextAlignment:NSTextAlignmentLeft];
    [policyLable setTextColor:[UIColor blackColor]];
    [policyView addSubview:policyLable];
    
    if (self.recognizeePolicyLabel == nil) {
        recognizeePolicyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 230, 57)];
    }
    [recognizeePolicyLabel setTextColor:[UIColor lightGrayColor]];
    [recognizeePolicyLabel setTextAlignment:NSTextAlignmentRight];
    [recognizeePolicyLabel setFont:[UIFont systemFontOfSize:15]];
    [recognizeePolicyLabel setText:@"请选择保单"];
    [policyView addSubview:recognizeePolicyLabel];
    
    UIImageView *recognizeePolicyArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 17.5, 22, 22)];
    [recognizeePolicyArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
    [policyView addSubview:recognizeePolicyArrow];
    
    UIButton *responsibilityButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, policyView.frame.size.height+policyView.frame.origin.y+10, 270, 49)];
    [responsibilityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [responsibilityButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [responsibilityButton setTitle:@"保障责任查询" forState:UIControlStateNormal];
    [responsibilityButton addTarget:self
                    action:@selector(responsibilityQueryButtonClick)
          forControlEvents:UIControlEventTouchUpInside];
    [responsibilityButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:responsibilityButton];

    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerPolicy:)
                                                 name:@"RegisterPolicyNotification"
                                               object:nil];
}


#pragma mark --
#pragma mark --
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)recognizeeButtonClick
{
    MemeListViewController *policyViewController = [[MemeListViewController alloc] init];
    [self.navigationController pushViewController:policyViewController animated:YES];
    //先获取返回结果 加载到对象中 传递到下一个也没
    
    NSLog(@"memenameButtonClick");
    NSLog(@"recognizeeButtonClick...");
}

- (void)policyButtonClick
{
    if(currentMemeber ==nil)
    {
        [self.navigationController.view makeToast:@"请先选择被保人！"];
        return;
    }
    PolicyInfoListViewController *policyViewController = [[PolicyInfoListViewController alloc] init];
    policyViewController.memeber=currentMemeber;
    [self.navigationController pushViewController:policyViewController animated:YES];

    NSLog(@"policyButtonClick...");
}

- (void)responsibilityQueryButtonClick
{
    BOOL isValid=YES;
    if (currentMemeber==nil) {
        [self.navigationController.view makeToast:@"被保人未选择！"];
        isValid=NO;
    }
    else if(currentTPolicyInfo==nil)
    {
        [self.navigationController.view makeToast:@"保单未选择"];
        isValid=NO;
    }
    if(isValid) {
        
        NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
        TUserInfo *userModel=[[JsonTool defaultTool] getTUserInfoEntity:cacheString withKey:@"model"];

        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_duty_desc_get];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: userModel.COMP_ID forKey: @"COMP_ID"];
        [request setPostValue: currentTPolicyInfo.PLPL_ID forKey: @"PLPL_ID"];
        [request setPostValue: currentTPolicyInfo.SYSV_PSPS_PLAN_CODE forKey: @"PLAN_CODE"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.token forKey: @"token"];
        NSLog(@"COMP_ID%@",userModel.COMP_ID);
        NSLog(@"PLPL_ID%@",currentTPolicyInfo.PLPL_ID);
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
        [[ConfigTool Instance] saveCacheWithKey:cache_duty_desc_get andData:request.responseString];
        //取消等等框并提示
        [SVProgressHUD dismiss];
        //进行叶面跳转
        PolicyResponseViewController *policyviewController = [[PolicyResponseViewController alloc] init];
        [self.navigationController pushViewController:policyviewController animated:YES];
        
    }else{
         
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
    }
}
/*ASIHttp异步请求 结束*/

/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    TMemberInfo *member=[theData objectForKey:@"popitemname"];
    if(![member.MEME_KY isEqualToString:currentMemeber.MEME_KY])
    {
        currentTPolicyInfo=nil;
        [self. recognizeePolicyLabel setText:@"请选择保单"];
    }
    currentMemeber = member;
    NSLog(@"username = %@",currentMemeber.MEME_NAME);
    /*获取返回值 刷新本页列表*/
    [self.recognizeeNameLabel setText:currentMemeber.MEME_NAME];
    
}

-(void)registerPolicy:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    currentTPolicyInfo = [theData objectForKey:@"popitemname"];
    
    /*获取返回值 刷新本页列表*/
    NSString *tmp=[NSString stringWithFormat:@"%@ 到 %@",currentTPolicyInfo.PSPS_START_DT,currentTPolicyInfo.PSPS_END_DT];
    [self. recognizeePolicyLabel setText:tmp];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
