//
//  LoginViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/25.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequestConfig.h"
#import "ASIDownloadCache.h"
#import "AppDelegate.h"
#import "JsonTool.h"
#import "ConfigTool.h"
#import "TResult.h"
#import "LoginViewController.h"
#import "CommonUtil.h"
#import "RegisterFirstStepViewController.h"
#import "SVProgressHUD.h"
#import "Pub.h"
#import <UIKit/UIKit.h>
#import "WelcomViewController.h"
#import "HealthViewController.h"
#import "AssistantViewController.h"
#import "MoreViewController.h"
#import "FMDB.h"
#import "UIKeyboardViewController.h"
#import "FindPwdCheckViewController.h"
#import "UIWindow+YzdHUD.h"

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface LoginViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSString* compID;
    NSString* appName;
    BMKLocationService *_locService;
    BMKGeoCodeSearch* _geocodesearch;
    UIButton* btnChecked;
    UIKeyboardViewController *keyBoardController;
    NSMutableArray *bannerList;
}

- (void)hideTheKeyBoard:(UITapGestureRecognizer*)tapgesture;
- (void)rememberButtonClick:(UIButton *)sender;
@end

@implementation LoginViewController
@synthesize userTextField;
@synthesize userPwdTextField;

// 01.初始化界面
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    compID= [plistDic objectForKey:@"COMP_ID"];
    appName=[plistDic objectForKey:@"APP_NAME"];
    // 设置当前的view的背景为F0F0F0 透明度1.0
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    //开始设置登录界面的背景图片 self.view.frame.size.width 表示符合屏幕大小
    UIImageView *loginBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,64,self.view.frame.size.width,self.view.frame.size.height-64)];
    [loginBg setContentMode:UIViewContentModeScaleAspectFill];
    [loginBg setImage:[UIImage imageNamed:@"login_background.png"]];
    [loginBg setUserInteractionEnabled:YES];
    [self.view addSubview:loginBg]; //添加到当前view中
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70 , 27.0, 60.0, 30.0)];
    [backButton setTitle:@"注册" forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(registerPrimeHealth)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:backButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,10.0f,self.view.frame.size.width-80,64.0f)];
    [titleLable setText:@"登录"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置登录背景滑动手势 当手势滑动的时候 隐藏键盘 其方法为 hideTheKeyBoard
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(hideTheKeyBoard:)];
    [tapgesture setNumberOfTapsRequired:1];
    [tapgesture setNumberOfTouchesRequired:1];
    [loginBg addGestureRecognizer:tapgesture];
    
    //定义app的图标
    UIImageView  *appIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75.0f, self.view.frame.size.width, 97)];
    [appIcon setContentMode:UIViewContentModeScaleAspectFit];
    NSString *compICON=[NSString stringWithFormat:@"%@%@",@"comp_icon_",compID];
    [appIcon setImage:[UIImage imageNamed:compICON]];
    [self.view addSubview:appIcon];
    
    //定义名称图标
    UIImageView  *appLableIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, appIcon.frame.origin.y+appIcon.frame.size.height+12, self.view.frame.size.width, 32)];
    [appLableIcon setContentMode:UIViewContentModeScaleAspectFit];
    NSString *compName=[NSString stringWithFormat:@"%@%@",@"comp_name_",compID];
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    bool demoUser= [settings boolForKey:@"demoUser"];
    if(demoUser)
        [appLableIcon setImage:[UIImage imageNamed:compName]];
    [self.view addSubview:appLableIcon];
    
    //定义名称图标
    UILabel  *appvnameIcon = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-400)/2.0, appLableIcon.frame.origin.y+appLableIcon.frame.size.height+12, 400.0f, 23.5f)];
    [appvnameIcon setTextColor:[UIColor darkGrayColor]];
    [appvnameIcon setText:appName];
    [appvnameIcon setFont:[UIFont systemFontOfSize:22]];
    [appvnameIcon setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:appvnameIcon];
    //
    //    //定义名字图标
    //    UIImageView *appNameLableIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-96)/2.0, appLableIcon.frame.size.height+appLableIcon.frame.origin.y+5, 96, 16)];
    //    [appNameLableIcon setImage:[UIImage imageNamed:@"login_en_login_name_icon.png"]];
    //    [self.view addSubview:appNameLableIcon];
    
    //定义text文本背景图片
    UIImageView  *loginTextFieldBG = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, appvnameIcon.frame.origin.y+appvnameIcon.frame.size.height+30, 270, 42)];
    
    [loginTextFieldBG setImage:[UIImage imageNamed:@"login_username_input_background.png"]];
    [loginTextFieldBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginTextFieldBG];
    
    //定义密码背景图片
    UIImageView  *loginPwdInputBG = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, loginTextFieldBG.frame.origin.y+loginTextFieldBG.frame.size.height, 270, 42)];
    
    [loginPwdInputBG setImage:[UIImage imageNamed:@"login_userpwd_input_background.png"]];
    [loginPwdInputBG setUserInteractionEnabled:YES];
    [self.view addSubview:loginPwdInputBG];
    
    //定义用户名前面的小图标
    UIImageView  *userNameFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (loginTextFieldBG.frame.size.height-25)/2.0, 25, 25)];
    
    [userNameFieldIcon setImage:[UIImage imageNamed:@"login_username_icon.png"]];
    [loginTextFieldBG addSubview:userNameFieldIcon];
    
    //定义密码前面的小图标
    UIImageView  *userPwdFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (loginPwdInputBG.frame.size.height-25)/2.0, 25, 25)];
    
    [userPwdFieldIcon setImage:[UIImage imageNamed:@"login_userpwd_icon.png"]];
    [loginPwdInputBG addSubview:userPwdFieldIcon];
    
    //定义用户名输入框
    if (self.userTextField == nil) {
        userTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [userTextField setDelegate:self];
    [userTextField setPlaceholder:@"请输入您的用户名"];
    [userTextField setBackgroundColor:[UIColor whiteColor]];
    [userTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userTextField setTextColor:[UIColor blackColor]];
    [userTextField setTextAlignment:NSTextAlignmentLeft];
    [userTextField setReturnKeyType:UIReturnKeyNext];
    [userTextField.layer setCornerRadius:3.0];
    [loginTextFieldBG addSubview:userTextField];
    
    //定义密码输入框
    if (self.userPwdTextField == nil) {
        userPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, (loginTextFieldBG.frame.size.height-30)/2.0, 215, 30)];
    }
    [userPwdTextField setDelegate:self];
    [userPwdTextField setPlaceholder:@"密码"];
    [userPwdTextField setSecureTextEntry:YES];
    [userPwdTextField setBackgroundColor:[UIColor whiteColor]];
    [userPwdTextField setFont:[UIFont systemFontOfSize:13.0f]];
    [userPwdTextField setTextColor:[UIColor blackColor]];
    [userPwdTextField setTextAlignment:NSTextAlignmentLeft];
    [userPwdTextField setReturnKeyType:UIReturnKeyDone];
    [userPwdTextField.layer setCornerRadius:3.0];
    [loginPwdInputBG addSubview:userPwdTextField];
    
    //定义记住密码
    //    UILabel *rememberLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-60)/2.0+(215-45)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+4, 80, 35)];
    //    [rememberLabel setTextAlignment:NSTextAlignmentRight];
    //    [rememberLabel setFont:[UIFont systemFontOfSize:15]];
    //    [rememberLabel setTextColor:[UIColor whiteColor]];
    //    [rememberLabel setText:@"记住用户名"];
    //    [self.view addSubview:rememberLabel];
    //
    //    //定义记住密码按钮
    //    UIButton *rememberButton = [[UIButton alloc] initWithFrame:CGRectMake(rememberLabel.frame.origin.x-30.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+7, 30.0, 30.0)];
    //    [rememberButton setBackgroundColor:[UIColor whiteColor]];
    //    [rememberButton addTarget:self
    //                       action:@selector(rememberButtonClick:)
    //             forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:rememberButton];
    
    //定义登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+15, 270, 42)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self
                    action:@selector(loginPrimeHealth)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    //定义找回密码按钮
    //    UIButton *forgetPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-90)/2.0-(215-45)/2.0, loginPwdInputBG.frame.size.height+loginPwdInputBG.frame.origin.y+75, 90, 35)];
    //    [forgetPwdBtn setBackgroundColor:[UIColor clearColor]];
    //    [forgetPwdBtn setTitleColor:[CommonUtil getColor:@"1669BC" withAlpha:1.0] forState:UIControlStateNormal];
    //    [forgetPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    [forgetPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    //    [forgetPwdBtn addTarget:self
    //                    action:@selector(findPwd)
    //          forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:forgetPwdBtn];
    
    //定义注册按钮
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginButton.frame.origin.x, loginButton.frame.size.height+loginButton.frame.origin.y+20, 90, 35)];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn setTitleColor:[CommonUtil getColor:@"1669BC" withAlpha:1.0] forState:UIControlStateNormal];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registerBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [registerBtn addTarget:self
                    action:@selector(findPwd)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    btnChecked = [[UIButton alloc] initWithFrame:CGRectMake(loginButton.frame.origin.x+loginButton.frame.size.width-120, loginButton.frame.size.height+loginButton.frame.origin.y+25, 25, 25)];
    [btnChecked setContentMode:UIViewContentModeScaleAspectFit];
    [btnChecked setImage:[UIImage imageNamed:@"comon_checkbox_default"]forState:UIControlStateNormal];
    [btnChecked setImage:[UIImage imageNamed:@"comon_checkbox_focused"]forState:UIControlStateSelected];
    [btnChecked addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChecked];
    UIButton *rember=[[UIButton alloc]initWithFrame:CGRectMake(btnChecked.frame.origin.x+btnChecked.frame.size.width, loginButton.frame.size.height+loginButton.frame.origin.y+20, 80, 35)];
    [rember setBackgroundColor:[UIColor clearColor]];
    [rember setTitleColor:[CommonUtil getColor:@"1669BC" withAlpha:1.0] forState:UIControlStateNormal];
    [rember.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rember setTitle:@"记住用户名" forState:UIControlStateNormal];
    [rember addTarget:self
               action:@selector(remberUser)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rember];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //    //启动LocationService
    [_locService startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate=self;
    //获取初始化值
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    BOOL rememberUSUS_ID=[defaults boolForKey:@"rememberUSUS_ID"];
    btnChecked.selected=rememberUSUS_ID;
    
    NSString *name = [ConfigTool Instance].getUserName;
    NSString *pwd = [ConfigTool Instance].getPassword;
    if (name && ![name isEqualToString:@""]&&rememberUSUS_ID) {
        self.userTextField.text = name;
        
        //self.userPwdTextField.text=pwd;
    }
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
}



-(void)checkboxClick:(UIButton*)btn{
    btn.selected=!btn.selected;//每次点击都改变按钮的状态
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:btn.selected forKey:@"rememberUSUS_ID"];
}

