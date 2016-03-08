//
//  RegisterFirstStepViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "RegisterFirstStepViewController.h"
#import "CommonUtil.h"
#import "RegisterSecondStepViewController.h"
#import "SVProgressHUD.h"
#import "Pub.h"

@interface RegisterFirstStepViewController ()
@property (nonatomic, strong) UITextField *icTextField;
@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) CommonUtil *commonUtil;

- (void)backToPreViewController;
- (void)nextStepButtonClick;
- (void)tapGesture:(UITapGestureRecognizer *)sender;
@end

@implementation RegisterFirstStepViewController
@synthesize icTextField;
@synthesize userNameField;
@synthesize commonUtil;


- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.commonUtil == nil) {
            commonUtil = [[CommonUtil alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    NSLog(@"self.view.frame.size.width=%f",self.view.frame.size.width);
    
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
    [titleLable setText:@"用户注册"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.frame.size.width,95)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *baseInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [baseInfoImageView setImage:[UIImage imageNamed:@"register_verifyuser_hight_icon.png"]];
    [headerView addSubview:baseInfoImageView];
    UILabel *baseInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 48+16, 64, 20)];
    [baseInfoLable setText:@"用户校验"];
    [baseInfoLable setTextAlignment:NSTextAlignmentCenter];
    [baseInfoLable setFont:[UIFont systemFontOfSize:13]];
    [baseInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [headerView addSubview:baseInfoLable];
    
    UIImageView *lineOImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44, 25+16, (self.view.frame.size.width-40-44*3)/2.0,5)];
    [lineOImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [headerView addSubview:lineOImageView];
    
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44+(self.view.frame.size.width-40-44*3)/2.0, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"register_userinfo_icon.png"]];
    [headerView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44+(self.view.frame.size.width-40-44*3)/2.0, 48+16, 64, 20)];
    [uploadInfoLable setText:@"个人信息"];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [uploadInfoLable setTextColor:[UIColor lightGrayColor]];
    [headerView addSubview:uploadInfoLable];
    
    UIImageView *lineTImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*3)/2.0, 25+16, (self.view.frame.size.width-40-44*3)/2.0, 5)];
    [lineTImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [headerView addSubview:lineTImageView];
    
    UIImageView *comfirmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*3)/2.0*2, 20, 44, 44)];
    [comfirmImageView setImage:[UIImage imageNamed:@"register_finish_icon.png"]];
    [headerView addSubview:comfirmImageView];
    UILabel *comfirmInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*3)/2.0*2, 48+16, 64, 20)];
    [comfirmInfoLable setText:@"联系信息"];
    [comfirmInfoLable setTextAlignment:NSTextAlignmentCenter];
    [comfirmInfoLable setFont:[UIFont systemFontOfSize:13]];
    [comfirmInfoLable setTextColor:[UIColor lightGrayColor]];
    [headerView addSubview:comfirmInfoLable];
    [self.view addSubview:headerView];
    //导航图片流程结束
    
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
    [userNameLabel setText:@"姓名"];
    [loginPwdInputBG addSubview:userNameLabel];
    UIImageView *required=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required.image=[UIImage imageNamed:@"hits_star"];
    required.contentMode=UIViewContentModeScaleAspectFit;
    [loginPwdInputBG addSubview:required];
    //VIP ID label控件
    UILabel  *userICLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0.0, 90, 42)];
    [userICLabel setBackgroundColor:[UIColor clearColor]];
    [userICLabel setTextColor:[UIColor blackColor]];
    [userICLabel setTextAlignment:NSTextAlignmentLeft];
    [userICLabel setFont:[UIFont systemFontOfSize:15]];
    [userICLabel setText:@"证件号码"];
    [loginTextFieldBG addSubview:userICLabel];
    UIImageView *required1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required1.image=[UIImage imageNamed:@"hits_star"];
    required1.contentMode=UIViewContentModeScaleAspectFit;
    [loginTextFieldBG addSubview:required1];

    //定义的VIP ID输入控件 全局
    
    //定义的姓名控件 全局 添加在
    if (self.userNameField == nil) {
        userNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [userNameField setDelegate:self];
    [userNameField setPlaceholder:@"请输入您的真实姓名"];
    [userNameField setText:@""];
    [userNameField setBackgroundColor:[UIColor whiteColor]];
    [userNameField setFont:[UIFont systemFontOfSize:13.0f]];
    [userNameField setTextColor:[UIColor blackColor]];
    [userNameField setTextAlignment:NSTextAlignmentLeft];
    [userNameField setReturnKeyType:UIReturnKeyDone];
    userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [userNameField.layer setCornerRadius:3.0];
    [loginPwdInputBG addSubview:userNameField];
    
    if (self.icTextField == nil) {
        icTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [icTextField setDelegate:self];
    [icTextField setPlaceholder:@"请输入您的证件号码"];
    [icTextField setBackgroundColor:[UIColor whiteColor]];
    [icTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [icTextField setTextColor:[UIColor blackColor]];
    [icTextField setText:@""];
    [icTextField setTextAlignment:NSTextAlignmentLeft];
    [icTextField setReturnKeyType:UIReturnKeyNext];
    [icTextField.layer setCornerRadius:3.0];
    [icTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    icTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [loginTextFieldBG addSubview:icTextField];
    
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+40, 270, 49)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registerButton setTitle:@"下一步" forState:UIControlStateNormal];
    [registerButton addTarget:self
                    action:@selector(nextStepButtonClick)
          forControlEvents:UIControlEventTouchUpInside];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapGesture:)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGesture];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    [icTextField resignFirstResponder];
    [userNameField resignFirstResponder];
}

- (void)nextStepButtonClick
{
    BOOL isValid=YES;
    
    if (icTextField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"您的证件号码不能为空！"];
    }
    else if (userNameField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"您的姓名不能为空！"];
    }
    
    if(isValid) {
        
        
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString: api_user_regcheck];

        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: icTextField.text forKey: @"USUS_CERT_NO"];
        [request setPostValue: userNameField.text forKey: @"USUS_NAME"];
        [request setPostValue: [(AppDelegate*)[[UIApplication sharedApplication]delegate] COMP_ID] forKey: @"COMP_ID"];
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
    [SVProgressHUD dismiss];
    [self.navigationController.view makeToast:@"登陆失败检查用户名或密码！"];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        [SVProgressHUD dismiss];
        TUserInfo *reg=[[TUserInfo alloc] init];
        reg= [[JsonTool defaultTool] getTUserInfoEntity:request.responseString withKey:@"model"];
        RegisterSecondStepViewController *secView =[[RegisterSecondStepViewController alloc] init];
        [secView setRegisterInfo:reg];
        [self.navigationController pushViewController:secView animated:YES];
        
    }else{
        
        [SVProgressHUD dismiss];
        [self.navigationController.view makeToast:model.ResultDesc];
    }
}
/*ASIHttp异步请求 结束*/


- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.icTextField = nil;
    self.userNameField = nil;
}
@end
