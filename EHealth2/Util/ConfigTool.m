//
//  ConfigTool.m
//  EhealthClient
//
//  Created by jiaojunkang on 14-4-14.
//  Copyright (c) 2014年 primetpa. All rights reserved.
//
#import "Pub.h"
#import "ConfigTool.h"

@implementation ConfigTool
/*缓存所有提交的变量*/
 

/*传说中的单例*/
static ConfigTool * instance = nil;
+(ConfigTool *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

/*通用保存获取方法*/

-(void)saveCacheWithKey:(NSString*)key andData:(NSString*)data{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:key];
    [settings setObject:data forKey:key];

}
-(NSString*)getCacheWithKey:(NSString *)key
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:key];
}

-(void)removeCacheWithKey:(NSString*)key
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:key];

}
/*保存缓存*/
-(void)saveUserName:(NSString *)userName andPassword:(NSString *)password
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"UserName"];
    [settings removeObjectForKey:@"Password"];
    [settings setObject:userName forKey:@"UserName"];
    
    password = [AESCrypt encrypt:password password:@"pwd"];
    
    [settings setObject:password forKey:@"Password"];
    [settings synchronize];
}
-(NSString *)getUserName
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"UserName"];
}
-(NSString *)getPassword
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"Password"];
    return [AESCrypt decrypt:temp password:@"pwd"];
}

/*保存缓存*/
-(void)saveWeaherCity:(NSString *)city andCode:(NSString *)code
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"city"];
    [settings removeObjectForKey:@"code"];
    [settings setObject:city forKey:@"city"];
    [settings setObject:code forKey:@"code"];
    [settings synchronize];
}
-(NSString *)getWeatherCity
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"city"];
}
-(NSString *)getWeatherCode
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"code"];
}



@end
