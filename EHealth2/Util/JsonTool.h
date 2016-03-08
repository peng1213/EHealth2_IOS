//
//  JsonTools.h
//  citic
//
//  Created by jiaojunkang on 15-4-3.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResult.h"
#import "TClaimInfo.h"
#import "TClivbaseInfo.h"
#import "TDutybaseInfo.h"
#import "TFunctionInfo.h"
#import "TImgtypeConInfo.h"
#import "TLoginLogInfo.h"
#import "TMemberInfo.h"
#import "TOperateLogInfo.h"
#import "TPffcLinkInfo.h"
#import "TPolicyInfo.h"
#import "TProfileInfo.h"
#import "TReptBankInfo.h"
#import "TReptCaseInfo.h"
#import "TReptImgInfo.h"
#import "TUserInfo.h"
#import "TUspfLinkInfo.h"
#import "TVersionInfo.h"
#import "TDutyDesc.h"
#import "TImgInfo.h"
#import "HelpInfo.h"
#import "TClaimReportInfo.h"
#import "ReportImage.h"
#import "FieldConfig.h"
#import "Banner.h"
@interface JsonTool: NSObject

/*
 所谓单例模式
 作者 fishpro
 修改
 2014年03月12日
 */
+(JsonTool*)defaultTool;

//获取api接口类的返回接口是否正确 0表示正确 大于0表示错误
-(TResult *)getTResultEntity:(NSString * )requestString;
-(TReptCaseInfo *)getTReptCaseInfoModel:(NSDictionary * ) dict;
-(TReptCaseInfo *)getTReptCaseInfo:(NSString *) requestString  withKey:(NSString *)jsonKey;
-(NSMutableArray*) getTReptCaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TClaimInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TClaimInfo json->model
-(TClaimInfo *)getTClaimInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TClaimInfo
-(TClaimInfo*) getTClaimInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TClaimInfoList
-(NSMutableArray*) getTClaimInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TClaimInfo end-------------------------------------------------------------------------------*/
/*TClivbaseInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TClivbaseInfo json->model
-(TClivbaseInfo *)getTClivbaseInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TClivbaseInfo
-(TClivbaseInfo*) getTClivbaseInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TClivbaseInfoList
-(NSMutableArray*) getTClivbaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TClivbaseInfo end-------------------------------------------------------------------------------*/
/*TDutybaseInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TDutybaseInfo json->model
-(TDutybaseInfo *)getTDutybaseInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TDutybaseInfo
-(TDutybaseInfo*) getTDutybaseInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TDutybaseInfoList
-(NSMutableArray*) getTDutybaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TDutybaseInfo end-------------------------------------------------------------------------------*/
/*TFunctionInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TFunctionInfo json->model
-(TFunctionInfo *)getTFunctionInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TFunctionInfo
-(TFunctionInfo*) getTFunctionInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TFunctionInfoList
-(NSMutableArray*) getTFunctionInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TFunctionInfo end-------------------------------------------------------------------------------*/
/*TImgtypeConInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TImgtypeConInfo json->model
-(TImgtypeConInfo *)getTImgtypeConInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TImgtypeConInfo
-(TImgtypeConInfo*) getTImgtypeConInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TImgtypeConInfoList
-(NSMutableArray*) getTImgtypeConInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TImgtypeConInfo end-------------------------------------------------------------------------------*/
/*TLoginLogInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TLoginLogInfo json->model
-(TLoginLogInfo *)getTLoginLogInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TLoginLogInfo
-(TLoginLogInfo*) getTLoginLogInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TLoginLogInfoList
-(NSMutableArray*) getTLoginLogInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TLoginLogInfo end-------------------------------------------------------------------------------*/
/*TMemberInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TMemberInfo json->model
-(TMemberInfo *)getTMemberInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TMemberInfo
-(TMemberInfo*) getTMemberInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TMemberInfoList
-(NSMutableArray*) getTMemberInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TMemberInfo end-------------------------------------------------------------------------------*/
/*TOperateLogInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TOperateLogInfo json->model
-(TOperateLogInfo *)getTOperateLogInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TOperateLogInfo
-(TOperateLogInfo*) getTOperateLogInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TOperateLogInfoList
-(NSMutableArray*) getTOperateLogInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TOperateLogInfo end-------------------------------------------------------------------------------*/
/*TPffcLinkInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TPffcLinkInfo json->model
-(TPffcLinkInfo *)getTPffcLinkInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TPffcLinkInfo
-(TPffcLinkInfo*) getTPffcLinkInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TPffcLinkInfoList
-(NSMutableArray*) getTPffcLinkInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TPffcLinkInfo end-------------------------------------------------------------------------------*/
/*TPolicyInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TPolicyInfo json->model
-(TPolicyInfo *)getTPolicyInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TPolicyInfo
-(TPolicyInfo*) getTPolicyInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TPolicyInfoList
-(NSMutableArray*) getTPolicyInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TPolicyInfo end-------------------------------------------------------------------------------*/
/*TProfileInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TProfileInfo json->model
-(TProfileInfo *)getTProfileInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TProfileInfo
-(TProfileInfo*) getTProfileInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TProfileInfoList
-(NSMutableArray*) getTProfileInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TProfileInfo end-------------------------------------------------------------------------------*/
/*TReptBankInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TReptBankInfo json->model
-(TReptBankInfo *)getTReptBankInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TReptBankInfo
-(TReptBankInfo*) getTReptBankInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TReptBankInfoList
-(NSMutableArray*) getTReptBankInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TReptBankInfo end-------------------------------------------------------------------------------*/
 
