//
//  AppDelegate.m
//  EHealth2
//
//  Created by 刘祯 on 15/5/21.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ConfigTool.h"
#import "CommonUtil.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "UploadViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize COMP_ID;
@synthesize token;
@synthesize launchView;
@synthesize province;
@synthesize city;
@synthesize district;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    UIViewController* vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
    
    [[CrashReporter sharedInstance] installWithAppId:@"900007673"];
    launchView = [[LaunchViewController alloc] init];
    [self.window addSubview:launchView.view];
    
    
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    COMP_ID= [plistDic objectForKey:@"COMP_ID"];
    [self.window makeKeyAndVisible];
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:[plistDic objectForKey:@"BaiduKEY"]  generalDelegate:self];
    if (!ret) {
        NSLog(@"地图启动成功!");
    }
    else
        NSLog(@"地图启动失败!");
    if([[ConfigTool Instance]getWeatherCode]==nil)
        [[ConfigTool Instance]saveWeaherCity:@"北京" andCode:@"101010100"];
    //^[a-zA-Z_][A-Za-z0-9_]{5,17}
    return YES;
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"授权失败，检查版本和key是否一致");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
