//
//  RegisterThirdStepViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "RegisterThirdStepViewController.h"
#import "LoginViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "Pub.h"


@interface RegisterThirdStepViewController ()
@property (nonatomic, strong) UITextField *userTelTextField;
@property (nonatomic, strong) UITextField *userEmailTextField;
@property (nonatomic, strong) UITextField *userAddressTextField;
@property (nonatomic, strong) UITextField *userCodeTextField;
@property (nonatomic, strong) CommonUtil *commonUtil;

- (void)tapGesture:(UITapGestureRecognizer *)sender;
- (void)confirmRegister;
- (void)backToPreViewController;
@end

@implementation RegisterThirdStepViewController
@synthesize registerInfo;
@synthesize userTelTextField;
@synthesize userEmailTextField;
@synthesize userAddressTextField;
@synthesize userCodeTextField;
@synthesize commonUtil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.registerInfo == nil) {
            registerInfo = [[TUserInfo alloc] init];
        }
        
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
    NSLog(@"self.view.frame.size.width=%f\nregisterInfo=%@",self.view.frame.size.width,self.registerInfo.USUS_NAME);
    self.navigationItem.title=@"联系信息";
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
    [self.view addSubview:headerView];
    
    
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
    [comfirmImageView setImage:[UIImage imageNamed:@"register_finish_hight_icon.png"]];
    [headerView addSubview:comfirmImageView];
    UILabel *comfirmInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*3)/2.0*2, 48+16, 64, 20)];
    [comfirmInfoLable setText:@"联系信息"];
    [comfirmInfoLable setTextAlignment:NSTextAlignmentCenter];
    [comfirmInfoLable setFont:[UIFont systemFontOfSize:13]];
    [comfirmInfoLable setTextColor:[UIColor lightGrayColor]];
    [headerView addSubview:comfirmInfoLable];
    [self.view addSubview:headerView];

    
    UIImageView *telPhoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, headerView.frame.origin.y+headerView.frame.size.height+20, self.view.frame.size.width, 40.0)];
    [telPhoneIcon setUserInteractionEnabled:YES];
    [telPhoneIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:telPhoneIcon];
    
    UILabel *telPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [telPhoneLabel setFont:[UIFont systemFontOfSize:15]];
    [telPhoneLabel setText:@"手机号码"];
    [telPhoneLabel setTextAlignment:NSTextAlignmentLeft];
    [telPhoneLabel setTextColor:[UIColor blackColor]];
    [telPhoneIcon addSubview:telPhoneLabel];
    
    if (self.userTelTextField == nil) {
        userTelTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userTelTextField setPlaceholder:@"请输入手机号码"];
    [userTelTextField setBackgroundColor:[UIColor whiteColor]];
    [userTelTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userTelTextField setTextColor:[UIColor blackColor]];
    [userTelTextField setTextAlignment:NSTextAlignmentLeft];
    [userTelTextField setKeyboardType:UIKeyboardTypePhonePad];
    [userTelTextField setReturnKeyType:UIReturnKeyNext];
    [userTelTextField.layer setCornerRadius:3.0];
    userTelTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [telPhoneIcon addSubview:userTelTextField];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, telPhoneIcon.frame.origin.y+telPhoneIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [emailIcon setUserInteractionEnabled:YES];
    [emailIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:emailIcon];
    
    UILabel *emialLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [emialLabel setFont:[UIFont systemFontOfSize:15]];
    [emialLabel setText:@"电子邮箱"];
    [emialLabel setTextAlignment:NSTextAlignmentLeft];
    [emialLabel setTextColor:[UIColor blackColor]];
    [emailIcon addSubview:emialLabel];
    
    if (self.userEmailTextField == nil) {
        userEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userEmailTextField setPlaceholder:@"请输入电子邮箱"];
    [userEmailTextField setBackgroundColor:[UIColor whiteColor]];
    [userEmailTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userEmailTextField setTextColor:[UIColor blackColor]];
    [userEmailTextField setTextAlignment:NSTextAlignmentLeft];
    [userEmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [userEmailTextField setReturnKeyType:UIReturnKeyNext];
    [userEmailTextField.layer setCornerRadius:3.0];
    userEmailTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [emailIcon addSubview:userEmailTextField];
    
    
    UIImageView *addressIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, emailIcon.frame.origin.y+emailIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [addressIcon setUserInteractionEnabled:YES];
    [addressIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:addressIcon];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [addressLabel setFont:[UIFont systemFontOfSize:15]];
    [addressLabel setText:@"地址"];
    [addressLabel setTextAlignment:NSTextAlignmentLeft];
    [addressLabel setTextColor:[UIColor blackColor]];
    [addressIcon addSubview:addressLabel];
    
    if (self.userAddressTextField == nil) {
        userAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userAddressTextField setPlaceholder:@"请输入地址"];
    [userAddressTextField setBackgroundColor:[UIColor whiteColor]];
    [userAddressTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userAddressTextField setTextColor:[UIColor blackColor]];
    [userAddressTextField setTextAlignment:NSTextAlignmentLeft];
    [userAddressTextField setReturnKeyType:UIReturnKeyNext];
    [userAddressTextField.layer setCornerRadius:3.0];
    userAddressTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [addressIcon addSubview:userAddressTextField];
    
    
    UIImageView *codeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, addressIcon.frame.origin.y+addressIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [codeIcon setUserInteractionEnabled:YES];
    [codeIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:codeIcon];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [codeLabel setFont:[UIFont systemFontOfSize:15]];
    [codeLabel setText:@"邮编"];
    [codeLabel setTextAlignment:NSTextAlignmentLeft];
    [codeLabel setTextColor:[UIColor blackColor]];
    [codeIcon addSubview:codeLabel];
    
    if (self.userCodeTextField == nil) {
        userCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2.0, 5, 150, 30)];
    }
    [userCodeTextField setPlaceholder:@"请输入邮政编码"];
    [userCodeTextField setBackgroundColor:[UIColor whiteColor]];
    [userCodeTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userCodeTextField setTextColor:[UIColor blackColor]];
    [userCodeTextField setTextAlignment:NSTextAlignmentLeft];
    [userCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [userCodeTextField setReturnKeyType:UIReturnKeyDone];
    [userCodeTextField.layer setCornerRadius:3.0];
    userCodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [codeIcon addSubview:userCodeTextField];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, codeIcon.frame.size.height+codeIcon.frame.origin.y+40, 270, 49)];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton setTitle:@"确 认 注 册" forState:UIControlStateNormal];
    [confirmButton addTarget:self
                    action:@selector(confirmRegister)
          forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];

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
    [userAddressTextField resignFirstResponder];
    [userCodeTextField resignFirstResponder];
    [userEmailTextField resignFirstResponder];
    [userTelTextField resignFirstResponder];
}

