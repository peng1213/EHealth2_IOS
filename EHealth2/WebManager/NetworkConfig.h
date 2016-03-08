//
//  NetworkConfig.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#define ACCPETVALUE               @"text/plain"
#define ACCEPTKEY                 @"Accept"

#define CONTENTTYPEVALUE         @"text/plain; charset=\"UTF-8\""
#define CONTENTTYPEKEY           @"Content-Type"

#define HTTPREQUESTURL @"http://www.peihetpa.com:7000/%@"

    /*
     用户接口相关
    （1）用户校验
    （2）用户注册
    （3）修改密码
    （4）用户登录
    （5）用户登出
     */
#define REGISTER_CHECK @"User/RegisterCheck.ashx?USUS_VIP_ID=%@&USUS_NAME=%@"
#define REGISTER_USER  @"User/RegisterUser.ashx"
#define UPDATE_PWD     @"User/UpdateUserPwd.ashx"
#define USER_LOGIN     @"User/UserLogin.ashx"
#define USER_LOGINOUT  @"User/UserLogOut.ashx?&SYSV_KY=%@"

#define USUS_VIP_ID @"USUS_VIP_ID"//用户VIPID
#define USUS_NAME @"USUS_NAME"    //用户姓名
#define USUS_ID   @"USUS_ID"      //用户账号
#define USUS_PWD  @"USUS_PWD"     //用户密码
#define USUS_CERT_NO @"USUS_CERT_NO"  //用户证件号
#define USUS_TYPE    @"USUS_TYPE"  //用户类型
#define USUS_STATUS  @"USUS_STATUS"//用户状态
#define COMPY_ID      @"COMP_ID"    //所属公司
#define COMPY_NAME    @"COMP_NAME"  //所属公司名称
#define USUS_MNG_ID  @"USUS_MNG_ID"//所属分支
#define USUS_MNG_NAME @"USUS_MNG_NAME" //所属分之名称
#define GPGP_KY      @"GPGP_KY" //团体ky
#define GPGP_NAME    @"GPGP_NAME" //团体名
#define MEME_KY      @"MEME_KY"   //3.0meky
#define MEME_AGE     @"MEME_AGE"  //年龄
#define MEME_SEX     @"MEME_SEX"  //性别
#define USUS_MOBILE_NO @"USUS_MOBILE_NO" //手机号
#define USUS_EMAIL   @"USUS_EMAIL" //电子邮件
#define USUS_ADDRESS @"USUS_ADDRESS" //地址
#define USUS_ZIPCODE @"USUS_ZIPCODE" //邮编
#define USUS_CREATE_DT @"USUS_CREATE_DT" //创建时间
#define USUS_NEXT_ELOGIN_DT @"USUS_NEXT_ELOGIN_DT" //下次登录时间

#define USUS_KY @"USUS_KY"//用户ky
#define USUS_PWD @"USUS_PWD"//旧密码
#define NEW_PWD  @"NEW_PWD"//新密码
#define OPERATE_TYPE @"OPERATE_TYPE"//操作类型
#define OPERATE_USER_ID @"OPERATE_USER_ID"//操作人

#define LOGIN_CLIENT_TYPE @"LOGIN_CLIENT_TYPE"//登录设备
#define LOGIN_CLIENT_MODEL @"LOGIN_CLIENT_MODEL"//设备型号
#define LOGIN_MACID       @"LOGIN_MACID"//mac地址
#define LOGIN_PROVINCE  @"LOGIN_PROVINCE"//省
#define LOGIN_CITY     @"LOGIN_CITY"//市
#define LOGIN_COUNTY   @"LOGIN_COUNTY"//县

#define SYSV_KY  @"SYSV_KY"//登录日志

/*
 报案
（1）删除影像
（2）删除报案
（3）查询项目银行配置
（4）查询报案影像
（5）查询影像配置
（6）查询用户个人连带信息
（7）查询报案信息
（8）添加影像
（9）添加报案
（10）修改报案
 */