-(void)remberUser
{
    [self checkboxClick:btnChecked];
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        AppDelegate *delegate=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.province= result.addressDetail.province;
        delegate.city= result.addressDetail.city;
        delegate.district= result.addressDetail.district;
        
        NSMutableString *String1 = [[NSMutableString alloc] initWithString:delegate.city];
        NSString *city1= [String1 stringByReplacingOccurrencesOfString:@"市" withString:@""];
        NSMutableString *String2 = [[NSMutableString alloc] initWithString:city1];
        NSString *city2=[String2 stringByReplacingOccurrencesOfString:@"自治州" withString:@""];
        NSMutableString *String3 = [[NSMutableString alloc] initWithString:city2];
        NSString *city3=[String3 stringByReplacingOccurrencesOfString:@"盟" withString:@""];
        NSMutableString *String4 = [[NSMutableString alloc] initWithString:city3];
        NSString *city4=[String4 stringByReplacingOccurrencesOfString:@"地区" withString:@""];
        
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"db"];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        if (![db open]) {
            NSLog(@"数据库打开失败！");
        }
        NSString *sql=[NSString stringWithFormat:@"SELECT min(code)as code FROM china_city_code where city='%@' group by city",city4];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *code = [rs stringForColumn:@"code"];
            [[ConfigTool Instance]saveWeaherCity:result.addressDetail.city andCode:code];
        }
    }
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    [_locService stopUserLocationService ];
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位错误！");
}

