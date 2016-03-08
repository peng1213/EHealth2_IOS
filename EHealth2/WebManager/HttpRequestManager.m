//
//  HttpRequestManager.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "HttpRequestManager.h"
#import "NetworkConfig.h"
#import "CommonUtil.h"



@implementation HttpRequestManager
@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.operationQueue setMaxConcurrentOperationCount:3];
        [self.requestSerializer setBChange:YES];
        [self.requestSerializer setValue:ACCPETVALUE forHTTPHeaderField:ACCEPTKEY];
        [self.requestSerializer setValue:CONTENTTYPEVALUE forHTTPHeaderField:CONTENTTYPEKEY];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ACCPETVALUE];
        
    }
    return self;
}

- (void)registerIdentityCardCheckRequestWithID:(NSString *)userIC
                                      userName:(NSString *)userName
{
    NSString *url = [NSString stringWithFormat:REGISTER_CHECK,userIC,[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,url];
    NSLog(@"\nrequestURL=%@",requestURL);
    [self GET:requestURL
   parameters:Nil
      success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
     NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
     NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
     NSLog(@"resultInfoDic==%@",resultInfoDic);
     ResultInfo *resultInfo = [[ResultInfo alloc] init];
     resultInfo.resultCode = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultCode"]];
     resultInfo.resultDesc = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultDesc"]];
     if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
         if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
             [delegate httpResponseSuccess:resultInfo];
         }
     }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         ResultInfo *resultInfo = [[ResultInfo alloc] init];
         resultInfo.resultCode = @"1";
         resultInfo.resultDesc = [error description];
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
      }];
    
}

- (void)registerRequestWithRegister:(RegisterInfo *)registerInfo
                            
{
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:registerInfo.userName forKey:USUS_ID];
    [dictionary setValue:[CommonUtil MD5:registerInfo.userPwd] forKey:USUS_PWD];
    [dictionary setValue:registerInfo.registerName forKey:USUS_NAME];
    [dictionary setValue:registerInfo.registerID forKey:USUS_VIP_ID];
    [dictionary setValue:registerInfo.registerID forKey:USUS_CERT_NO];
    [dictionary setValue:registerInfo.contactNum forKey:USUS_MOBILE_NO];
    [dictionary setValue:registerInfo.email forKey:USUS_EMAIL];
    [dictionary setValue:registerInfo.address forKey:USUS_ADDRESS];
    [dictionary setValue:registerInfo.code forKey:USUS_ZIPCODE];
    [dictionary setValue:@"1" forKey:USUS_TYPE];
    [dictionary setValue:@"1" forKey:USUS_STATUS];
    [dictionary setValue:@"PH" forKey:COMP_ID];
    [dictionary setValue:@"沛合" forKey:COMP_NAME];
    [dictionary setValue:@"100" forKey:USUS_MNG_ID];
    [dictionary setValue:@"测试" forKey:USUS_MNG_NAME];
    [dictionary setValue:@"0" forKey:GPGP_KY];
    [dictionary setValue:@"0" forKey:GPGP_NAME];
    [dictionary setValue:@"0" forKey:MEME_KY];
    [dictionary setValue:@"18" forKey:MEME_AGE];
    [dictionary setValue:@"0" forKey:MEME_SEX];
    [dictionary setValue:@"2015-04-01" forKey:USUS_CREATE_DT];
    [dictionary setValue:@"" forKey:USUS_NEXT_ELOGIN_DT];
    
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,REGISTER_USER];
    NSLog(@"\nrequestURL=%@",requestURL);
    [self POST:requestURL
    parameters:dictionary
       success:^(AFHTTPRequestOperation *operation,id responseObject) {
           NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
           NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = [resultInfoDic objectForKey:@"ResultCode"];
           resultInfo.resultDesc = [resultInfoDic objectForKey:@"ResultDesc"];
           if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
               if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
                   [delegate httpResponseSuccess:resultInfo];
               }
           }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
               if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
                   [delegate httpResponseFailed:resultInfo];
               }
           }
           NSLog(@"\n operation.responseData success =%@",jsonData);
       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error) {
           
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = @"1";
           resultInfo.resultDesc = [error description];
           if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
               [delegate httpResponseFailed:resultInfo];
           }
           NSLog(@"\n operation.responseData failure =%@",error.description);
       }];
}

- (void)modifyPwdRequestWithOldPwd:(NSString *)oldPwd
                            newPwd:(NSString *)newPwd
{
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"100" forKey:USUS_KY];
    [dictionary setValue:[CommonUtil MD5:oldPwd] forKey:USUS_PWD];
    [dictionary setValue:[CommonUtil MD5:newPwd] forKey:NEW_PWD];
    [dictionary setValue:@"1" forKey:OPERATE_TYPE];
    [dictionary setValue:@"1" forKey:OPERATE_USER_ID];
    
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,UPDATE_PWD];
    NSLog(@"\nrequestURL=%@",requestURL);
    
    [self POST:requestURL
    parameters:dictionary
       success:^(AFHTTPRequestOperation *operation,id responseObject) {
           NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
           NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = [resultInfoDic objectForKey:@"ResultCode"];
           resultInfo.resultDesc = [resultInfoDic objectForKey:@"ResultDesc"];
           if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
               if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
                   [delegate httpResponseSuccess:resultInfo];
               }
           }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
               if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
                   [delegate httpResponseFailed:resultInfo];
               }
           }
           NSLog(@"\n operation.responseData success =%@",jsonData);
       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error) {
           
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = @"1";
           resultInfo.resultDesc = [error description];
           if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
               [delegate httpResponseFailed:resultInfo];
           }
           NSLog(@"\n operation.responseData failure =%@",error.description);
       }];

}