#define DELETE_IMAGE @"Report/DeleteImgInfo.ashx?IMG_KY=%@"
#define DELETE_CASE  @"Report/DeleteReportInfo.ashx?REPT_KY=%@"
#define QUERY_BANK_LIST @"Report/GetBankList.ashx"
#define QUERY_CASE_IMAGE @"Report/GetImgList.ashx"
#define QUERY_IMAGE_SETTING @"Report/GetImgTypeList.ashx"
#define QUERY_MEMBER_LIST @"Report/GetMemberList.ashx"
#define QUERY_CASEINFO_LIST @"Report/GetReportList.ashx"
#define ADD_IMAGE @"Report/InsertImgInfo.ashx"
#define ADD_CASE @"Report/InsertReportInfo.ashx"
#define MODIFY_CASE @"Report/UpdateReportInfo.ashx"

#define IMG_KY @"IMG_KY"//影像key
#define REPT_KY @"REPT_KY"//报案key
#define COMP_ID @"COMP_ID"//项目ID
#define CASE_TYPE @"CASE_TYPE"//报案类型
#define MEME_KY @"MEME_KY"//mekey
#define IMAGE_TYPE_DESC @"IMAGE_TYPE_DESC"//影像类型描述
#define IMAGE_TYPE_CODE @"IMAGE_TYPE_CODE"//影像类型代码
#define IMAGE_SIZE @"IMAGE_SIZE"//影像大小
#define UPLOAD_NAME @"UPLOAD_NAME"//上传影像名
#define UPLOAD_USER @"UPLOAD_USER"//上传人
#define InputStream @"InputStream"//影像留文件

#define COMP_NAME @"COMP_NAME"//项目名
#define MNG_ID @"MNG_ID"//所属分之ID
#define MNG_NAME @"MNG_NAME"//所属分支名
#define CLBC_KY @"CLBC_KY"//批次ky
#define CLBC_ID @"CLBC_ID"//批次号
#define CLAP_KY @"CLAP_KY"//申请ky
#define MEME_NAME @"MEME_NAME"//用户名
#define MEME_CERT_ID @"MEME_CERT_ID"//证件号
#define CASE_TYPE @"CASE_TYPE"//报案类型
#define APPL_AMT @"APPL_AMT"//申请金额
#define DEDE_NAME @"DEDE_NAME"//疾病描述
#define VISIT_FRM_DT @"VISIT_FRM_DT"//就诊时间
#define VISIT_TO_DT @"VISIT_TO_DT"//出院时间
#define QUEUE_CODE @"QUEUE_CODE"//任务状态code
#define QUEUE_DESC @"QUEUE_DESC"//任务状态描述
#define SYNC_FLAG @"SYNC_FLAG"//同步标志
#define BANK_CODE @"BANK_CODE"//银行代码
#define BANK_NAME @"BANK_NAME"//银行名
#define ACCOUNT_NO @"ACCOUNT_NO"//卡号
#define ACCOUNT_NAME @"ACCOUNT_NAME"//开户行
#define ZIP_CODE @"ZIP_CODE"//邮编
#define ADDRESS @"ADDRESS"//地址
#define PHONE_NUM @"PHONE_NUM"//手机号
#define REPT_CREATE_USER @"REPT_CREATE_USER"//报案人
#define PLATFORM @"PLATFORM"//平台


/*
 理赔查询
 （1）移动端读取影像
 （2）查询理赔既往信息
 （3）查询发票
 （4）查询责任
 （5）查询保障责任
 （6）查询影像
 （7）查询保单信息
 */

#define DOWNLOAD_IMAGE @"Info/DownloadImage.ashx"
#define GETCLAMSINFO @"Info/GetClaimInfo.ashx"
#define GETCLIVBASEINFO @"Info/GetClivbaseInfo.ashx"
#define GETDUTYBASEINFO @"Info/GetDutybaseInfo.ashx"
#define GETDUTYDESC @"Info/GetDutyDescInfo.ashx"
#define GETIMAGEINFO @"Info/GetImgInfo.ashx"
#define GETPOLICYINFO @"Info/GetPolicyInfo.ashx"

#define PATH @"PATH"//影像路径
#define START_TIME @"START_TIME"//起始时间
#define END_TIME @"END_TIME"//终止时间
#define CLIM_KY @"CLIM_KY"//赔案ky
#define GETDUTY_CD @"GETDUTY_CD"//责任id
#define PLAN_CODE @"PLAN_CODE"//计划code



