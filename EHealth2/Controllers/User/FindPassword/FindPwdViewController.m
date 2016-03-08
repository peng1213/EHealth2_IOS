//
//  FindPwdViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/9/21.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "FindPwdViewController.h"
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "Pub.h"
#import "SVProgressHUD.h"
#import "FindPwdViewController.h"
#import "UIKeyboardViewController.h"

@interface FindPwdViewController ()
{
    UIKeyboardViewController *keyBoardController;
    UILabel *userNameField;
    UITextField *icTextField;
}
@end

@implementation FindPwdViewController
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [titleLable setText:@"找回密码"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.frame.size.width,95)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *lineOImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 25+16,100,5)];
    [lineOImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [headerView addSubview:lineOImageView];
    
    UIImageView *baseInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lineOImageView.frame.origin.x-44 , 20, 44, 44)];
    [baseInfoImageView setImage:[UIImage imageNamed:@"register_verifyuser_hight_icon.png"]];
    [headerView addSubview:baseInfoImageView];
    UILabel *baseInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(lineOImageView.frame.origin.x-44-10, 48+16, 64, 20)];
    [baseInfoLable setText:@"用户校验"];
    [baseInfoLable setTextAlignment:NSTextAlignmentCenter];
    [baseInfoLable setFont:[UIFont systemFontOfSize:13]];
    [baseInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [headerView addSubview:baseInfoLable];

    
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lineOImageView.frame.origin.x+100, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"register_userinfo_hight_icon.png"]];
    [headerView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(lineOImageView.frame.origin.x+100-10, 48+16, 64, 20)];
    [uploadInfoLable setText:@"重置密码"];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [uploadInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [headerView addSubview:uploadInfoLable];
    
    [self.view addSubview:headerView];
    
    //用户名称 设置控件背景
    UIImageView  *loginTextFieldBG = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, headerView.frame.origin.y+headerView.frame.size.height+20, self.view.frame.size.width, 42)];
    [loginTextFieldBG setImage:[UIImage imageNamed:@"login_username_input_background.png"]];
    [loginTextFieldBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginTextFieldBG];
    //用户密码 设置用户密码背景
    UIImageView  *loginPwdInputBG = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, loginTextFieldBG.frame.origin.y+loginTextFieldBG.frame.size.height, self.view.frame.size.width, 42)];
    
    [loginPwdInputBG setImage:[UIImage imageNamed:@"login_userpwd_input_background.png"]];
    [loginPwdInputBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginPwdInputBG];
    
    //用户名称label控件
    UILabel  *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0.0, 90, 42)];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setTextColor:[UIColor blackColor]];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setFont:[UIFont systemFontOfSize:15]];
    [userNameLabel setText:@"用户名"];
    [loginTextFieldBG addSubview:userNameLabel];
    
    //VIP ID label控件
    UILabel  *userICLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0.0, 90, 42)];
    [userICLabel setBackgroundColor:[UIColor clearColor]];
    [userICLabel setTextColor:[UIColor blackColor]];
    [userICLabel setTextAlignment:NSTextAlignmentLeft];
    [userICLabel setFont:[UIFont systemFontOfSize:15]];
    [userICLabel setText:@"密码"];
    [loginPwdInputBG addSubview:userICLabel];
    UIImageView *required1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required1.image=[UIImage imageNamed:@"hits_star"];
    required1.contentMode=UIViewContentModeScaleAspectFit;
    [loginPwdInputBG addSubview:required1];
    
    //定义的VIP ID输入控件 全局
    
    //定义的姓名控件 全局 添加在
    if (userNameField == nil) {
        userNameField = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [userNameField setText:user.USUS_ID];
    [userNameField setBackgroundColor:[UIColor whiteColor]];
    [userNameField setFont:[UIFont systemFontOfSize:13.0f]];
    [userNameField setTextColor:[UIColor blackColor]];
    [userNameField setTextAlignment:NSTextAlignmentLeft];
    [userNameField.layer setCornerRadius:3.0];
    [userNameField setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [loginTextFieldBG addSubview:userNameField];
    
    if (icTextField == nil) {
        icTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [icTextField setDelegate:self];
    [icTextField setPlaceholder:@"请输入您的新密码"];
    [icTextField setSecureTextEntry:YES];
    [icTextField setBackgroundColor:[UIColor whiteColor]];
    [icTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [icTextField setTextColor:[UIColor blackColor]];
    [icTextField setText:@""];
    [icTextField setTextAlignment:NSTextAlignmentLeft];
    [icTextField setReturnKeyType:UIReturnKeyNext];
    [icTextField.layer setCornerRadius:3.0];
    [icTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    icTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [loginPwdInputBG addSubview:icTextField];
    
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+40, 270, 49)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registerButton setTitle:@"确 认" forState:UIControlStateNormal];
    [registerButton addTarget:self
                       action:@selector(resetPwd)
             forControlEvents:UIControlEventTouchUpInside];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    // Do any additional setup after loading the view.
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetPwd
{
    BOOL isValid=YES;
    
    if(userNameField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"密码不能为空！"];
        return;
    }
    
    if(isValid) {
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_user_findpwd];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: user.USUS_KY forKey: @"USUS_KY"];
        [request setPostValue: [CommonUtil MD5:icTextField.text] forKey: @"USUS_PWD"];
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
    [self.navigationController.view makeToast:@"网络异常！"];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重置成功"
                                                        message:@"密码重置成功，请牢记！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];

        
    }else{
        
        [SVProgressHUD dismiss];
        [self.navigationController.view makeToast:model.ResultDesc];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LoginViewController class]]) {
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