- (void)confirmRegister
{
    BOOL isValid=YES;
    if(isValid){
        
        registerInfo.USUS_ADDRESS=self.userAddressTextField.text;
        registerInfo.USUS_EMAIL=self.userEmailTextField.text;
        registerInfo.USUS_ZIPCODE=self.userCodeTextField.text;
        registerInfo.USUS_MOBILE_NO=self.userTelTextField.text;
        
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString: api_user_reg];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: registerInfo.USUS_ID forKey: @"USUS_ID"];
        [request setPostValue: [CommonUtil MD5:registerInfo.USUS_PWD]  forKey: @"USUS_PWD"];
        [request setPostValue: registerInfo.USUS_MOBILE_NO forKey: @"USUS_MOBILE_NO"];
        [request setPostValue: registerInfo.USUS_EMAIL forKey: @"USUS_EMAIL"];
        [request setPostValue: registerInfo.USUS_ADDRESS forKey: @"USUS_ADDRESS"];
        [request setPostValue: registerInfo.USUS_ZIPCODE forKey: @"USUS_ZIPCODE"];
            [request setPostValue: registerInfo.USUS_VIP_ID forKey: @"USUS_VIP_ID"];
            [request setPostValue: registerInfo.USUS_CERT_NO forKey: @"USUS_CERT_NO"];
            [request setPostValue: registerInfo.USUS_TYPE forKey: @"USUS_TYPE"];
            [request setPostValue: registerInfo.USUS_STATUS forKey: @"USUS_STATUS"];
            [request setPostValue: registerInfo.COMP_ID forKey: @"COMP_ID"];
            [request setPostValue: registerInfo.COMP_NAME forKey: @"COMP_NAME"];
            [request setPostValue: registerInfo.USUS_MNG_ID forKey: @"USUS_MNG_ID"];
            [request setPostValue: registerInfo.USUS_MNG_NAME forKey: @"USUS_MNG_NAME"];
            [request setPostValue: registerInfo.GPGP_KY forKey: @"GPGP_KY"];
            [request setPostValue: registerInfo.GPGP_NAME forKey: @"GPGP_NAME"];
            [request setPostValue: registerInfo.MEME_KY forKey: @"MEME_KY"];
            [request setPostValue: registerInfo.MEME_AGE forKey: @"MEME_AGE"];
            [request setPostValue: registerInfo.MEME_SEX forKey: @"MEME_SEX"];
            [request setPostValue: registerInfo.USUS_CREATE_DT forKey: @"USUS_CREATE_DT"];
            [request setPostValue: registerInfo.USUS_NEXT_ELOGIN_DT forKey: @"USUS_NEXT_ELOGIN_DT"];
            [request setPostValue: registerInfo.USUS_NAME forKey: @"USUS_NAME"];
        
        
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
    
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        [SVProgressHUD dismiss];
        TUserInfo *reg=[[TUserInfo alloc] init];
        reg= [[JsonTool defaultTool] getTUserInfoEntity:request.responseString withKey:@"model"];
        
        [[ConfigTool Instance] saveUserName:reg.USUS_ID andPassword:reg.USUS_PWD];
        //注册肯定是从登陆页面过来的
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功"
                                                        message:@"注册成功，点击确定返回登录界面。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
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
/*ASIHttp异步请求 结束*/



- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    self.registerInfo = nil;
    self.userTelTextField = nil;
    self.userEmailTextField = nil;
    self.userCodeTextField = nil;
    self.userAddressTextField = nil;
}

@end
