//
//  LaunchViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/26.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "LaunchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Pub.h"
#import "TestViewController.h"


@interface LaunchViewController ()
{
    NSString *newVersionURlString;
}
@end


@implementation LaunchViewController
@synthesize bgImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    compID= [plistDic objectForKey:@"COMP_ID"];
    appName=[plistDic objectForKey:@"APP_NAME"];
    appID=[plistDic objectForKey:@"app_id"];

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
    UILabel  *appvnameIcon = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-400.0f)/2.0, appLableIcon.frame.origin.y+appLableIcon.frame.size.height+12, 400.0f, 23.5f)];
    [appvnameIcon setTextColor:[UIColor darkGrayColor]];
    [appvnameIcon setText:appName];
    [appvnameIcon setFont:[UIFont systemFontOfSize:22]];
    [appvnameIcon setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:appvnameIcon];
    [bgImage.layer addAnimation:[self opacityForever_Animation:1]  forKey:nil];
    [appIcon.layer addAnimation:[self opacityForever_Animation:1]  forKey:nil];
    [appLableIcon.layer addAnimation:[self opacityForever_Animation:1]  forKey:nil];
    [appvnameIcon.layer addAnimation:[self opacityForever_Animation_WithEvent:1]  forKey:nil];
    
}

-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];//这是透明度。
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

-(CABasicAnimation *)opacityForever_Animation_WithEvent:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];//这是透明度。
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate=self;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    [self checkUpdateWithAPPID:appID];
}

-(void)goLogin
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:true completion:nil];
    //
    //    TestViewController *loginViewController = [[TestViewController alloc] init];
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    //    [navigationController setNavigationBarHidden:YES animated:NO];
    //    [self presentViewController:navigationController animated:true completion:^{}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 检查更新
- (void)checkUpdateWithAPPID:(NSString *)APPID
{
    //获取当前应用版本号
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    NSString *updateUrlString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID];
    NSURL *updateUrl = [NSURL URLWithString:updateUrlString];
    ASIFormDataRequest* versionRequest = [ASIFormDataRequest requestWithURL:updateUrl];
    [versionRequest setRequestMethod:@"GET"];
    [versionRequest setTimeOutSeconds:20];
    [versionRequest addRequestHeader:@"Content-Type" value:@"application/json"];
    [versionRequest setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[versionRequest responseData] options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            if (dict != nil) {
                int resultCount = [[dict objectForKey:@"resultCount"] integerValue];
                if (resultCount == 1) {
                    NSArray *resultArray = [dict objectForKey:@"results"];
                    NSDictionary *resultDict = [resultArray objectAtIndex:0];
                    NSString *newVersion = [resultDict objectForKey:@"version"];
                    
                    if ([newVersion doubleValue]>[currentVersion doubleValue]) {
                        NSString *msg = [NSString stringWithFormat:@"发现新版本%@,请更新！",newVersion];
                        newVersionURlString = [[resultDict objectForKey:@"trackViewUrl"] copy];
                        NSLog(@"newVersionUrl is %@",newVersionURlString);
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即更新", nil];
                        alertView.tag = 1000;
                        [alertView show];
                    }
                    else
                    {
                        [self goLogin];
                    }
                }
                else
                {
                    [self goLogin];
                }
            }
            else
            {
                [self goLogin];
            }
        }
        else
        {
            [self goLogin];
        }
    }];
    
    [versionRequest setFailedBlock:^{
        [self goLogin];
    }];
    
    [versionRequest startSynchronous];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1000) {
        if(newVersionURlString)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newVersionURlString]];
            [self goLogin];
        }
    }
}
@end
