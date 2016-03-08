//
//  Prefix header
//
//  The contents of this file are implicitly included at the beginning of every source file.
//

#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
/*新增加的预编译头*/
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequestConfig.h"
#import "ASIDownloadCache.h"
#import "AppDelegate.h"
#import "ConfigTool.h"
#import "JsonTool.h"
#import "TResult.h"
#import "UIView+Toast.h"

/*我勒个去 版本是个贱人*/
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 4430
#define IOS7_SDK_AVAILABLE 1
#endif

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/*正直表达式*/
#define regex_email @"\b([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b"
#define regex_http_url @"\bhttps?://[a-zA-Z0-9\-.]+(?:(?:/[a-zA-Z0-9\-._?,'+\&%$=~*!():@\\]*)+)?"
#define regex_ipaddress @"\b(?:\d{1,3}\.){3}\d{1,3}\b"
#define regex_iphost @"\b(?:(?:\d{1,3}\.){3}\d{1,3}|(?:[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}?[a-zA-Z0-9]\.)+[a-zA-Z]{2,6})\b"/*ipandhost*/
#define regex_integer @"[+\-]?[0-9]+"/*整数*/
#define regex_hex @"0[xX][0-9a-fA-F]+"/*16进制*/
#define regex_float @"[+\-]?(?:[0-9]*\.[0-9]+|[0-9]+\.)"/*小数*/
#define regex_float_exp @"+\-]?(?:[0-9]*\.[0-9]+|[0-9]+\.)(?:[eE][+\-]?[0-9]+)?"/*科学小数表示法*/
#define regex_intege_fina @"[0-9]{1,3}(?:,[0-9]{3})*"/*千分号数字表示法*/



/*宏预定义 常用*/
#define SettingTableIdentifier @"SettingTableIdentifier"
#define TableSampleIdentifier @"TableSampleIdentifier"

/*
 宏预定义 api 接口 
 命名方式 api为前缀http://app.happyinsurancetpa.com:8100/
 功能+操作
 */
#define	api_url	[[[NSBundle mainBundle] infoDictionary]objectForKey:@"api_url"]	/*注册校验*/

/*用户接口 */
//1用户注册验证
#define api_user_regcheck [NSString stringWithFormat:@"%@%@",api_url,@"User/RegisterCheck.ashx"]
#define cache_user_regcheck @"cache_user_regcheck"
//2用户注册
#define api_user_reg  [NSString stringWithFormat:@"%@%@",api_url,@"User/RegisterUser.ashx"]
#define cache_user_reg @"cache_user_reg"

//3用户密码更新
#define api_user_changepwd     [NSString stringWithFormat:@"%@%@",api_url,@"User/UpdateUserPwd.ashx"]
#define cache_user_changepwd @"cache_user_changepwd"

//找回密码
#define api_user_findpwdcheck     [NSString stringWithFormat:@"%@%@",api_url,@"User/FindPwdCheck.ashx"]
#define cache_user_findpwdcheck @"cache_user_findpwdcheck"

#define api_user_findpwd     [NSString stringWithFormat:@"%@%@",api_url,@"User/FoundPwd.ashx"]
#define cache_user_findpwd @"cache_user_findpwd"
//4用户登录
#define api_user_login	[NSString stringWithFormat:@"%@%@",api_url,@"User/UserLogin.ashx"]
#define cache_user_login @"cache_user_login"

//5用户登出
#define api_user_loginout  [NSString stringWithFormat:@"%@%@",api_url,@"User/UserLogOut.ashx"]
#define cache_user_loginout @"cache_user_loginout"
/*
 报案 rpt
 */
