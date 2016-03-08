//
//  QuckClaimsOKViewController.m
//  citic
//
//  Created by echoliu on 15-4-18.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QuckClaimsOKViewController.h"

#import "MyCaseViewController.h"
#import "HealthViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "Pub.h"


@interface QuckClaimsOKViewController ()
@property (nonatomic,strong) UILabel *userICLabel;
@property (nonatomic,strong) UILabel  *userNameLabel;
@end

@implementation QuckClaimsOKViewController
@synthesize currentCaseInfo;
@synthesize userICLabel;
@synthesize operType;
@synthesize userNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景F0F0F0
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    //设置导航条的View
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    //设置导航View上的返回按钮 定义事件为backToPreViewController
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置导航View上的标题 快速报案
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"影像列表"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置一个流程导航的View 存放流程 基本信息－>收款信息->上传影像->确认信息
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.frame.size.width,95)];
    [tableHeaderView setBackgroundColor:[UIColor whiteColor]];
    //基本信息
    UIImageView *baseInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [baseInfoImageView setImage:[UIImage imageNamed:@"reg_icon1"]];
    [tableHeaderView addSubview:baseInfoImageView];
    UILabel *baseInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 48+16, 64, 20)];
    [baseInfoLable setText:@"基本信息"];
    [baseInfoLable setTextAlignment:NSTextAlignmentCenter];
    [baseInfoLable setFont:[UIFont systemFontOfSize:13]];
    [baseInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [tableHeaderView addSubview:baseInfoLable];
    UIImageView *lineOImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [lineOImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:lineOImageView];
    //收款信息
    UIImageView *accountInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44+(self.view.frame.size.width-40-44*4)/3.0, 20, 44, 44)];
    [accountInfoImageView setImage:[UIImage imageNamed:@"reg_icon2.png"]];
    [tableHeaderView addSubview:accountInfoImageView];
    UILabel *accountInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44+(self.view.frame.size.width-40-44*4)/3.0, 48+16, 64, 20)];
    [accountInfoLable setText:@"收款信息"];
    [accountInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [accountInfoLable setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:accountInfoLable];
    UIImageView *line1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [line1ImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:line1ImageView];
    
    //上传影像
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"report_icon2_current.png"]];
    [tableHeaderView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 48+16, 64, 20)];
    [uploadInfoLable setText:@"上传影像"];
    [uploadInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:uploadInfoLable];
    UIImageView *lineTImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*2, 25+16, (self.view.frame.size.width-40-44*4)/3.0, 5)];
    [lineTImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:lineTImageView];
    
    //确认信息
    UIImageView *comfirmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 20, 44, 44)];
    [comfirmImageView setImage:[UIImage imageNamed:@"report_icon3_current.png"]];
    [tableHeaderView addSubview:comfirmImageView];
    UILabel *comfirmInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 48+16, 64, 20)];
    [comfirmInfoLable setText:@"确认信息"];
    [comfirmInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [comfirmInfoLable setTextAlignment:NSTextAlignmentCenter];
    [comfirmInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:comfirmInfoLable];
    [self.view addSubview:tableHeaderView];
    
    //用户密码 设置用户密码背景
    
    //用户名称 设置控件背景
    UIImageView  *loginTextFieldBG = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height+20, self.view.frame.size.width, 42)];
    [loginTextFieldBG setImage:[UIImage imageNamed:@"login_username_input_background.png"]];
    [loginTextFieldBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginTextFieldBG];
    //用户密码 设置用户密码背景
    UIImageView  *loginPwdInputBG = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, loginTextFieldBG.frame.origin.y+loginTextFieldBG.frame.size.height, self.view.frame.size.width, 42)];
    
    [loginPwdInputBG setImage:[UIImage imageNamed:@"login_userpwd_input_background.png"]];
    [loginPwdInputBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginPwdInputBG];
    //VIP ID label控件
    if(userICLabel==nil)
        userICLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0.0, self.view.frame.size.width-40, 42)];
    [userICLabel setBackgroundColor:[UIColor clearColor]];
    [userICLabel setTextColor:[UIColor orangeColor]];
    [userICLabel setTextAlignment:NSTextAlignmentLeft];
    [userICLabel setFont:[UIFont systemFontOfSize:18]];
    [userICLabel setText:@"恭喜您，报案成功！"];
    [loginTextFieldBG addSubview:userICLabel];
    //用户名称label控件
    userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0.0, self.view.frame.size.width-40, 42)];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setTextColor:[UIColor grayColor]];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setFont:[UIFont systemFontOfSize:15]];
    [userNameLabel setNumberOfLines:0];
    [userNameLabel setText:@"您的理赔申请已经受理"];
    [loginPwdInputBG addSubview:userNameLabel];

    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+40, 270, 49)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registerButton setTitle:@"完成" forState:UIControlStateNormal];
    [registerButton addTarget:self
                       action:@selector(nextStepButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
    
    //采用ASIHttp框架来实现
    if([currentCaseInfo.QUEUE_DESC isEqualToString:@"未完成"])
    {
    NSURL *url =[NSURL URLWithString:api_case_confirm];
    ASIFormDataRequest* request =[ASIFormDataRequest requestWithURL:url];
    [request setPostValue: [NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY]  forKey: @"REPT_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60.0f];
    [request startAsynchronous];
    [SVProgressHUD show];
    }
    else
    {
        NSString * htmlString = [NSString stringWithFormat:@"请将报案号:<span><font color=\"red\">%@</font></span> 记录在理赔申请表上，并且请尽快提交您的理赔申请资料原件，避免划款延误，谢谢。",currentCaseInfo.REPT_ID];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        userNameLabel.attributedText=attrStr;
    }
}

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"网络异常！"];
    [SVProgressHUD dismiss];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"mlist count:%@",request.responseString);
    //如果返回成功显示
    if (model.ResultCode==0)
    {
        TReptCaseInfo *caseInfo=[[JsonTool defaultTool]getTReptCaseInfo:request.responseString withKey:@"model"];
        NSString * htmlString = [NSString stringWithFormat:@"请将报案号:<span><font color=\"red\">%@</font></span> 记录在理赔申请表上，谢谢。",caseInfo.REPT_ID];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        userNameLabel.attributedText=attrStr;
    }
    else
    {
        [self.navigationController.view makeToast:[NSString stringWithFormat: @"%@",model.ResultDesc]];
    }
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextStepButtonClick
{
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:@"ok"
                                                         forKey:@"popitemname"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterMyCaseNotification"
     object:nil
     userInfo:dataDict];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyCaseViewController class]]) {
            [self.navigationController popToViewController:controller
                                                  animated:YES];
        }
    }

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