// 记住密码事件
- (void)rememberButtonClick:(UIButton *)sender
{
    
}

#pragma mark --
#pragma mark --UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    if (textField == self.userTextField) {
        viewFrame.origin.y = -30;
    }else if (textField == self.userPwdTextField) {
        viewFrame.origin.y = -60;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = viewFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
    return YES;
}

- (void)hideTheKeyBoard
{
    [self.userTextField resignFirstResponder];
    [self.userPwdTextField resignFirstResponder];
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = viewFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==userTextField)
    {
        [userPwdTextField becomeFirstResponder];
    }
    else if(textField.text.length>0)
    {
        [self loginPrimeHealth];
    }
    return YES;
}

/**
 *  隐藏键盘
 *
 *  @param tapgesture
 */
- (void)hideTheKeyBoard:(UITapGestureRecognizer*)tapgesture
{
    [self hideTheKeyBoard];
}

/**
 *  忘记密码
 */
- (void)findPwd{
    FindPwdCheckViewController *vc=[[FindPwdCheckViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  账户注册
 */
- (void)registerPrimeHealth
{
    RegisterFirstStepViewController *registerViewController = [[RegisterFirstStepViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

/**
 *  用户登录
 */
- (void)loginPrimeHealth
{
    //01.获取UI的输入值
    NSString *usus_id=userTextField.text;
    NSString *usus_pwd=[CommonUtil MD5:userPwdTextField.text];
    //02.处理键盘事件
    [self hideTheKeyBoard];
    //03.判断输入值是否正确合法
    BOOL isValid=YES;
    if (userTextField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"用户账号不能为空！"];
    }else if (userPwdTextField.text.length == 0) {
        isValid=NO;
        [self.navigationController.view makeToast:@"用户密码不能为空！"];
    }
    //04.如果一切正确 那么进行异步通讯
    if(isValid) {
        //[self goMain];
        
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_user_login];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: usus_id forKey: @"USUS_ID"];
        [request setPostValue: usus_pwd forKey: @"USUS_PWD"];
        
        [request setPostValue: [NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice]systemName],[[UIDevice currentDevice]systemVersion]]  forKey: @"LOGIN_CLIENT_TYPE"];
        [request setPostValue: [[UIDevice currentDevice]model] forKey: @"LOGIN_CLIENT_MODEL"];
        [request setPostValue: @"暂未获取" forKey: @"LOGIN_MACID"];
        
        AppDelegate *delegate=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [request setPostValue:  delegate.province forKey: @"LOGIN_PROVINCE"];
        [request setPostValue:  delegate.city  forKey: @"LOGIN_CITY"];
        [request setPostValue:  delegate.district  forKey: @"LOGIN_COUNTY"];
        [request setPostValue: delegate.COMP_ID forKey: @"COMP_ID"];
        NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        [request setPostValue:[NSString stringWithFormat:@"%@:%@",identifier,currentVersion] forKey: @"VERSION"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setTag:10000];
        [request setValidatesSecureCertificate:NO];
        [request setDelegate:self];
        [request startAsynchronous];
        //显示进度滚动
        [SVProgressHUD show];
        
    }
}

- (void)getBanner
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url =[NSURL URLWithString:api_banner_get];
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
    [request setPostValue: delegate.COMP_ID forKey: @"COMP_ID"];
    [request setPostValue: delegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request setTag:10001];
    [request buildPostBody];
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    [request startAsynchronous];
}