//1案件影像删除
#define api_case_image_delete [NSString stringWithFormat:@"%@%@",api_url,@"Report/DeleteImgInfo.ashx"]
#define cache_case_image_delete @"cache_case_image_delete"
//2案件删除
#define api_case_delete  [NSString stringWithFormat:@"%@%@",api_url,@"Report/DeleteReportInfo.ashx"]
#define cache_case_delete @"cache_case_delete"
//3获取银行列表
#define api_bank_list [NSString stringWithFormat:@"%@%@",api_url,@"Report/GetBankList.ashx"]
#define cache_bank_list @"cache_bank_list"
//4获取案件影像列表
#define api_case_image_list [NSString stringWithFormat:@"%@%@",api_url,@"Report/GetImgList.ashx"]
#define cache_case_image_list @"cache_case_image_list"
//5获取案件下的影像分类名称列表
#define api_image_typelist [NSString stringWithFormat:@"%@%@",api_url,@"Report/GetImgTypeList.ashx"]
#define cache_image_typelist @"cache_image_typelist"
//6获取家庭成员列表
#define api_member_list [NSString stringWithFormat:@"%@%@",api_url,@"Report/GetMemberList.ashx"]
#define cache_member_list @"cache_member_list"
//7获取案件列表
#define api_case_list [NSString stringWithFormat:@"%@%@",api_url,@"Report/GetReportList.ashx"]
#define cache_case_list @"cache_case_list"
//8添加影像
#define api_image_add [NSString stringWithFormat:@"%@%@",api_url,@"Report/InsertImgInfo.ashx"]
#define cache_image_add @"cache_image_add"
//9添加报案
#define api_case_add [NSString stringWithFormat:@"%@%@",api_url,@"Report/InsertReportInfo.ashx"]
#define cache_case_add @"cache_case_add"
//10更新报案
#define api_case_update [NSString stringWithFormat:@"%@%@",api_url,@"Report/UpdateReportInfo.ashx"]
#define cache_case_update @"cache_case_update"

//11保存报案
#define api_case_save [NSString stringWithFormat:@"%@%@",api_url,@"Report/SaveReportInfo.ashx"]
#define cache_case_save @"cache_case_save"

//12确认报案
#define api_case_confirm [NSString stringWithFormat:@"%@%@",api_url,@"Report/ConfirmReportInfo.ashx"]
#define cache_case_confirm @"cache_case_confirm"

/*
 理赔查询
 */
//1移动端读取影像
#define api_image_download [NSString stringWithFormat:@"%@%@",api_url,@"Info/DownloadImage.ashx"]
#define cache_image_download @"cache_image_download"

//2查询理赔既往信息
#define api_claim_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetClaimInfo.ashx"]
#define cache_claim_get @"cache_claim_get"

//3查询发票
#define api_cliv_baseinfo_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetClivbaseInfo.ashx"]
#define cache_cliv_baseinfo_get @"cache_claim_baseinfo_get"

//4查询责任
#define api_duty_baseinfo_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetDutybaseInfo.ashx"]
#define cache_duty_baseinfo_get @"cache_duty_baseinfo_get"

//5查询保障责任
#define api_duty_desc_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetDutyDescInfo.ashx"]
#define cache_duty_desc_get @"cache_duty_desc_get"

//6查询影像
#define api_img_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetImgInfo.ashx"]
#define cache_img_get @"cache_duty_img_get"

//7查询保单信息
#define api_policy_get [NSString stringWithFormat:@"%@%@",api_url,@"Info/GetPolicyInfo.ashx"]
#define cache_policy_get @"cache_policy_get"

//8帮助
#define api_help_nav_get [NSString stringWithFormat:@"%@%@",api_url,@"help/getnavlist.ashx"]
#define cache_help_nav_get @"cache_help_nav_get"

#define api_help_item_get [NSString stringWithFormat:@"%@%@",api_url,@"help//GetHelpTitleList.ashx"]
#define cache_help_item_get @"cache_help_item_get"

#define api_help_desc_get [NSString stringWithFormat:@"%@%@",api_url,@"help//GetHelpDescList.ashx"]
#define cache_help_desc_get @"cache_help_desc_get"


#define api_weather_get @"http://weatherapi.market.xiaomi.com/wtr-v2/weather?cityId="
#define cache_weather_get @"cache_weather_get"

#define api_claim_reptinfo [NSString stringWithFormat:@"%@%@",api_url,@"claimreport/GetClimReptInfo.ashx"]
#define cache_claim_reptinfo @"cache_claim_reptinfo"


/////////////// 配置
//1功能字段配置
#define api_field_config [NSString stringWithFormat:@"%@%@",api_url,@"config/getfieldconfig.ashx"]
#define cache_field_config @"cache_field_config"
//2首页banner
#define api_banner_get [NSString stringWithFormat:@"%@%@",api_url,@"barner/getbarimg.ashx"]
#define cache_banner_get @"cache_banner_get"

/** 验证申报次数url */
#define api_report_check [NSString stringWithFormat:@"%@%@",api_url,@"report/ReportConfigCheck.ashx"]
#define cache_report_check @"cache_report_check"
#endif



