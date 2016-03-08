//
//  AppDelegate.h
//  EHealth2
//
//  Created by 刘祯 on 15/5/21.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchViewController.h"
#import <Bugly/CrashReporter.h>
#import "TUserInfo.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) LaunchViewController *launchView;
@property NSString * COMP_ID;
@property NSString * token;

@property NSString * province;
@property NSString * city;
@property NSString * district;
 
@property TUserInfo * User;
@end