/*TReptImgInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TReptImgInfo json->model
-(TReptImgInfo *)getTReptImgInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TReptImgInfo
-(TReptImgInfo*) getTReptImgInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TReptImgInfoList
-(NSMutableArray*) getTReptImgInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TReptImgInfo end-------------------------------------------------------------------------------*/
/*TUserInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TUserInfo json->model
-(TUserInfo *)getTUserInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TUserInfo
-(TUserInfo*) getTUserInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;
-(TLoginLogInfo *)getTLoginLogInfo:(NSString *) requestString  withKey:(NSString *)jsonKey;

//从请求的字符串中获取多个实体对象TUserInfoList
-(NSMutableArray*) getTUserInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TUserInfo end-------------------------------------------------------------------------------*/
/*TUspfLinkInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TUspfLinkInfo json->model
-(TUspfLinkInfo *)getTUspfLinkInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TUspfLinkInfo
-(TUspfLinkInfo*) getTUspfLinkInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TUspfLinkInfoList
-(NSMutableArray*) getTUspfLinkInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TUspfLinkInfo end-------------------------------------------------------------------------------*/
/*TVersionInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TVersionInfo json->model
-(TVersionInfo *)getTVersionInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TVersionInfo
-(TVersionInfo*) getTVersionInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TVersionInfoList
-(NSMutableArray*) getTVersionInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TVersionInfo end-------------------------------------------------------------------------------*/

/*TDutyDesc start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TDutyDesc json->model
-(TDutyDesc *)getTDutyDescModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TDutyDesc
-(TDutyDesc*) getTDutyDescEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TDutyDescList
-(NSMutableArray*) getTDutyDescList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TDutyDesc end-------------------------------------------------------------------------------*/

/*TImgInfo start------------------------------------------------------------------------------*/
//从NSDictionary中获取单个的实体对象TImgInfo json->model
-(TImgInfo *)getTImgInfoModel:(NSDictionary * ) dict;

//从请求的字符串中获取单个的实体对象TImgInfo
-(TImgInfo*) getTImgInfoEntity:(NSString *) requestString withKey: (NSString*) jsonKey;

//从请求的字符串中获取多个实体对象TImgInfoList
-(NSMutableArray*) getTImgInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey;

/*TImgInfo end-------------------------------------------------------------------------------*/
-(NSMutableArray*) getHelpNavList:(NSString *) requestString  withKey:(NSString *)jsonKey;
-(NSMutableArray*) getHelpItemList:(NSString *) requestString  withKey:(NSString *)jsonKey;

-(TClaimReportInfo *)getTClaimReportInfo:(NSString *) requestString  withKey:(NSString *)jsonKey;
-(TImgInfo *)getTImgInfo:(NSString *) requestString  withKey:(NSString *)jsonKey;
-(TReptImgInfo *)getTReptImgInfo:(NSString *) requestString  withKey:(NSString *)jsonKey;

-(NSMutableArray*) getFieldConfigList:(NSString *) requestString  withKey:(NSString *)jsonKey;

-(NSMutableArray*) getBannerList:(NSString *) requestString  withKey:(NSString *)jsonKey;
@end

