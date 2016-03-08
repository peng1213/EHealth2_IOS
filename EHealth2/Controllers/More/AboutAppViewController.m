//
//  AboutAppViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/31.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "AboutAppViewController.h"
#import "CommonUtil.h"

@interface AboutAppViewController ()

- (void)backToPreViewController;
@end

@implementation AboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
   NSString * compID= [plistDic objectForKey:@"COMP_ID"];
    
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
    [titleLable setText:@"关于"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //定义app的图标
    UIImageView  *appIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70.0f, self.view.frame.size.width, 80)];
    [appIcon setContentMode:UIViewContentModeScaleAspectFit];
    NSString *compICON=[NSString stringWithFormat:@"%@%@",@"comp_icon_",compID];
    [appIcon setImage:[UIImage imageNamed:compICON]];
    [self.view addSubview:appIcon];
    
    //定义名称图标
    UIImageView  *appLableIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, appIcon.frame.origin.y+appIcon.frame.size.height+20, self.view.frame.size.width, 32)];
    [appLableIcon setContentMode:UIViewContentModeScaleAspectFit];
    NSString *compIconName=[NSString stringWithFormat:@"%@%@",@"comp_name_",compID];
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    bool demoUser= [settings boolForKey:@"demoUser"];
    if(demoUser)
        [appLableIcon setImage:[UIImage imageNamed:compIconName]];
    [self.view addSubview:appLableIcon];
    
    UILabel *version=[[UILabel alloc]initWithFrame:CGRectMake(0, appLableIcon.frame.origin.y+appLableIcon.frame.size.height+20, self.view.frame.size.width, 20)];
    [version setTextAlignment:NSTextAlignmentCenter];
    [version setTextColor:[UIColor darkGrayColor]];
    [version setFont:[UIFont systemFontOfSize:12]];
    [version setText:[NSString stringWithFormat:@"%@ : %@",@"版本号",[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]]];
    [self.view addSubview:version];
    
    UIImageView  *qrcode = [[UIImageView alloc] initWithFrame:CGRectMake(0, version.frame.origin.y+version.frame.size.height+20, self.view.frame.size.width, 150)];
    [qrcode setContentMode:UIViewContentModeScaleAspectFit];
    NSString *compQRCODE=[NSString stringWithFormat:@"%@%@",@"qrcode_",compID];
    [qrcode setImage:[UIImage imageNamed:compQRCODE]];
    [qrcode setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:qrcode];
    
    UILabel *copyright=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 20)];
    [copyright setTextAlignment:NSTextAlignmentCenter];
    [copyright setTextColor:[UIColor darkGrayColor]];
    [copyright setFont:[UIFont boldSystemFontOfSize:12]];
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year = [dateComponent year];
    NSString *compName= [[[NSBundle mainBundle] infoDictionary] valueForKey:@"COMP_NAME"];
    if(demoUser)
        [copyright setText:[NSString stringWithFormat:@"©%d %@",year,compName]];
    else
    {
        [copyright setText:[NSString stringWithFormat:@"©%d %@",year,@"西安沛合信息技术有限公司"]];
    }
    [self.view addSubview:copyright];
    
    
    //定义名字图标
    //    UIImageView *appNameLableIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-96)/2.0, appLableIcon.frame.size.height+appLableIcon.frame.origin.y+5, 96, 16)];
    //    [appNameLableIcon setImage:[UIImage imageNamed:@"login_en_login_name_icon.png"]];
    
    
    //设置登录背景滑动手势 当手势滑动的时候 隐藏键盘 其方法为 hideTheKeyBoard
    
    
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