- (void)loginAppRequestWithAccount:(NSString *)userAccount
                               pwd:(NSString *)userPwd
{
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:userAccount forKey:USUS_ID];
    [dictionary setValue:[CommonUtil MD5:userPwd] forKey:USUS_PWD];
    [dictionary setValue:@"1" forKey:LOGIN_CLIENT_TYPE];
    [dictionary setValue:@"1" forKey:LOGIN_CLIENT_MODEL];
    [dictionary setValue:@"1" forKey:LOGIN_MACID];
    [dictionary setValue:@"1" forKey:LOGIN_PROVINCE];
    [dictionary setValue:@"1" forKey:LOGIN_CITY];
    [dictionary setValue:@"1" forKey:LOGIN_COUNTY];
    
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,UPDATE_PWD];
    NSLog(@"\nrequestURL=%@",requestURL);
    
    [self POST:requestURL
    parameters:dictionary
       success:^(AFHTTPRequestOperation *operation,id responseObject) {
           NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
           NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = [resultInfoDic objectForKey:@"ResultCode"];
           resultInfo.resultDesc = [resultInfoDic objectForKey:@"ResultDesc"];
           if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
               if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
                   [delegate httpResponseSuccess:resultInfo];
               }
           }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
               if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
                   [delegate httpResponseFailed:resultInfo];
               }
           }
           NSLog(@"\n operation.responseData success =%@",jsonData);
       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error) {
           
           ResultInfo *resultInfo = [[ResultInfo alloc] init];
           resultInfo.resultCode = @"1";
           resultInfo.resultDesc = [error description];
           if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
               [delegate httpResponseFailed:resultInfo];
           }
           NSLog(@"\n operation.responseData failure =%@",error.description);
       }];
}

- (void)appLoginOutRequest
{
    NSString *url = [NSString stringWithFormat:USER_LOGINOUT,@"1"];
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,url];
    NSLog(@"\nrequestURL=%@",requestURL);
    [self GET:requestURL
   parameters:Nil
      success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
     NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
     NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
     NSLog(@"resultInfoDic==%@",resultInfoDic);
     ResultInfo *resultInfo = [[ResultInfo alloc] init];
     resultInfo.resultCode = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultCode"]];
     resultInfo.resultDesc = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultDesc"]];
     if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
         if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
             [delegate httpResponseSuccess:resultInfo];
         }
     }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         ResultInfo *resultInfo = [[ResultInfo alloc] init];
         resultInfo.resultCode = @"1";
         resultInfo.resultDesc = [error description];
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }];
}

- (void)deleteCaseImageWithImageKey:(NSString *)imageKey
{
    NSString *url = [NSString stringWithFormat:DELETE_IMAGE,imageKey];
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,url];
    NSLog(@"\nrequestURL=%@",requestURL);
    [self GET:requestURL
   parameters:Nil
      success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
     NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
     NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
     NSLog(@"resultInfoDic==%@",resultInfoDic);
     ResultInfo *resultInfo = [[ResultInfo alloc] init];
     resultInfo.resultCode = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultCode"]];
     resultInfo.resultDesc = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultDesc"]];
     if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
         if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
             [delegate httpResponseSuccess:resultInfo];
         }
     }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         ResultInfo *resultInfo = [[ResultInfo alloc] init];
         resultInfo.resultCode = @"1";
         resultInfo.resultDesc = [error description];
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }];
}

- (void)deleteReportInfoWithReportKey:(NSString *)reportKey
{
    NSString *url = [NSString stringWithFormat:DELETE_CASE,reportKey];
    NSString *requestURL = [NSString stringWithFormat:HTTPREQUESTURL,url];
    NSLog(@"\nrequestURL=%@",requestURL);
    [self GET:requestURL
   parameters:Nil
      success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
     NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
     NSDictionary *resultInfoDic = [jsonData valueForKey:@"result"];
     NSLog(@"resultInfoDic==%@",resultInfoDic);
     ResultInfo *resultInfo = [[ResultInfo alloc] init];
     resultInfo.resultCode = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultCode"]];
     resultInfo.resultDesc = [NSString stringWithFormat:@"%@",[resultInfoDic objectForKey:@"ResultDesc"]];
     if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"0"]) {
         if ([delegate respondsToSelector:@selector(httpResponseSuccess:)]) {
             [delegate httpResponseSuccess:resultInfo];
         }
     }else if ([[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",resultInfo.resultCode] isEqualToString:@"2"]) {
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         ResultInfo *resultInfo = [[ResultInfo alloc] init];
         resultInfo.resultCode = @"1";
         resultInfo.resultDesc = [error description];
         if ([delegate respondsToSelector:@selector(httpResponseFailed:)]) {
             [delegate httpResponseFailed:resultInfo];
         }
     }];
}

- (void)queryBankListRequestWithCompID:(NSString *)compID
{

}

- (void)queryImageListRequestWithReportKey:(NSString *)reportKey
{

}

- (void)queryImageTypeListRequestWithCompID:(NSString *)compID
                                   caseType:(NSString *)caseType
{

}

- (void)queryMemberListRequestWithMeKey:(NSString *)meKey
{

}

- (void)queryReportListRequestWithUserID:(NSString *)userID
{

}

- (void)addImageInfoRequestWithImageInfo:(ImageInfo *)imageInfo
{

}

@end
