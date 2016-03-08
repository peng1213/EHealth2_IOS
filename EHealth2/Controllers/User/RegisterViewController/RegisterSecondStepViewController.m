//
//  RegisterSecondStepViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//
#define UserID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\n"

#import "RegisterSecondStepViewController.h"
#import "CommonUtil.h"
#import "RegisterThirdStepViewController.h"
#import "VerifyCodeView.h"
#import "SVProgressHUD.h"
#import "Pub.h"



@interface RegisterSecondStepViewController ()
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *userPwdTextField;
@property (nonatomic, strong) UITextField *confirmTextField;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) VerifyCodeView *verifyCodeButton;
@property (nonatomic, strong) CommonUtil *commonUtil;

- (void)backToPreViewController;
- (void)registerButtonClick;
- (void)tapGesture:(UITapGestureRecognizer *)sender;

@end

@implementation RegisterSecondStepViewController
@synthesize userNameTextField;
@synthesize userPwdTextField;
@synthesize confirmTextField;
@synthesize verifyCodeTextField;
@synthesize verifyCodeButton;
@synthesize commonUtil;
@synthesize registerInfo;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.registerInfo == nil) {
            registerInfo = [[TUserInfo alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    NSLog(@"self.view.frame.size.width=%f",self.view.frame.size.width);
    self.navigationItem.title=@"个人信息";
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
    [uploadImageView setImage:[UIImage imageNamed:@"register_userinfo_hight_icon.png"]];
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
    
    UILabel *note=[[UILabel alloc]initWithFrame:CGRectMake(5, headerView.frame.origin.y+headerView.frame.size.height, self.view.frame.size.width-5, 20)];
    note.text=@"用户名密码必须为大于6位字母或数字组合,不能包含中文和特殊符号";
    note.font=[UIFont systemFontOfSize:10];
    note.textColor=[UIColor lightGrayColor];
    note.numberOfLines=0;
    [self.view addSubview:note];
    UIImageView *userNameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, headerView.frame.origin.y+headerView.frame.size.height+20, self.view.frame.size.width, 40.0)];
    [userNameIcon setUserInteractionEnabled:YES];
    [userNameIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:userNameIcon];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [userNameLabel setFont:[UIFont systemFontOfSize:15]];
    [userNameLabel setText:@"用户名"];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setTextColor:[UIColor blackColor]];
    [userNameIcon addSubview:userNameLabel];
    
    if (self.userNameTextField == nil) {
        userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userNameTextField setDelegate:self];
    [userNameTextField setPlaceholder:@"请输入用户名"];
    [userNameTextField setBackgroundColor:[UIColor whiteColor]];
    [userNameTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userNameTextField setTextColor:[UIColor blackColor]];
    [userNameTextField setTextAlignment:NSTextAlignmentLeft];
    [userNameTextField setReturnKeyType:UIReturnKeyNext];
    [userNameTextField.layer setCornerRadius:3.0];
    [userNameTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    userNameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [userNameIcon addSubview:userNameTextField];
    UIImageView *required1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required1.image=[UIImage imageNamed:@"hits_star"];
    required1.contentMode=UIViewContentModeScaleAspectFit;
    [userNameIcon addSubview:required1];
    
    
    UIImageView *pwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, userNameIcon.frame.origin.y+userNameIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [pwdIcon setUserInteractionEnabled:YES];
    [pwdIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:pwdIcon];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [pwdLabel setFont:[UIFont systemFontOfSize:15]];
    [pwdLabel setText:@"密码"];
    [pwdLabel setTextAlignment:NSTextAlignmentLeft];
    [pwdLabel setTextColor:[UIColor blackColor]];
    [pwdIcon addSubview:pwdLabel];
    
    if (self.userPwdTextField == nil) {
        userPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userPwdTextField setDelegate:self];
    [userPwdTextField setPlaceholder:@"请输入密码"];
    [userPwdTextField setSecureTextEntry:YES];
    [userPwdTextField setBackgroundColor:[UIColor whiteColor]];
    [userPwdTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userPwdTextField setTextColor:[UIColor blackColor]];
    [userPwdTextField setTextAlignment:NSTextAlignmentLeft];
    [userPwdTextField setReturnKeyType:UIReturnKeyNext];
    [userPwdTextField.layer setCornerRadius:3.0];
    userPwdTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [pwdIcon addSubview:userPwdTextField];
    UIImageView *required2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required2.image=[UIImage imageNamed:@"hits_star"];
    required2.contentMode=UIViewContentModeScaleAspectFit;
    [pwdIcon addSubview:required2];
    
    UIImageView *confirmIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, pwdIcon.frame.origin.y+pwdIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [confirmIcon setUserInteractionEnabled:YES];
    [confirmIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:confirmIcon];
    
    UILabel *confirmLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [confirmLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmLabel setText:@"确认密码"];
    [confirmLabel setTextAlignment:NSTextAlignmentLeft];
    [confirmLabel setTextColor:[UIColor blackColor]];
    [confirmIcon addSubview:confirmLabel];
    
    if (self.confirmTextField == nil) {
        confirmTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [confirmTextField setDelegate:self];
    [confirmTextField setPlaceholder:@"请再次输入密码"];
    [confirmTextField setSecureTextEntry:YES];
    [confirmTextField setBackgroundColor:[UIColor whiteColor]];
    [confirmTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [confirmTextField setTextColor:[UIColor blackColor]];
    [confirmTextField setTextAlignment:NSTextAlignmentLeft];
    [confirmTextField setReturnKeyType:UIReturnKeyNext];
    [confirmTextField.layer setCornerRadius:3.0];
    confirmTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [confirmIcon addSubview:confirmTextField];
    UIImageView *required3=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required3.image=[UIImage imageNamed:@"hits_star"];
    required3.contentMode=UIViewContentModeScaleAspectFit;
    [confirmIcon addSubview:required3];
    UIImageView *verifyCodeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, confirmIcon.frame.origin.y+confirmIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [verifyCodeIcon setUserInteractionEnabled:YES];
    [verifyCodeIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:verifyCodeIcon];
    
    UILabel *verifyCodeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [verifyCodeTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [verifyCodeTitleLabel setText:@"验证码"];
    [verifyCodeTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [verifyCodeTitleLabel setTextColor:[UIColor blackColor]];
    [verifyCodeIcon addSubview:verifyCodeTitleLabel];
    
    if (self.verifyCodeTextField == nil) {
        verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [verifyCodeTextField setDelegate:self];
    [verifyCodeTextField setPlaceholder:@"请输入验证码"];
    [verifyCodeTextField setBackgroundColor:[UIColor whiteColor]];
    [verifyCodeTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [verifyCodeTextField setTextColor:[UIColor blackColor]];
    [verifyCodeTextField setTextAlignment:NSTextAlignmentLeft];
    [verifyCodeTextField setReturnKeyType:UIReturnKeyDone];
    [verifyCodeTextField.layer setCornerRadius:3.0];
        [verifyCodeTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    verifyCodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [verifyCodeIcon addSubview:verifyCodeTextField];
    UIImageView *required4=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    required4.image=[UIImage imageNamed:@"hits_star"];
    required4.contentMode=UIViewContentModeScaleAspectFit;
    [verifyCodeIcon addSubview:required4];
    if (self.verifyCodeButton == nil) {
        verifyCodeButton = [[VerifyCodeView alloc] initWithFrame:CGRectMake(verifyCodeTextField.frame.size.width+verifyCodeTextField.frame.origin.x+10, 5, 60, 30.0)];
    }
    [verifyCodeIcon addSubview:verifyCodeButton];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, verifyCodeIcon.frame.size.height+verifyCodeIcon.frame.origin.y+40, 270, 49)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registerButton setTitle:@"下一步" forState:UIControlStateNormal];
    [registerButton addTarget:self
                       action:@selector(registerButtonClick)
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField==userNameTextField||textField==userPwdTextField||textField==confirmTextField)
    {
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:UserID]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
    }
    else
        return YES;
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerButtonClick
{
    BOOL isValid=YES;
    
    if (userNameTextField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"用户名不能为空！"];
    }
    else if(userNameTextField.text.length<6)
    {
        isValid=NO;
        [self.navigationController.view makeToast:@"用户名长度必须大于等于6位"];
    }
    else if (userPwdTextField.text.length == 0) {
        isValid=NO;

        [self.navigationController.view makeToast:@"密码不能为空！"];
    }
    else if(userPwdTextField.text.length<6)
    {
        isValid=NO;
        [self.navigationController.view makeToast:@"密码长度必须大于等于6位"];
    }
    else if (confirmTextField.text.length == 0) {
        isValid=NO;

        [self.navigationController.view makeToast:@"确认密码不能为空！"];
    }else if (![userPwdTextField.text isEqualToString:confirmTextField.text]) {
        isValid=NO;

        [self.navigationController.view makeToast:@"两次输入密码不一致！"];
        [confirmTextField setText:@""];
    }else if (verifyCodeTextField.text.length == 0) {
        isValid=NO;

        [self.navigationController.view makeToast:@"验证码不能为空！"];
        [self.verifyCodeButton changeVerifyCode];
    }else if (![verifyCodeTextField.text.uppercaseString isEqualToString:verifyCodeButton.codeStr.uppercaseString]) {
        isValid=NO;

        [self.navigationController.view makeToast:@"输入验证码不正确！"];
        [verifyCodeTextField setText:@""];
        [self.verifyCodeButton changeVerifyCode];
    }
    if(isValid){
        RegisterThirdStepViewController *registerViewController = [[RegisterThirdStepViewController alloc] init];
        self.registerInfo.USUS_ID = userNameTextField.text;
        self.registerInfo.USUS_PWD = userPwdTextField.text;
        registerViewController.registerInfo = self.registerInfo;
        [self.navigationController pushViewController:registerViewController animated:YES];
        
        
    }
}



- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    [userNameTextField resignFirstResponder];
    [userPwdTextField resignFirstResponder];
    [confirmTextField resignFirstResponder];
    [verifyCodeTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.userNameTextField = nil;
    self.userPwdTextField = nil;
    self.confirmTextField = nil;
    self.verifyCodeTextField = nil;
    self.verifyCodeButton = nil;
    self.commonUtil = nil;
    self.registerInfo = nil;
}

@end
