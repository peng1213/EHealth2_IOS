//
//  ClaimReportQueryViewController.m
//  EhealthClient
//
//  Created by jiaojunkang on 15-4-27.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ClaimReportQueryViewController.h"
#import "ConfigTool.h"
#import "TUserInfo.h"
#import "MemeListViewController.h"
#import "UIWindow+YzdHUD.h"
#import "ClaimReportListViewController.h"
#import "PolicyInfoListViewController.h"
#import "CommonUtil.h"

@interface ClaimReportQueryViewController ()
@end

@implementation ClaimReportQueryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*01 屏蔽导航栏的遮挡效果 only for ios 7 and up*/
#ifdef IOS7_SDK_AVAILABLE
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
#endif

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
    [titleLable setText:@"理赔报告"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    if (currentModel==nil) {
        currentModel=[[TMemberInfo alloc] init ];
    }
    if (currentPolicy==nil) {
        currentPolicy=[[TPolicyInfo alloc]init];
    }
    /*04 为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerInstanceCompletion:)
                                                 name:@"RegisterPolicyNotification"
                                               object:nil];
    // Do any additional setup after loading the view from its nib.
}


//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerInstanceCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    NSString *str = [theData objectForKey:@"popclaimstatusname"];
    currentPolicy=[theData objectForKey:@"popitemname"];
    NSString *tmp=[NSString stringWithFormat:@"%@ 到 %@",currentPolicy.PSPS_START_DT,currentPolicy.PSPS_END_DT];
    self.PLPL_ID_Label.text=tmp;
    /*获取返回值 刷新本页列表*/
    
}


/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    currentModel = [theData objectForKey:@"popitemname"];
    
    NSLog(@"username = %@",currentModel.MEME_NAME);
    /*获取返回值 刷新本页列表*/
    self.USUS_NAME_Label.text=currentModel.MEME_NAME;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnQuery:(id)sender {
    NSLog(@"btnQuery");
    BOOL isvalid=YES;
    if ([currentPolicy.PLPL_ID isEqualToString:@""] || currentPolicy.PLPL_ID==nil) {
        
        [self.view.window showHUDWithText:@"保单未选择" Type:ShowPhotoNo Enabled:YES];
        isvalid=NO;
        return;
    }
    if (currentModel.MEME_KY <=0) {
        [self.view.window showHUDWithText:@"被保人未选择" Type:ShowPhotoNo Enabled:YES];
        isvalid=NO;
        return;

    }
    if (isvalid) {
        ClaimReportListViewController *clview=[[ClaimReportListViewController alloc] init];
        [clview setCurrentMember:currentModel];
        [clview setCurrentPolicy:currentPolicy];
        clview.hidesBottomBarWhenPushed = YES;//隐藏底部
        [self.navigationController pushViewController:clview animated:YES];
    }

}

- (IBAction)btnSelectUSUS:(id)sender {
    MemeListViewController *policyViewController = [[MemeListViewController alloc] init];
    [self.navigationController pushViewController:policyViewController animated:YES];
}

- (IBAction)btnSelectPLPL:(id)sender {
    if(currentModel ==nil)
    {
        [self.navigationController.view makeToast:@"请先选择被保人！"];
        return;
    }
    PolicyInfoListViewController *policyViewController = [[PolicyInfoListViewController alloc] init];
    policyViewController.memeber=currentModel;
    [self.navigationController pushViewController:policyViewController animated:YES];
    
}
@end
