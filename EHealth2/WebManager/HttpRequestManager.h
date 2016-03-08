//
//  HttpRequestManager.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "ResultInfo.h"
#import "RegisterInfo.h"
#import "ImageInfo.h"
#import "ReportInfo.h"

@class HttpRequestManager;
@protocol HttpRequestManagerDelegate <NSObject>
@optional
- (void)httpResponseSuccess:(ResultInfo *)resultInfo;
- (void)httpResponseFailed:(ResultInfo *)resultInfo;

@end
@interface HttpRequestManager : AFHTTPRequestOperationManager
{

    __unsafe_unretained id<HttpRequestManagerDelegate> delegate;
}
@property (nonatomic,assign)id<HttpRequestManagerDelegate> delegate;

/**
 *  用户注册校验
 *
 *  @param userIC
 *  @param userName
 */
- (void)registerIdentityCardCheckRequestWithID:(NSString *)userIC
                               userName:(NSString *)userName;

/**
 *  用户注册
 *
 *  @param registerInfo
 */
- (void)registerRequestWithRegister:(RegisterInfo *)registerInfo;

/**
 *  修改密码
 *
 *  @param oldPwd
 *  @param newPwd
 */
- (void)modifyPwdRequestWithOldPwd:(NSString *)oldPwd
                            newPwd:(NSString *)newPwd;

/**
 *  用户登录
 *
 *  @param userAccount
 *  @param userPwd
 */
- (void)loginAppRequestWithAccount:(NSString *)userAccount
                               pwd:(NSString *)userPwd;

/**
 *  用户登出
 */
- (void)appLoginOutRequest;

/**
 *  删除影像
 *
 *  @param imageKey
 */
- (void)deleteImageInfoRequestWithImageKey:(NSString *)imageKey;

/**
 * 删除报案
 *
 *  @param reportKey
 */
- (void)deleteReportInfoRequestWithReportKey:(NSString *)reportKey;

/**
 * 查询项目银行配置
 *
 *  @param compID
 */
- (void)queryBankListRequestWithCompID:(NSString *)compID;

/**
 * 查询报案影像
 *
 *  @param reportKey
 */
- (void)queryImageListRequestWithReportKey:(NSString *)reportKey;

/**
 * 查询影像配置
 *
 *  @param compID
 *  @param caseType
 */
- (void)queryImageTypeListRequestWithCompID:(NSString *)compID
                                   caseType:(NSString *)caseType;

/**
 * 查询用户个人连带信息
 *
 *  @param meKey
 */
- (void)queryMemberListRequestWithMeKey:(NSString *)meKey;

/**
 * 查询报案信息
 *
 *  @param userID
 */
- (void)queryReportListRequestWithUserID:(NSString *)userID;

/**
 * 添加影像资料
 *
 *  @param imageInfo
 */
- (void)addImageInfoRequestWithImageInfo:(ImageInfo *)imageInfo;

/**
 * 添加报案
 *
 *  @param reportInfo
 */
- (void)addReportInfoRequestWithReportInfo:(ReportInfo *)reportInfo;

/**
 *  编辑报案
 *
 *  @param reportInfo
 */
- (void)modifyReportInfoRequestWithReportInfo:(ReportInfo *)reportInfo;

@end
