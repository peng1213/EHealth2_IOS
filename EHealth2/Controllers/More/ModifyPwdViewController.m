//
//  ModifyPwdViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/31.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//
#define UserID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\n"
#import "ModifyPwdViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "Pub.h"


@interface ModifyPwdViewController ()
@property (nonatomic, strong) UITextField *curPwdField;
@property (nonatomic, strong) UITextField *confirmPwdField;
@property (nonatomic, strong) UITextField *pwdTextField;

- (void)backToPreViewController;
- (void)confirmButtonClick;
- (void)tapGesture:(UITapGestureRecognizer *)sender;

@end

@implementation ModifyPwdViewController
@synthesize curPwdField;
@synthesize confirmPwdField;
@synthesize pwdTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [titleLable setText:@"修改密码"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];

    UIImageView *curPwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,84.0f,self.view.frame.size.width,40.0)];
    [curPwdImageView setContentMode:UIViewContentModeScaleAspectFill];
    [curPwdImageView setUserInteractionEnabled:YES];
    [curPwdImageView setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:curPwdImageView];
    
    UILabel *curPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [curPwdLabel setBackgroundColor:[UIColor clearColor]];
    [curPwdLabel setFont:[UIFont systemFontOfSize:15]];
    [curPwdLabel setText:@"当前密码"];
    [curPwdLabel setTextAlignment:NSTextAlignmentLeft];
    [curPwdLabel setTextColor:[UIColor blackColor]];
    [curPwdImageView addSubview:curPwdLabel];
    
    if (self.curPwdField == nil) {
        curPwdField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5.0, 210, 30)];
    }
    [curPwdField setDelegate:self];
    [curPwdField setPlaceholder:@"请输入原密码"];
    [curPwdField setSecureTextEntry:YES];
    [curPwdField setBackgroundColor:[UIColor whiteColor]];
    [curPwdField setFont:[UIFont systemFontOfSize:13.0f]];
    [curPwdField setTextColor:[UIColor blackColor]];
    [curPwdField setTextAlignment:NSTextAlignmentLeft];
    curPwdField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [curPwdField setReturnKeyType:UIReturnKeyDone];
    [curPwdField.layer setCornerRadius:3.0];
    [curPwdImageView addSubview:curPwdField];
    
    UIImageView *newPwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,curPwdImageView.frame.origin.y+curPwdImageView.frame.size.height+40,self.view.frame.size.width,40.0)];
    [newPwdImageView setUserInteractionEnabled:YES];
    [newPwdImageView setContentMode:UIViewContentModeScaleAspectFill];
    [newPwdImageView setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:newPwdImageView];
    
    UILabel *note=[[UILabel alloc]initWithFrame:CGRectMake(5, curPwdImageView.frame.origin.y+curPwdImageView.frame.size.height, self.view.frame.size.width-5, 40)];
    note.text=@"密码必须为大于6位字母或数字组合,不能包含中文和特殊符号";
    note.font=[UIFont systemFontOfSize:10];
    note.textColor=[UIColor lightGrayColor];
    note.numberOfLines=0;
    [self.view addSubview:note];
    
    UILabel *newPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [newPwdLabel setBackgroundColor:[UIColor clearColor]];
    [newPwdLabel setFont:[UIFont systemFontOfSize:15]];
    [newPwdLabel setText:@"新密码"];
    [newPwdLabel setTextAlignment:NSTextAlignmentLeft];
    [newPwdLabel setTextColor:[UIColor blackColor]];
    [newPwdImageView addSubview:newPwdLabel];
    
    if (self.pwdTextField == nil) {
        pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5.0, 210, 30)];
    }
    [pwdTextField setDelegate:self];
    [pwdTextField setPlaceholder:@"请输入新密码"];
    [pwdTextField setSecureTextEntry:YES];
    [pwdTextField setBackgroundColor:[UIColor whiteColor]];
    [pwdTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [pwdTextField setTextColor:[UIColor blackColor]];
    [pwdTextField setTextAlignment:NSTextAlignmentLeft];
    pwdTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [pwdTextField setReturnKeyType:UIReturnKeyDone];
    [pwdTextField.layer setCornerRadius:3.0];
    [newPwdImageView addSubview:pwdTextField];
    
    UIImageView *confirmPwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,newPwdImageView.frame.origin.y+newPwdImageView.frame.size.height+9,self.view.frame.size.width,40.0)];
    [confirmPwdImageView setUserInteractionEnabled:YES];
    [confirmPwdImageView setContentMode:UIViewContentModeScaleAspectFill];
    [confirmPwdImageView setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [self.view addSubview:confirmPwdImageView];
    
    UILabel *confirmPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 90.0, 40.0)];
    [confirmPwdLabel setBackgroundColor:[UIColor clearColor]];
    [confirmPwdLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmPwdLabel setText:@"确认密码"];
    [confirmPwdLabel setTextAlignment:NSTextAlignmentLeft];
    [confirmPwdLabel setTextColor:[UIColor blackColor]];
    [confirmPwdImageView addSubview:confirmPwdLabel];
    
    if (self.confirmPwdField == nil) {
        confirmPwdField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5.0, 210, 30)];
    }
    [confirmPwdField setDelegate:self];
    [confirmPwdField setPlaceholder:@"再次输入新密码"];
    [confirmPwdField setSecureTextEntry:YES];
    [confirmPwdField setBackgroundColor:[UIColor whiteColor]];
    [confirmPwdField setFont:[UIFont systemFontOfSize:13.0f]];
    [confirmPwdField setTextAlignment:NSTextAlignmentLeft];
    confirmPwdField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [confirmPwdField setReturnKeyType:UIReturnKeyDone];
    [confirmPwdField.layer setCornerRadius:3.0];
    [confirmPwdImageView addSubview:confirmPwdField];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(30, confirmPwdImageView.frame.origin.y+confirmPwdImageView.frame.size.height+20, self.view.frame.size.width-60, 44)];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitle:@"确 认 修 改" forState:UIControlStateNormal];
    [confirmButton addTarget:self
                      action:@selector(confirmButtonClick)
            forControlEvents:UIControlEventTouchUpInside];
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
    [curPwdField resignFirstResponder];
    [confirmPwdField resignFirstResponder];
    [pwdTextField resignFirstResponder];
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField==pwdTextField)
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