//跳转主页
-(void)goMain
{
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    UITabBar *tabBar=tabBarController.tabBar;
    tabBar.tintColor=[UIColor colorWithRed:39.0f/255.0f green:174.0f/255.0f blue:96.0f/255.0f alpha:1];
    WelcomViewController *c1=[[WelcomViewController alloc]init];
    c1.tabBarItem.title=@"主页";
    c1.tabBarItem.image=[UIImage imageNamed:@"tab_ico_home"];
    c1.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_ico_home_focus"];
    c1.bannerList=bannerList;
    
    HealthViewController *c2=[[HealthViewController alloc]init];
    c2.tabBarItem.title=@"健康";
    c2.tabBarItem.image=[UIImage imageNamed:@"tab_ico_health"];
    c2.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_ico_health_focus"];
    
    AssistantViewController *c3=[[AssistantViewController alloc]init];
    c3.tabBarItem.title=@"助手";
    c3.tabBarItem.image=[UIImage imageNamed:@"tab_ico_assistant"];
    c3.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_ico_assistant_focus"];
    
    MoreViewController *c4=[[MoreViewController alloc]init];
    c4.tabBarItem.title=@"更多";
    c4.tabBarItem.image=[UIImage imageNamed:@"tab_ico_more"];
    c4.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_ico_more_focus"];
    
    tabBarController.viewControllers=@[c1,c2,c3,c4];
    [self.navigationController pushViewController:tabBarController animated:YES];
}
/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(request.error.description);
    [self.navigationController.view makeToast:[NSString stringWithFormat:@"网络异常!"]];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    //清除历史缓存
    
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(request.tag==10000)
    {
        if(model.ResultCode==0 ){
            [[ConfigTool Instance] removeCacheWithKey:@"cache_user_login"];
            [[ConfigTool Instance] saveCacheWithKey:@"cache_user_login" andData:request.responseString];
            NSString *usus_id=userTextField.text;
            NSString *usus_pwd=userPwdTextField.text;
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if([CommonUtil contains:usus_id conStr:@"testdemo"])
            {
                [defaults removeObjectForKey:@"demoUser"];
                [defaults setBool:false forKey:@"demoUser"];
            }
            else
            {
                [defaults removeObjectForKey:@"demoUser"];
                [defaults setBool:true forKey:@"demoUser"];
            }
            
            BOOL rememberUSUS_ID=[defaults boolForKey:@"rememberUSUS_ID"];
            if(rememberUSUS_ID)
                [[ConfigTool Instance] saveUserName:usus_id andPassword:usus_pwd];
            //换成当前返回结果json字符串以备后面使用
            [[ConfigTool Instance] saveCacheWithKey:cache_user_login andData:request.responseString];
            //获取TUSERINFO对象
            TUserInfo *usermodel=[[TUserInfo alloc] init];
            usermodel=[[JsonTool defaultTool] getTUserInfoEntity:request.responseString withKey:@"model"];
            AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
            appDelegate.token=usermodel.token;
            appDelegate.User=usermodel;
            [self getBanner];
        }else{
            [SVProgressHUD dismiss];
            [self.navigationController.view makeToast:model.ResultDesc];
        }
    }
    else if(request.tag==10001)
    {
        if(model.ResultCode==0 ){
            [SVProgressHUD dismiss];
            bannerList=[[JsonTool defaultTool] getBannerList:request.responseString withKey:@"model"];
            [self goMain];
        }
        else
        {
            [SVProgressHUD dismiss];
            [self.navigationController.view makeToast:model.ResultDesc];
        }
    }
}
/*ASIHttp异步请求 结束*/

#pragma mark --
#pragma mark -- HttpRequestManagerDelegate methods



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.userTextField = nil;
    self.userPwdTextField = nil;
}

@end
