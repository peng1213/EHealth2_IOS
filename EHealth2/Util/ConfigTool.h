//
//  ConfigTool.h
//  EhealthClient
//
//  Created by jiaojunkang on 14-4-14.
//  Copyright (c) 2014年 primetpa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESCrypt.h"
#import "JsonTool.h"
#import "TUserInfo.h"
#import "TResult.h"
#import "TMemberInfo.h"


@interface ConfigTool : NSObject
 

+(ConfigTool *) Instance;
+(id)allocWithZone:(NSZone *)zone;
/*本地缓存策略*/
-(void)saveCacheWithKey:(NSString*)key andData:(NSString*)data;
-(NSString*)getCacheWithKey:(NSString *)key;
-(void)removeCacheWithKey:(NSString*)key;
/*用户缓存本地*/
-(void)saveUserName:(NSString *)userName andPassword:(NSString *)password;
-(NSString *)getUserName;
-(NSString *)getPassword;
-(void)saveWeaherCity:(NSString *)city andCode:(NSString *)code;
-(NSString *)getWeatherCity;
-(NSString *)getWeatherCode;
@end