- (void)confirmButtonClick
{
    
    if (curPwdField.text.length == 0) {
        [self.navigationController.view makeToast:@"您输入的密码不能为空！"];
    }else if (pwdTextField.text.length == 0) {
        [self.navigationController.view makeToast:@"您输入的新密码不能为空！"];
    }
    else if(pwdTextField.text.length<6)
    {
        [self.navigationController.view makeToast:@"密码长度必须大于等于6位"];
    }else if (confirmPwdField.text.length == 0){
        [self.navigationController.view makeToast:@"您输入的确认密码不能为空！"];
    }else if (![pwdTextField.text isEqualToString:confirmPwdField.text]){
        [self.navigationController.view makeToast:@"两次输入的密码不一致！"];
        [confirmPwdField setText:@""];
        [confirmPwdField becomeFirstResponder];
    }else {
        TUserInfo * userModel=[[TUserInfo alloc] init];
        NSString * cacheStr=[[ConfigTool Instance] getCacheWithKey:cache_user_login ];
        userModel=[[JsonTool defaultTool] getTUserInfoEntity:cacheStr withKey:@"model"];
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_user_changepwd];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: userModel.USUS_KY forKey: @"USUS_KY"];
        [request setPostValue: [CommonUtil MD5:curPwdField.text]  forKey: @"USUS_PWD"];
        [request setPostValue: [CommonUtil MD5:pwdTextField.text] forKey: @"NEW_PWD"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
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
    [self.navigationController.view makeToast:@"网络异常！"];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        
        //获取TUSERINFO对象
//        TUserInfo *usermodel=[[TUserInfo alloc] init];
//        usermodel=[[JsonTool defaultTool] getTUserInfoEntity:request.responseString withKey:@"model"];
//        NSLog(@"USUS_ID:%@",usermodel.USUS_ID);
        [SVProgressHUD dismiss];
        [self.navigationController.view makeToast:@"密码修改成功！请重新登录！"];
        LoginViewController *homeviewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:homeviewController animated:YES];
        
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

- (void)dealloc
{
    self.curPwdField = nil;
    self.confirmPwdField = nil;
    self.pwdTextField = nil;
}

@end
