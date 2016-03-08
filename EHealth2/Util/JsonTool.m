//
//  JsonTools.m
//  citic
//
//  Created by jiaojunkang on 15-4-3.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JsonTool.h"
@implementation JsonTool


static JsonTool * defaultTool;
+(JsonTool *)defaultTool{
    if(defaultTool==nil){
        defaultTool=[[JsonTool alloc] init];
    }
    return defaultTool;
}


//获取api接口类的返回接口是否正确 0表示正确 大于0表示错误
-(TResult *)getTResultEntity:(NSString * ) requestString
{
    //1.定义返回的实体对象
    TResult *result=[[TResult alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.获取result节点对象
    if([[resultDict allKeys] containsObject:@"result"])
    {
        NSDictionary *dict=[resultDict valueForKey:@"result"];
        //4.把dict中的对象转换为实体对象值 如果返回的对象没有存在与实体那么就返回其他错误
        if([[dict allKeys] containsObject:@"ResultCode"])
        {
            result.ResultCode=[[dict objectForKey:@"ResultCode"] intValue];
            result.ResultDesc=[dict objectForKey:@"ResultDesc"];
        }
        else
        {
            result.ResultCode=92;
            result.ResultDesc=@"数据返回异常，请检查网络或联系管理员！";
        }

        
    }
    else{
        
        result.ResultCode=91;
        result.ResultDesc=@"数据返回异常，请检查网络或联系管理员！";
    }
    
    
    
    
    return result;
}


-(TUserInfo *)getTUserInfoEntity:(NSString *)requestString withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TUserInfo *model =[[TUserInfo alloc] init];
    
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        //4.把dict中的对象转换为实体对象值 如果返回的对象没有存在与实体那么就返回其他错误
        if([[dict allKeys] containsObject:@"USUS_KY"])
            model.USUS_KY=[dict objectForKey:@"USUS_KY"];
        else
            model.USUS_KY=@"";
        if([[dict allKeys] containsObject:@"USUS_ID"])
            model.USUS_ID=[dict objectForKey:@"USUS_ID"];
        else
            model.USUS_ID=@"";
        if([[dict allKeys] containsObject:@"USUS_VIP_ID"])
            model.USUS_VIP_ID=[dict objectForKey:@"USUS_VIP_ID"];
        else
            model.USUS_VIP_ID=@"";
        if([[dict allKeys] containsObject:@"USUS_PWD"])
            model.USUS_PWD=[dict objectForKey:@"USUS_PWD"];
        else
            model.USUS_PWD=@"";
        if([[dict allKeys] containsObject:@"USUS_NAME"])
            model.USUS_NAME=[dict objectForKey:@"USUS_NAME"];
        else
            model.USUS_NAME=@"";
        if([[dict allKeys] containsObject:@"USUS_CERT_NO"])
            model.USUS_CERT_NO=[dict objectForKey:@"USUS_CERT_NO"];
        else
            model.USUS_CERT_NO=@"";
        if([[dict allKeys] containsObject:@"USUS_TYPE"])
            model.USUS_TYPE=[dict objectForKey:@"USUS_TYPE"];
        else
            model.USUS_TYPE=@"";
        if([[dict allKeys] containsObject:@"USUS_STATUS"])
            model.USUS_STATUS=[dict objectForKey:@"USUS_STATUS"];
        else
            model.USUS_STATUS=@"";
        if([[dict allKeys] containsObject:@"COMP_ID"])
            model.COMP_ID=[dict objectForKey:@"COMP_ID"];
        else
            model.COMP_ID=@"";
        if([[dict allKeys] containsObject:@"COMP_NAME"])
            model.COMP_NAME=[dict objectForKey:@"COMP_NAME"];
        else
            model.COMP_NAME=@"";
        if([[dict allKeys] containsObject:@"USUS_MNG_ID"])
            model.USUS_MNG_ID=[dict objectForKey:@"USUS_MNG_ID"];
        else
            model.USUS_MNG_ID=@"";
        if([[dict allKeys] containsObject:@"USUS_MNG_NAME"])
            model.USUS_MNG_NAME=[dict objectForKey:@"USUS_MNG_NAME"];
        else
            model.USUS_MNG_NAME=@"";
        if([[dict allKeys] containsObject:@"GPGP_KY"])
            model.GPGP_KY=[dict objectForKey:@"GPGP_KY"];
        else
            model.GPGP_KY=@"";
        if([[dict allKeys] containsObject:@"GPGP_NAME"])
            model.GPGP_NAME=[dict objectForKey:@"GPGP_NAME"];
        else
            model.GPGP_NAME=@"";
        if([[dict allKeys] containsObject:@"MEME_KY"])
            model.MEME_KY=[dict objectForKey:@"MEME_KY"];
        else
            model.MEME_KY=@"";
        if([[dict allKeys] containsObject:@"MEME_AGE"])
            model.MEME_AGE=[dict objectForKey:@"MEME_AGE"];
        else
            model.MEME_AGE=@"";
        if([[dict allKeys] containsObject:@"MEME_SEX"])
            model.MEME_SEX=[dict objectForKey:@"MEME_SEX"];
        else
            model.MEME_SEX=@"";
        if([[dict allKeys] containsObject:@"USUS_MOBILE_NO"])
            model.USUS_MOBILE_NO=[dict objectForKey:@"USUS_MOBILE_NO"];
        else
            model.USUS_MOBILE_NO=@"";
        if([[dict allKeys] containsObject:@"USUS_EMAIL"])
            model.USUS_EMAIL=[dict objectForKey:@"USUS_EMAIL"];
        else
            model.USUS_EMAIL=@"";
        if([[dict allKeys] containsObject:@"USUS_ADDRESS"])
            model.USUS_ADDRESS=[dict objectForKey:@"USUS_ADDRESS"];
        else
            model.USUS_ADDRESS=@"";
        if([[dict allKeys] containsObject:@"USUS_ZIPCODE"])
            model.USUS_ZIPCODE=[dict objectForKey:@"USUS_ZIPCODE"];
        else
            model.USUS_ZIPCODE=@"";
        if([[dict allKeys] containsObject:@"USUS_CREATE_DT"])
            model.USUS_CREATE_DT=[dict objectForKey:@"USUS_CREATE_DT"];
        else
            model.USUS_CREATE_DT=@"";
        if([[dict allKeys] containsObject:@"USUS_NEXT_ELOGIN_DT"])
            model.USUS_NEXT_ELOGIN_DT=[dict objectForKey:@"USUS_NEXT_ELOGIN_DT"];
        else
            model.USUS_NEXT_ELOGIN_DT=@"";
        if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
            model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
        else
            model.RCD_DTSTMP=@"";
        if([[dict allKeys] containsObject:@"RCD_STS"])
            model.RCD_STS=[dict objectForKey:@"RCD_STS"];
        else
            model.RCD_STS=@"";
        if([[dict allKeys] containsObject:@"RCD_USERID"])
            model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
        else
            model.RCD_USERID=@"";
        if([[dict allKeys] containsObject:@"token"])
            model.token=[dict objectForKey:@"token"];
        else
            model.token=@"";

    }
    
    return model;

}


//从字典中获取对象TReptCaseInfo json->model
-(TReptCaseInfo *) getTReptCaseInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TReptCaseInfo *model =[[TReptCaseInfo alloc] init];
    
    if([[dict allKeys] containsObject:@"REPT_KY"])
        model.REPT_KY=[[dict objectForKey:@"REPT_KY"] intValue];

    else
        model.REPT_KY=0;
    if([[dict allKeys] containsObject:@"REPT_ID"])
        model.REPT_ID=[dict objectForKey:@"REPT_ID"];
    else
        model.REPT_ID=@"";
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID=@"";
    if([[dict allKeys] containsObject:@"COMP_NAME"])
        model.COMP_NAME=[dict objectForKey:@"COMP_NAME"];
    else
        model.COMP_NAME=@"";
    if([[dict allKeys] containsObject:@"MNG_ID"])
        model.MNG_ID=[dict objectForKey:@"MNG_ID"];
    else
        model.MNG_ID=@"";
    if([[dict allKeys] containsObject:@"MNG_NAME"])
        model.MNG_NAME=[dict objectForKey:@"MNG_NAME"];
    else
        model.MNG_NAME=@"";
    if([[dict allKeys] containsObject:@"CLBC_KY"])
        model.CLBC_KY=[dict objectForKey:@"CLBC_KY"];
    else
        model.CLBC_KY=@"";
    if([[dict allKeys] containsObject:@"CLBC_ID"])
        model.CLBC_ID=[dict objectForKey:@"CLBC_ID"];
    else
        model.CLBC_ID=@"";
    if([[dict allKeys] containsObject:@"CLAP_KY"])
        model.CLAP_KY=[dict objectForKey:@"CLAP_KY"];
    else
        model.CLAP_KY=@"";
    if([[dict allKeys] containsObject:@"MEME_KY"])
        model.MEME_KY=[dict objectForKey:@"MEME_KY"];
    else
        model.MEME_KY=@"";
    if([[dict allKeys] containsObject:@"MEME_NAME"])
        model.MEME_NAME=[dict objectForKey:@"MEME_NAME"];
    else
        model.MEME_NAME=@"";
    if([[dict allKeys] containsObject:@"MEME_CERT_ID"])
        model.MEME_CERT_ID=[dict objectForKey:@"MEME_CERT_ID"];
    else
        model.MEME_CERT_ID=@"";
    if([[dict allKeys] containsObject:@"CASE_TYPE"])
        model.CASE_TYPE=[dict objectForKey:@"CASE_TYPE"];
    else
        model.CASE_TYPE=@"";
    if([[dict allKeys] containsObject:@"APPL_AMT"])
        model.APPL_AMT=[dict objectForKey:@"APPL_AMT"];
    else
        model.APPL_AMT=@"";
    if([[dict allKeys] containsObject:@"DEDE_NAME"])
        model.DEDE_NAME=[dict objectForKey:@"DEDE_NAME"];
    else
        model.DEDE_NAME=@"";
    if([[dict allKeys] containsObject:@"VISIT_FRM_DT"])
        model.VISIT_FRM_DT=[dict objectForKey:@"VISIT_FRM_DT"];
    else
        model.VISIT_FRM_DT=@"";
    if([[dict allKeys] containsObject:@"VISIT_TO_DT"])
        model.VISIT_TO_DT=[dict objectForKey:@"VISIT_TO_DT"];
    else
        model.VISIT_TO_DT=@"";
    if([[dict allKeys] containsObject:@"QUEUE_CODE"])
        model.QUEUE_CODE=[dict objectForKey:@"QUEUE_CODE"];
    else
        model.QUEUE_CODE=@"";
    if([[dict allKeys] containsObject:@"QUEUE_DESC"])
        model.QUEUE_DESC=[dict objectForKey:@"QUEUE_DESC"];
    else
        model.QUEUE_DESC=@"";
    if([[dict allKeys] containsObject:@"SYNC_FLAG"])
        model.SYNC_FLAG=[dict objectForKey:@"SYNC_FLAG"];
    else
        model.SYNC_FLAG=@"";
    if([[dict allKeys] containsObject:@"BANK_CODE"])
        model.BANK_CODE=[dict objectForKey:@"BANK_CODE"];
    else
        model.BANK_CODE=@"";
    if([[dict allKeys] containsObject:@"BANK_NAME"])
        model.BANK_NAME=[dict objectForKey:@"BANK_NAME"];
    else
        model.BANK_NAME=@"";
    if([[dict allKeys] containsObject:@"ACCOUNT_NO"])
        model.ACCOUNT_NO=[dict objectForKey:@"ACCOUNT_NO"];
    else
        model.ACCOUNT_NO=@"";
    if([[dict allKeys] containsObject:@"ACCOUNT_NAME"])
        model.ACCOUNT_NAME=[dict objectForKey:@"ACCOUNT_NAME"];
    else
        model.ACCOUNT_NAME=@"";
    if([[dict allKeys] containsObject:@"ZIP_CODE"])
        model.ZIP_CODE=[dict objectForKey:@"ZIP_CODE"];
    else
        model.ZIP_CODE=@"";
    if([[dict allKeys] containsObject:@"ADDRESS"])
        model.ADDRESS=[dict objectForKey:@"ADDRESS"];
    else
        model.ADDRESS=@"";
    if([[dict allKeys] containsObject:@"PHONE_NUM"])
        model.PHONE_NUM=[dict objectForKey:@"PHONE_NUM"];
    else
        model.PHONE_NUM=@"";
    if([[dict allKeys] containsObject:@"REPT_CREATE_DT"])
        model.REPT_CREATE_DT=[dict objectForKey:@"REPT_CREATE_DT"];
    else
        model.REPT_CREATE_DT=@"";
    if([[dict allKeys] containsObject:@"REPT_CREATE_USER"])
        model.REPT_CREATE_USER=[dict objectForKey:@"REPT_CREATE_USER"];
    else
        model.REPT_CREATE_USER=@"";
    if([[dict allKeys] containsObject:@"REPT_REVIEW_DT"])
        model.REPT_REVIEW_DT=[dict objectForKey:@"REPT_REVIEW_DT"];
    else
        model.REPT_REVIEW_DT=@"";
    if([[dict allKeys] containsObject:@"REPT_REVIEW_USER"])
        model.REPT_REVIEW_USER=[dict objectForKey:@"REPT_REVIEW_USER"];
    else
        model.REPT_REVIEW_USER=@"";
    if([[dict allKeys] containsObject:@"REPT_REVIEW_COMMENT"])
        model.REPT_REVIEW_COMMENT=[dict objectForKey:@"REPT_REVIEW_COMMENT"];
    else
        model.REPT_REVIEW_COMMENT=@"";
    if([[dict allKeys] containsObject:@"PLATFORM"])
        model.PLATFORM=[dict objectForKey:@"PLATFORM"];
    else
        model.PLATFORM=@"";
    
    if([[dict allKeys] containsObject:@"HPHP_NAME"])
        model.HPHP_NAME=[dict objectForKey:@"HPHP_NAME"];
    else
        model.HPHP_NAME=@"";
    if([[dict allKeys] containsObject:@"BANK_SITE"])
        model.BANK_SITE=[dict objectForKey:@"BANK_SITE"];
    else
        model.BANK_SITE=@"";
    if([[dict allKeys] containsObject:@"EMAIL"])
        model.EMAIL=[dict objectForKey:@"EMAIL"];
    else
        model.EMAIL=@"";
    if([[dict allKeys] containsObject:@"IMG_COUNT"])
        model.IMG_COUNT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IMG_COUNT"]] ;
    else
        model.IMG_COUNT=@"";
    if([[dict allKeys] containsObject:@"CLIV_COUNT"])
        model.CLIV_COUNT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIV_COUNT"]] ;
    else
        model.CLIV_COUNT=@"";
    
    if([[dict allKeys] containsObject:@"MAIN_MEME_KY"])
        model.MAIN_MEME_KY=[NSString stringWithFormat:@"%@",[dict objectForKey:@"MAIN_MEME_KY"]] ;
    else
        model.MAIN_MEME_KY=@"";
    return model;
    
}



//从获取的json字符串中获取单个实体对象TReptCaseInfo
-(TReptCaseInfo *)getTReptCaseInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TReptCaseInfo *model=[[TReptCaseInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTReptCaseInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象TReptCaseInfo
-(NSMutableArray*) getTReptCaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];

    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:@"model"];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTReptCaseInfoModel:dict]];
        }
        			 }
    return lists;
    
}







//从字典中获取对象 TClaimInfo json->model
-(TClaimInfo *) getTClaimInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TClaimInfo *model =[[TClaimInfo alloc] init];
    if([[dict allKeys] containsObject:@"CLIM_KY"])
        model.CLIM_KY=[dict objectForKey:@"CLIM_KY"];
    else
        model.CLIM_KY=@"";
    if([[dict allKeys] containsObject:@"CLBC_CREATE_DT"])
        model.CLBC_CREATE_DT=[dict objectForKey:@"CLBC_CREATE_DT"];
    else
        model.CLBC_CREATE_DT=@"";
    if([[dict allKeys] containsObject:@"SYSV_QUEUE"])
        model.SYSV_QUEUE=[dict objectForKey:@"SYSV_QUEUE"];
    else
        model.SYSV_QUEUE=@"";
    if([[dict allKeys] containsObject:@"CLIM_ID"])
        model.CLIM_ID=[dict objectForKey:@"CLIM_ID"];
    else
        model.CLIM_ID=@"";
    if([[dict allKeys] containsObject:@"CLIM_TYPE_DESC"])
        model.CLIM_TYPE_DESC=[dict objectForKey:@"CLIM_TYPE_DESC"];
    else
        model.CLIM_TYPE_DESC=@"";
    if([[dict allKeys] containsObject:@"CLIM_REALPAY_AMT"])
        model.CLIM_REALPAY_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIM_REALPAY_AMT"]] ;
    else
        model.CLIM_REALPAY_AMT=@"";
    if([[dict allKeys] containsObject:@"CLIM_APPLY_AMT"])
        model.CLIM_APPLY_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIM_APPLY_AMT"]];
    else
        model.CLIM_APPLY_AMT=@"";
    if([[dict allKeys] containsObject:@"REPORT_ID"])
        model.REPORT_ID=[dict objectForKey:@"REPORT_ID"];
    else
        model.REPORT_ID=@"";
    if([[dict allKeys] containsObject:@"REPORT_TYPE"])
        model.REPORT_TYPE=[dict objectForKey:@"REPORT_TYPE"];
    else
        model.REPORT_TYPE=@"";
    if([[dict allKeys] containsObject:@"CLIM_INSURED_NAME"])
        model.CLIM_INSURED_NAME=[dict objectForKey:@"CLIM_INSURED_NAME"];
    else
        model.CLIM_INSURED_NAME=@"";
    if([[dict allKeys] containsObject:@"PSPS_START_DT"])
        model.PSPS_START_DT=[dict objectForKey:@"PSPS_START_DT"];
    else
        model.PSPS_START_DT=@"";
    if([[dict allKeys] containsObject:@"PSPS_END_DT"])
        model.PSPS_END_DT=[dict objectForKey:@"PSPS_END_DT"];
    else
        model.PSPS_END_DT=@"";
    if([[dict allKeys] containsObject:@"CLIM_TPA_RETURN_DT"])
        model.CLIM_TPA_RETURN_DT=[dict objectForKey:@"CLIM_TPA_RETURN_DT"];
    else
        model.CLIM_TPA_RETURN_DT=@"";
			 
    if([[dict allKeys] containsObject:@"BANK_NAME"])
        model.BANK_NAME=[dict objectForKey:@"BANK_NAME"];
    else
        model.BANK_NAME=@"";
    if([[dict allKeys] containsObject:@"ACCNO"])
        model.ACCNO=[dict objectForKey:@"ACCNO"];
    else
        model.ACCNO=@"";
    return model;
}

//从获取的json字符串中获取单个实体对象 TClaimInfo
-(TClaimInfo *)getTClaimInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TClaimInfo *model=[[TClaimInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTClaimInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TClaimInfo
-(NSMutableArray*) getTClaimInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
 
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTClaimInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TClivbaseInfo json->model
-(TClivbaseInfo *) getTClivbaseInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TClivbaseInfo *model =[[TClivbaseInfo alloc] init];
    if([[dict allKeys] containsObject:@"IMG_KY"])
        model.IMG_KY=[dict objectForKey:@"IMG_KY"];
    else
        model.IMG_KY=@"";
    if([[dict allKeys] containsObject:@"CLIV_ID"])
        model.CLIV_ID=[dict objectForKey:@"CLIV_ID"];
    else
        model.CLIV_ID=@"";
    if([[dict allKeys] containsObject:@"CLIV_TYPE_DESC"])
        model.CLIV_TYPE_DESC=[dict objectForKey:@"CLIV_TYPE_DESC"];
    else
        model.CLIV_TYPE_DESC=@"";
    if([[dict allKeys] containsObject:@"CLIV_FRM_DT"])
        model.CLIV_FRM_DT=[dict objectForKey:@"CLIV_FRM_DT"];
    else
        model.CLIV_FRM_DT=@"";
    if([[dict allKeys] containsObject:@"CLIV_TO_DT"])
        model.CLIV_TO_DT=[dict objectForKey:@"CLIV_TO_DT"];
    else
        model.CLIV_TO_DT=@"";
    if([[dict allKeys] containsObject:@"CLIV_HPHP_NAME"])
        model.CLIV_HPHP_NAME=[dict objectForKey:@"CLIV_HPHP_NAME"];
    else
        model.CLIV_HPHP_NAME=@"";
    if([[dict allKeys] containsObject:@"CLIV_SHIP_AMT"])
        model.CLIV_SHIP_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIV_SHIP_AMT"]];
    else
        model.CLIV_SHIP_AMT=@"";
    if([[dict allKeys] containsObject:@"IVDT_TOTAL_AMT"])
        model.IVDT_TOTAL_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_TOTAL_AMT"]];
    else
        model.IVDT_TOTAL_AMT=@"";
    if([[dict allKeys] containsObject:@"IVDT_OUTOFDUTY_AMT"])
        model.IVDT_OUTOFDUTY_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_OUTOFDUTY_AMT"]];
    else
        model.IVDT_OUTOFDUTY_AMT=@"";
    if([[dict allKeys] containsObject:@"IVDT_DEDUCT_AMT"])
        model.IVDT_DEDUCT_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_DEDUCT_AMT"]];
    else
        model.IVDT_DEDUCT_AMT=@"";
    if([[dict allKeys] containsObject:@"IVDT_REASONABLE_AMT"])
        model.IVDT_REASONABLE_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_REASONABLE_AMT"]];
    else
        model.IVDT_REASONABLE_AMT=@"";
    if([[dict allKeys] containsObject:@"IVDT_REALPAY_AMT"])
        model.IVDT_REALPAY_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_REALPAY_AMT"]];
    else
        model.IVDT_REALPAY_AMT=@"";
    
    if([[dict allKeys] containsObject:@"IVDT_REASONABLE_AMT"])
        model.IVDT_REASONABLE_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_REASONABLE_AMT"]];
    else
        model.IVDT_REASONABLE_AMT=@"";
    
    if([[dict allKeys] containsObject:@"IVDT_DEDUCT_DESC"])
        model.IVDT_DEDUCT_DESC=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IVDT_DEDUCT_DESC"]];
    else
        model.IVDT_DEDUCT_DESC=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TClivbaseInfo
-(TClivbaseInfo *)getTClivbaseInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TClivbaseInfo *model=[[TClivbaseInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTClivbaseInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TClivbaseInfo
-(NSMutableArray*) getTClivbaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
   
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTClivbaseInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TDutybaseInfo json->model
-(TDutybaseInfo *) getTDutybaseInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TDutybaseInfo *model =[[TDutybaseInfo alloc] init];
    if([[dict allKeys] containsObject:@"CLIMDT_TOTAL_AMT"])
        model.CLIMDT_TOTAL_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIMDT_TOTAL_AMT"]];
    else
        model.CLIMDT_TOTAL_AMT=@"";
    if([[dict allKeys] containsObject:@"CLIMDT_PAYPERCENT"])
        model.CLIMDT_PAYPERCENT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIMDT_PAYPERCENT"]];
    else
        model.CLIMDT_PAYPERCENT=@"";
    if([[dict allKeys] containsObject:@"CLIMDT_DEDUCT_AMT"])
        model.CLIMDT_DEDUCT_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIMDT_DEDUCT_AMT"]];
    else
        model.CLIMDT_DEDUCT_AMT=@"";
    if([[dict allKeys] containsObject:@"CLIMDT_REALPAY_AMT"])
        model.CLIMDT_REALPAY_AMT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIMDT_REALPAY_AMT"]];
    else
        model.CLIMDT_REALPAY_AMT=@"";
    if([[dict allKeys] containsObject:@"CLIM_COMMENT"])
        model.CLIM_COMMENT=[NSString stringWithFormat:@"%@",[dict objectForKey:@"CLIM_COMMENT"]];
    else
        model.CLIM_COMMENT=@"";
    if([[dict allKeys] containsObject:@"CLIM_KY"])
        model.CLIM_KY=[dict objectForKey:@"CLIM_KY"];
    else
        model.CLIM_KY=@"";
    if([[dict allKeys] containsObject:@"GETDUTY_CD"])
        model.GETDUTY_CD=[dict objectForKey:@"GETDUTY_CD"];
    else
        model.GETDUTY_CD=@"";
    if([[dict allKeys] containsObject:@"DEDUCT_DESC"])
        model.DEDUCT_DESC=[dict objectForKey:@"DEDUCT_DESC"];
    else
        model.DEDUCT_DESC=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TDutybaseInfo
-(TDutybaseInfo *)getTDutybaseInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TDutybaseInfo *model=[[TDutybaseInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTDutybaseInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TDutybaseInfo
-(NSMutableArray*) getTDutybaseInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTDutybaseInfoModel:dict]];
        }
    }
    return lists;
    
}


//从字典中获取对象 TFunctionInfo json->model
-(TFunctionInfo *) getTFunctionInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TFunctionInfo *model =[[TFunctionInfo alloc] init];
    if([[dict allKeys] containsObject:@"PV_KY"])
        model.PV_KY=[dict objectForKey:@"PV_KY"];
    else
        model.PV_KY=@"";
    if([[dict allKeys] containsObject:@"FUNC_TYPE"])
        model.FUNC_TYPE=[dict objectForKey:@"FUNC_TYPE"];
    else
        model.FUNC_TYPE=@"";
    if([[dict allKeys] containsObject:@"FUNC_ID"])
        model.FUNC_ID=[dict objectForKey:@"FUNC_ID"];
    else
        model.FUNC_ID=@"";
    if([[dict allKeys] containsObject:@"FUNC_NAME"])
        model.FUNC_NAME=[dict objectForKey:@"FUNC_NAME"];
    else
        model.FUNC_NAME=@"";
    if([[dict allKeys] containsObject:@"FUNC_ICON"])
        model.FUNC_ICON=[dict objectForKey:@"FUNC_ICON"];
    else
        model.FUNC_ICON=@"";
    if([[dict allKeys] containsObject:@"ANDROID_CLASS"])
        model.ANDROID_CLASS=[dict objectForKey:@"ANDROID_CLASS"];
    else
        model.ANDROID_CLASS=@"";
    if([[dict allKeys]containsObject:@"IOS_CLASS"])
        model.IOS_CLASS=[dict objectForKey:@"IOS_CLASS"];
    else
        model.IOS_CLASS=@"";
    if([[dict allKeys] containsObject:@"FUNC_COMMENT"])
        model.FUNC_COMMENT=[dict objectForKey:@"FUNC_COMMENT"];
    else
        model.FUNC_COMMENT=@"";
    if([[dict allKeys] containsObject:@"FUNC_PRIORITY"])
        model.FUNC_PRIORITY=[dict objectForKey:@"FUNC_PRIORITY"];
    else
        model.FUNC_PRIORITY=@"";
    if([[dict allKeys] containsObject:@"IS_DEFAULT"])
        model.IS_DEFAULT=[dict objectForKey:@"IS_DEFAULT"];
    else
        model.IS_DEFAULT=@"";
    if([[dict allKeys] containsObject:@"IS_REQUIRED_LOGIN"])
        model.IS_REQUIRED_LOGIN=[dict objectForKey:@"IS_REQUIRED_LOGIN"];
    else
        model.IS_REQUIRED_LOGIN=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TFunctionInfo
-(TFunctionInfo *)getTFunctionInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TFunctionInfo *model=[[TFunctionInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTFunctionInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TFunctionInfo
-(NSMutableArray*) getTFunctionInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTFunctionInfoModel:dict]];
        }
    }
    return lists;
}




//从字典中获取对象 TImgtypeConInfo json->model
-(TImgtypeConInfo *) getTImgtypeConInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TImgtypeConInfo *model =[[TImgtypeConInfo alloc] init];
    if([[dict allKeys] containsObject:@"CON_KY"])
        model.CON_KY=[dict objectForKey:@"CON_KY"];
    else
        model.CON_KY=@"";
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID=@"";
    if([[dict allKeys] containsObject:@"COMP_NAME"])
        model.COMP_NAME=[dict objectForKey:@"COMP_NAME"];
    else
        model.COMP_NAME=@"";
    if([[dict allKeys] containsObject:@"CASE_TYPE"])
        model.CASE_TYPE=[dict objectForKey:@"CASE_TYPE"];
    else
        model.CASE_TYPE=@"";
    if([[dict allKeys] containsObject:@"IMAGE_TYPE_CODE"])
        model.IMAGE_TYPE_CODE=[dict objectForKey:@"IMAGE_TYPE_CODE"];
    else
        model.IMAGE_TYPE_CODE=@"";
    if([[dict allKeys] containsObject:@"IMAGE_TYPE_DESC"])
        model.IMAGE_TYPE_DESC=[dict objectForKey:@"IMAGE_TYPE_DESC"];
    else
        model.IMAGE_TYPE_DESC=@"";
    if([[dict allKeys] containsObject:@"REQUIRED_COUNT"])
        model.REQUIRED_COUNT=[dict objectForKey:@"REQUIRED_COUNT"];
    else
        model.REQUIRED_COUNT=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TImgtypeConInfo
-(TImgtypeConInfo *)getTImgtypeConInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TImgtypeConInfo *model=[[TImgtypeConInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTImgtypeConInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TImgtypeConInfo
-(NSMutableArray*) getTImgtypeConInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
 
        for(NSDictionary * dict in modelDict){
            [lists addObject: [self getTImgtypeConInfoModel:dict]];
        }
    
    return lists;
    
}




//从字典中获取对象 TLoginLogInfo json->model
-(TLoginLogInfo *) getTLoginLogInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TLoginLogInfo *model =[[TLoginLogInfo alloc] init];
    if([[dict allKeys] containsObject:@"SYSV_KY"])
        model.SYSV_KY=[dict objectForKey:@"SYSV_KY"];
    else
        model.SYSV_KY=@"";
    if([[dict allKeys] containsObject:@"USUS_ID"])
        model.USUS_ID=[dict objectForKey:@"USUS_ID"];
    else
        model.USUS_ID=@"";
    if([[dict allKeys] containsObject:@"LOGIN_CLIENT_TYPE"])
        model.LOGIN_CLIENT_TYPE=[dict objectForKey:@"LOGIN_CLIENT_TYPE"];
    else
        model.LOGIN_CLIENT_TYPE=@"";
    if([[dict allKeys] containsObject:@"LOGIN_CLIENT_MODEL"])
        model.LOGIN_CLIENT_MODEL=[dict objectForKey:@"LOGIN_CLIENT_MODEL"];
    else
        model.LOGIN_CLIENT_MODEL=@"";
    if([[dict allKeys] containsObject:@"LOGIN_MACID"])
        model.LOGIN_MACID=[dict objectForKey:@"LOGIN_MACID"];
    else
        model.LOGIN_MACID=@"";
    if([[dict allKeys] containsObject:@"LOGIN_IP"])
        model.LOGIN_IP=[dict objectForKey:@"LOGIN_IP"];
    else
        model.LOGIN_IP=@"";
    if([[dict allKeys] containsObject:@"LOGIN_PROVINCE"])
        model.LOGIN_PROVINCE=[dict objectForKey:@"LOGIN_PROVINCE"];
    else
        model.LOGIN_PROVINCE=@"";
    if([[dict allKeys] containsObject:@"LOGIN_CITY"])
        model.LOGIN_CITY=[dict objectForKey:@"LOGIN_CITY"];
    else
        model.LOGIN_CITY=@"";
    if([[dict allKeys] containsObject:@"LOGIN_COUNTY"])
        model.LOGIN_COUNTY=[dict objectForKey:@"LOGIN_COUNTY"];
    else
        model.LOGIN_COUNTY=@"";
    if([[dict allKeys] containsObject:@"LOGIN_DT"])
        model.LOGIN_DT=[dict objectForKey:@"LOGIN_DT"];
    else
        model.LOGIN_DT=@"";
    if([[dict allKeys] containsObject:@"LOGOUT_DT"])
        model.LOGOUT_DT=[dict objectForKey:@"LOGOUT_DT"];
    else
        model.LOGOUT_DT=@"";
    if([[dict allKeys] containsObject:@"LOGIN_STATUS"])
        model.LOGIN_STATUS=[dict objectForKey:@"LOGIN_STATUS"];
    else
        model.LOGIN_STATUS=@"";
    if([[dict allKeys] containsObject:@"LOGIN_DESC"])
        model.LOGIN_DESC=[dict objectForKey:@"LOGIN_DESC"];
    else
        model.LOGIN_DESC=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TLoginLogInfo
-(TLoginLogInfo *)getTLoginLogInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TLoginLogInfo *model=[[TLoginLogInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTLoginLogInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TLoginLogInfo
-(NSMutableArray*) getTLoginLogInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTLoginLogInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TMemberInfo json->model
-(TMemberInfo *) getTMemberInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TMemberInfo *model =[[TMemberInfo alloc] init];
    if([[dict allKeys] containsObject:@"MEME_KY"])
        model.MEME_KY=[dict objectForKey:@"MEME_KY"];
    else
        model.MEME_KY=@"";
    if([[dict allKeys] containsObject:@"MEME_NAME"])
        model.MEME_NAME=[dict objectForKey:@"MEME_NAME"];
    else
        model.MEME_NAME=@"";
    if([[dict allKeys] containsObject:@"MEME_CERT_ID_NUM"])
        model.MEME_CERT_ID_NUM=[dict objectForKey:@"MEME_CERT_ID_NUM"];
    else
        model.MEME_CERT_ID_NUM=@"";
    if([[dict allKeys] containsObject:@"MEME_RELATION_DESC"])
        model.MEME_RELATION_DESC=[dict objectForKey:@"MEME_RELATION_DESC"];
    else
        model.MEME_RELATION_DESC=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TMemberInfo
-(TMemberInfo *)getTMemberInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TMemberInfo *model=[[TMemberInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTMemberInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TMemberInfo
-(NSMutableArray*) getTMemberInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTMemberInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TOperateLogInfo json->model
-(TOperateLogInfo *) getTOperateLogInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TOperateLogInfo *model =[[TOperateLogInfo alloc] init];
    if([[dict allKeys] containsObject:@"LG_KY"])
        model.LG_KY=[dict objectForKey:@"LG_KY"];
    else
        model.LG_KY=@"";
    if([[dict allKeys] containsObject:@"USUS_ID"])
        model.USUS_ID=[dict objectForKey:@"USUS_ID"];
    else
        model.USUS_ID=@"";
    if([[dict allKeys] containsObject:@"OPERATE_TYPE"])
        model.OPERATE_TYPE=[dict objectForKey:@"OPERATE_TYPE"];
    else
        model.OPERATE_TYPE=@"";
    if([[dict allKeys] containsObject:@"OPERATE_DESC"])
        model.OPERATE_DESC=[dict objectForKey:@"OPERATE_DESC"];
    else
        model.OPERATE_DESC=@"";
    if([[dict allKeys] containsObject:@"OPERATE_USER_ID"])
        model.OPERATE_USER_ID=[dict objectForKey:@"OPERATE_USER_ID"];
    else
        model.OPERATE_USER_ID=@"";
    if([[dict allKeys] containsObject:@"OPERATE_DT"])
        model.OPERATE_DT=[dict objectForKey:@"OPERATE_DT"];
    else
        model.OPERATE_DT=@"";
    if([[dict allKeys] containsObject:@"OPERATE_DESC1"])
        model.OPERATE_DESC1=[dict objectForKey:@"OPERATE_DESC1"];
    else
        model.OPERATE_DESC1=@"";
    if([[dict allKeys] containsObject:@"OPERATE_DESC2"])
        model.OPERATE_DESC2=[dict objectForKey:@"OPERATE_DESC2"];
    else
        model.OPERATE_DESC2=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TOperateLogInfo
-(TOperateLogInfo *)getTOperateLogInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TOperateLogInfo *model=[[TOperateLogInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTOperateLogInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TOperateLogInfo
-(NSMutableArray*) getTOperateLogInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTOperateLogInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TPffcLinkInfo json->model
-(TPffcLinkInfo *) getTPffcLinkInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TPffcLinkInfo *model =[[TPffcLinkInfo alloc] init];
    if([[dict allKeys] containsObject:@"PSFC_KY"])
        model.PSFC_KY=[dict objectForKey:@"PSFC_KY"];
    else
        model.PSFC_KY=@"";
    if([[dict allKeys] containsObject:@"PFPF_ID"])
        model.PFPF_ID=[dict objectForKey:@"PFPF_ID"];
    else
        model.PFPF_ID=@"";
    if([[dict allKeys] containsObject:@"FUNC_ID"])
        model.FUNC_ID=[dict objectForKey:@"FUNC_ID"];
    else
        model.FUNC_ID=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TPffcLinkInfo
-(TPffcLinkInfo *)getTPffcLinkInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TPffcLinkInfo *model=[[TPffcLinkInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTPffcLinkInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TPffcLinkInfo
-(NSMutableArray*) getTPffcLinkInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTPffcLinkInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TPolicyInfo json->model
-(TPolicyInfo *) getTPolicyInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TPolicyInfo *model =[[TPolicyInfo alloc] init];
    if([[dict allKeys] containsObject:@"PLPL_ID"])
        model.PLPL_ID=[dict objectForKey:@"PLPL_ID"];
    else
        model.PLPL_ID=@"";
    if([[dict allKeys] containsObject:@"SYSV_PSPS_PLAN_CODE"])
        model.SYSV_PSPS_PLAN_CODE=[dict objectForKey:@"SYSV_PSPS_PLAN_CODE"];
    else
        model.SYSV_PSPS_PLAN_CODE=@"";
    if([[dict allKeys] containsObject:@"PSPS_START_DT"])
        model.PSPS_START_DT=[dict objectForKey:@"PSPS_START_DT"];
    else
        model.PSPS_START_DT=@"";
    if([[dict allKeys] containsObject:@"PSPS_END_DT"])
        model.PSPS_END_DT=[dict objectForKey:@"PSPS_END_DT"];
    else
        model.PSPS_END_DT=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TPolicyInfo
-(TPolicyInfo *)getTPolicyInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TPolicyInfo *model=[[TPolicyInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTPolicyInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TPolicyInfo
-(NSMutableArray*) getTPolicyInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTPolicyInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TProfileInfo json->model
-(TProfileInfo *) getTProfileInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TProfileInfo *model =[[TProfileInfo alloc] init];
    if([[dict allKeys] containsObject:@"PFPF_KY"])
        model.PFPF_KY=[dict objectForKey:@"PFPF_KY"];
    else
        model.PFPF_KY=@"";
    if([[dict allKeys] containsObject:@"PFPF_ID"])
        model.PFPF_ID=[dict objectForKey:@"PFPF_ID"];
    else
        model.PFPF_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_NAME"])
        model.PFPF_NAME=[dict objectForKey:@"PFPF_NAME"];
    else
        model.PFPF_NAME=@"";
    if([[dict allKeys] containsObject:@"PFPF_DESC"])
        model.PFPF_DESC=[dict objectForKey:@"PFPF_DESC"];
    else
        model.PFPF_DESC=@"";
    if([[dict allKeys] containsObject:@"PFPF_COMP_ID"])
        model.PFPF_COMP_ID=[dict objectForKey:@"PFPF_COMP_ID"];
    else
        model.PFPF_COMP_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_COMP_NAME"])
        model.PFPF_COMP_NAME=[dict objectForKey:@"PFPF_COMP_NAME"];
    else
        model.PFPF_COMP_NAME=@"";
    if([[dict allKeys] containsObject:@"PFPF_MNG_ID"])
        model.PFPF_MNG_ID=[dict objectForKey:@"PFPF_MNG_ID"];
    else
        model.PFPF_MNG_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_MNG_NAME"])
        model.PFPF_MNG_NAME=[dict objectForKey:@"PFPF_MNG_NAME"];
    else
        model.PFPF_MNG_NAME=@"";
    if([[dict allKeys] containsObject:@"PFPF_CREATE_DT"])
        model.PFPF_CREATE_DT=[dict objectForKey:@"PFPF_CREATE_DT"];
    else
        model.PFPF_CREATE_DT=@"";
    if([[dict allKeys] containsObject:@"PFPF_CREATE_USUS_ID"])
        model.PFPF_CREATE_USUS_ID=[dict objectForKey:@"PFPF_CREATE_USUS_ID"];
    else
        model.PFPF_CREATE_USUS_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_COMMENT"])
        model.PFPF_COMMENT=[dict objectForKey:@"PFPF_COMMENT"];
    else
        model.PFPF_COMMENT=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TProfileInfo
-(TProfileInfo *)getTProfileInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TProfileInfo *model=[[TProfileInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTProfileInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TProfileInfo
-(NSMutableArray*) getTProfileInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTProfileInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TReptBankInfo json->model
-(TReptBankInfo *) getTReptBankInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TReptBankInfo *model =[[TReptBankInfo alloc] init];
    if([[dict allKeys] containsObject:@"BANK_KY"])
        model.BANK_KY=[dict objectForKey:@"BANK_KY"];
    else
        model.BANK_KY=@"";
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID=@"";
    if([[dict allKeys] containsObject:@"CMOP_NAME"])
        model.CMOP_NAME=[dict objectForKey:@"CMOP_NAME"];
    else
        model.CMOP_NAME=@"";
    if([[dict allKeys] containsObject:@"BANK_CODE"])
        model.BANK_CODE=[dict objectForKey:@"BANK_CODE"];
    else
        model.BANK_CODE=@"";
    if([[dict allKeys] containsObject:@"BANK_NAME"])
        model.BANK_NAME=[dict objectForKey:@"BANK_NAME"];
    else
        model.BANK_NAME=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TReptBankInfo
-(TReptBankInfo *)getTReptBankInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TReptBankInfo *model=[[TReptBankInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTReptBankInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TReptBankInfo
-(NSMutableArray*) getTReptBankInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
 
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTReptBankInfoModel:dict]];
        }
    }
    return lists;
    
}





//从字典中获取对象 TReptImgInfo json->model
-(TReptImgInfo *) getTReptImgInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TReptImgInfo *model =[[TReptImgInfo alloc] init];
    if([[dict allKeys] containsObject:@"IMG_KY"])
        model.IMG_KY=[dict objectForKey:@"IMG_KY"];
    else
        model.IMG_KY=@"";
    if([[dict allKeys] containsObject:@"REPT_KY"])
        model.REPT_KY=[dict objectForKey:@"REPT_KY"];
    else
        model.REPT_KY=@"";
    if([[dict allKeys] containsObject:@"IMAGE_TYPE_DESC"])
        model.IMAGE_TYPE_DESC=[dict objectForKey:@"IMAGE_TYPE_DESC"];
    else
        model.IMAGE_TYPE_DESC=@"";
    if([[dict allKeys] containsObject:@"IMAGE_TYPE_CODE"])
        model.IMAGE_TYPE_CODE=[dict objectForKey:@"IMAGE_TYPE_CODE"];
    else
        model.IMAGE_TYPE_CODE=@"";
    if([[dict allKeys] containsObject:@"IMAGE_NAME"])
        model.IMAGE_NAME=[dict objectForKey:@"IMAGE_NAME"];
    else
        model.IMAGE_NAME=@"";
    if([[dict allKeys] containsObject:@"IMAGE_PATH"])
        model.IMAGE_PATH=[dict objectForKey:@"IMAGE_PATH"];
    else
        model.IMAGE_PATH=@"";
    if([[dict allKeys] containsObject:@"IMAGE_SIZE"])
        model.IMAGE_SIZE=[dict objectForKey:@"IMAGE_SIZE"];
    else
        model.IMAGE_SIZE=@"";
    if([[dict allKeys] containsObject:@"UPLOAD_DT"])
        model.UPLOAD_DT=[dict objectForKey:@"UPLOAD_DT"];
    else
        model.UPLOAD_DT=@"";
    if([[dict allKeys] containsObject:@"UPLOAD_NAME"])
        model.UPLOAD_NAME=[dict objectForKey:@"UPLOAD_NAME"];
    else
        model.UPLOAD_NAME=@"";
    if([[dict allKeys] containsObject:@"UPLOAD_USER"])
        model.UPLOAD_USER=[dict objectForKey:@"UPLOAD_USER"];
    else
        model.UPLOAD_USER=@"";
			 
    if([[dict allKeys] containsObject:@"IMAGE_URL_SYNC"])
        model.IMAGE_URL_SYNC=[dict objectForKey:@"IMAGE_URL_SYNC"];
    else
        model.IMAGE_URL_SYNC=@"";
    return model;
}

//从获取的json字符串中获取单个实体对象 TReptImgInfo
-(TReptImgInfo *)getTReptImgInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TReptImgInfo *model=[[TReptImgInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTReptImgInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TReptImgInfo
-(NSMutableArray*) getTReptImgInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
 
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTReptImgInfoModel:dict]];
        }
    }
    return lists;
    
}

//从字典中获取对象 TUserInfo json->model
-(TUserInfo *) getTUserInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TUserInfo *model =[[TUserInfo alloc] init];
    if([[dict allKeys] containsObject:@"USUS_KY"])
        model.USUS_KY=[dict objectForKey:@"USUS_KY"];
    else
        model.USUS_KY=@"";
    if([[dict allKeys] containsObject:@"USUS_ID"])
        model.USUS_ID=[dict objectForKey:@"USUS_ID"];
    else
        model.USUS_ID=@"";
    if([[dict allKeys] containsObject:@"USUS_VIP_ID"])
        model.USUS_VIP_ID=[dict objectForKey:@"USUS_VIP_ID"];
    else
        model.USUS_VIP_ID=@"";
    if([[dict allKeys] containsObject:@"USUS_PWD"])
        model.USUS_PWD=[dict objectForKey:@"USUS_PWD"];
    else
        model.USUS_PWD=@"";
    if([[dict allKeys] containsObject:@"USUS_NAME"])
        model.USUS_NAME=[dict objectForKey:@"USUS_NAME"];
    else
        model.USUS_NAME=@"";
    if([[dict allKeys] containsObject:@"USUS_CERT_NO"])
        model.USUS_CERT_NO=[dict objectForKey:@"USUS_CERT_NO"];
    else
        model.USUS_CERT_NO=@"";
    if([[dict allKeys] containsObject:@"USUS_TYPE"])
        model.USUS_TYPE=[dict objectForKey:@"USUS_TYPE"];
    else
        model.USUS_TYPE=@"";
    if([[dict allKeys] containsObject:@"USUS_STATUS"])
        model.USUS_STATUS=[dict objectForKey:@"USUS_STATUS"];
    else
        model.USUS_STATUS=@"";
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID=@"";
    if([[dict allKeys] containsObject:@"COMP_NAME"])
        model.COMP_NAME=[dict objectForKey:@"COMP_NAME"];
    else
        model.COMP_NAME=@"";
    if([[dict allKeys] containsObject:@"USUS_MNG_ID"])
        model.USUS_MNG_ID=[dict objectForKey:@"USUS_MNG_ID"];
    else
        model.USUS_MNG_ID=@"";
    if([[dict allKeys] containsObject:@"USUS_MNG_NAME"])
        model.USUS_MNG_NAME=[dict objectForKey:@"USUS_MNG_NAME"];
    else
        model.USUS_MNG_NAME=@"";
    if([[dict allKeys] containsObject:@"GPGP_KY"])
        model.GPGP_KY=[dict objectForKey:@"GPGP_KY"];
    else
        model.GPGP_KY=@"";
    if([[dict allKeys] containsObject:@"GPGP_NAME"])
        model.GPGP_NAME=[dict objectForKey:@"GPGP_NAME"];
    else
        model.GPGP_NAME=@"";
    if([[dict allKeys] containsObject:@"MEME_KY"])
        model.MEME_KY=[dict objectForKey:@"MEME_KY"];
    else
        model.MEME_KY=@"";
    if([[dict allKeys] containsObject:@"MEME_AGE"])
        model.MEME_AGE=[dict objectForKey:@"MEME_AGE"];
    else
        model.MEME_AGE=@"";
    if([[dict allKeys] containsObject:@"MEME_SEX"])
        model.MEME_SEX=[dict objectForKey:@"MEME_SEX"];
    else
        model.MEME_SEX=@"";
    if([[dict allKeys] containsObject:@"USUS_MOBILE_NO"])
        model.USUS_MOBILE_NO=[dict objectForKey:@"USUS_MOBILE_NO"];
    else
        model.USUS_MOBILE_NO=@"";
    if([[dict allKeys] containsObject:@"USUS_EMAIL"])
        model.USUS_EMAIL=[dict objectForKey:@"USUS_EMAIL"];
    else
        model.USUS_EMAIL=@"";
    if([[dict allKeys] containsObject:@"USUS_ADDRESS"])
        model.USUS_ADDRESS=[dict objectForKey:@"USUS_ADDRESS"];
    else
        model.USUS_ADDRESS=@"";
    if([[dict allKeys] containsObject:@"USUS_ZIPCODE"])
        model.USUS_ZIPCODE=[dict objectForKey:@"USUS_ZIPCODE"];
    else
        model.USUS_ZIPCODE=@"";
    if([[dict allKeys] containsObject:@"USUS_CREATE_DT"])
        model.USUS_CREATE_DT=[dict objectForKey:@"USUS_CREATE_DT"];
    else
        model.USUS_CREATE_DT=@"";
    if([[dict allKeys] containsObject:@"USUS_NEXT_ELOGIN_DT"])
        model.USUS_NEXT_ELOGIN_DT=[dict objectForKey:@"USUS_NEXT_ELOGIN_DT"];
    else
        model.USUS_NEXT_ELOGIN_DT=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TUserInfo
-(TUserInfo *)getTUserInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TUserInfo *model=[[TUserInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTUserInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TUserInfo
-(NSMutableArray*) getTUserInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTUserInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TUspfLinkInfo json->model
-(TUspfLinkInfo *) getTUspfLinkInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TUspfLinkInfo *model =[[TUspfLinkInfo alloc] init];
    if([[dict allKeys] containsObject:@"USPF_KY"])
        model.USPF_KY=[dict objectForKey:@"USPF_KY"];
    else
        model.USPF_KY=@"";
    if([[dict allKeys] containsObject:@"USUS_ID"])
        model.USUS_ID=[dict objectForKey:@"USUS_ID"];
    else
        model.USUS_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_ID"])
        model.PFPF_ID=[dict objectForKey:@"PFPF_ID"];
    else
        model.PFPF_ID=@"";
    if([[dict allKeys] containsObject:@"PFPF_COMMENT"])
        model.PFPF_COMMENT=[dict objectForKey:@"PFPF_COMMENT"];
    else
        model.PFPF_COMMENT=@"";
    if([[dict allKeys] containsObject:@"RCD_DTSTMP"])
        model.RCD_DTSTMP=[dict objectForKey:@"RCD_DTSTMP"];
    else
        model.RCD_DTSTMP=@"";
    if([[dict allKeys] containsObject:@"RCD_STS"])
        model.RCD_STS=[dict objectForKey:@"RCD_STS"];
    else
        model.RCD_STS=@"";
    if([[dict allKeys] containsObject:@"RCD_USERID"])
        model.RCD_USERID=[dict objectForKey:@"RCD_USERID"];
    else
        model.RCD_USERID=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TUspfLinkInfo
-(TUspfLinkInfo *)getTUspfLinkInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TUspfLinkInfo *model=[[TUspfLinkInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTUspfLinkInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TUspfLinkInfo
-(NSMutableArray*) getTUspfLinkInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTUspfLinkInfoModel:dict]];
        }
    }
    return lists;
    
}




//从字典中获取对象 TVersionInfo json->model
-(TVersionInfo *) getTVersionInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TVersionInfo *model =[[TVersionInfo alloc] init];
    if([[dict allKeys] containsObject:@"SYSV_KY"])
        model.SYSV_KY=[dict objectForKey:@"SYSV_KY"];
    else
        model.SYSV_KY=@"";
    if([[dict allKeys] containsObject:@"VERSION_ID"])
        model.VERSION_ID=[dict objectForKey:@"VERSION_ID"];
    else
        model.VERSION_ID=@"";
    if([[dict allKeys] containsObject:@"VERSION_NAME"])
        model.VERSION_NAME=[dict objectForKey:@"VERSION_NAME"];
    else
        model.VERSION_NAME=@"";
    if([[dict allKeys] containsObject:@"VERSION_PATH"])
        model.VERSION_PATH=[dict objectForKey:@"VERSION_PATH"];
    else
        model.VERSION_PATH=@"";
    if([[dict allKeys] containsObject:@"VERSION_DT"])
        model.VERSION_DT=[dict objectForKey:@"VERSION_DT"];
    else
        model.VERSION_DT=@"";
    if([[dict allKeys] containsObject:@"UPLOAD_USER"])
        model.UPLOAD_USER=[dict objectForKey:@"UPLOAD_USER"];
    else
        model.UPLOAD_USER=@"";
    if([[dict allKeys] containsObject:@"PLATFORM"])
        model.PLATFORM=[dict objectForKey:@"PLATFORM"];
    else
        model.PLATFORM=@"";
    if([[dict allKeys] containsObject:@"VERSION_LOG"])
        model.VERSION_LOG=[dict objectForKey:@"VERSION_LOG"];
    else
        model.VERSION_LOG=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TVersionInfo
-(TVersionInfo *)getTVersionInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TVersionInfo *model=[[TVersionInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTVersionInfoModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TVersionInfo
-(NSMutableArray*) getTVersionInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *modelDict=[resultDict valueForKey:jsonKey];
    //4.判断是否存在此节点，存在就返回对象
    if([[modelDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[modelDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTVersionInfoModel:dict]];
        }
    }
    return lists;
    
}







//从字典中获取对象 TDutyDesc json->model
-(TDutyDesc *) getTDutyDescModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TDutyDesc *model =[[TDutyDesc alloc] init];
    if([[dict allKeys] containsObject:@"DESC_TITLE"])
        model.DESC_TITLE=[dict objectForKey:@"DESC_TITLE"];
    else
        model.DESC_TITLE=@"";
    if([[dict allKeys] containsObject:@"DESC_CONTENT"])
        model.DESC_CONTENT=[dict objectForKey:@"DESC_CONTENT"];
    else
        model.DESC_CONTENT=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TDutyDesc
-(TDutyDesc *)getTDutyDesc:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TDutyDesc *model=[[TDutyDesc alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTDutyDescModel:dict];
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TDutyDesc
-(NSMutableArray*) getTDutyDescList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:100];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTDutyDescModel:dict]];
        }
    }
    return lists;
    
}




-(NSString*)getString:(NSDictionary*)dic withKey:(NSString *)key
{
    if([[dic allKeys] containsObject:key])
        return [dic objectForKey:key];
    return @"";
}

-(HelpInfo*)getHelpInfoModel:(NSDictionary * ) dict
{
    HelpInfo *model =[[HelpInfo alloc] init];
    if([[dict allKeys] containsObject:@"ID"])
        model.ID=[dict objectForKey:@"ID"];
    else
        model.ID=@"";
    if([[dict allKeys] containsObject:@"NAV_TITLE"])
        model.NAV_TITLE=[dict objectForKey:@"NAV_TITLE"];
    else
        model.NAV_TITLE=@"";
    if([[dict allKeys] containsObject:@"HELP_TITLE"])
        model.HELP_TITLE=[dict objectForKey:@"HELP_TITLE"];
    else
        model.HELP_TITLE=@"";
    if([[dict allKeys] containsObject:@"HELP_DESC"])
        model.HELP_DESC=[dict objectForKey:@"HELP_DESC"];
    else
        model.HELP_DESC=@"";
    return  model;
}



//从字典中获取对象 TImgInfo json->model
-(TImgInfo *) getTImgInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TImgInfo *model =[[TImgInfo alloc] init];
    if([[dict allKeys] containsObject:@"IMG_KY"])
        model.IMG_KY=[dict objectForKey:@"IMG_KY"];
    else
        model.IMG_KY=@"";
    if([[dict allKeys] containsObject:@"IMG_NAME"])
        model.IMG_NAME=[dict objectForKey:@"IMG_NAME"];
    else
        model.IMG_NAME=@"";
    if([[dict allKeys] containsObject:@"IMG_TYPE_DESC"])
        model.IMG_TYPE_DESC=[dict objectForKey:@"IMG_TYPE_DESC"];
    else
        model.IMG_TYPE_DESC=@"";
    if([[dict allKeys] containsObject:@"IMG_PATH"])
        model.IMG_PATH=[dict objectForKey:@"IMG_PATH"];
    else
        model.IMG_PATH=@"";
    if([[dict allKeys] containsObject:@"CLIM_KY"])
        model.CLIM_KY=[dict objectForKey:@"CLIM_KY"];
    else
        model.CLIM_KY=@"";
			 
    return model;
}

//从获取的json字符串中获取单个实体对象 TImgInfo
-(TImgInfo *)getTImgInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TImgInfo *model=[[TImgInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            model =[self getTImgInfoModel:dict];
            break;
        }
    }
    return model;
}

//从获取的json字符串中获取model部分初始化成为对象 TImgInfo
-(NSMutableArray*) getTImgInfoList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getTImgInfoModel:dict]];
        }
    }
    return lists;
    
}


-(NSMutableArray*) getHelpNavList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getString:dict withKey:@"FUNC_NAME"]];
        }
    }
    return lists;
    
}


-(NSMutableArray*) getHelpItemList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:20];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getHelpInfoModel:dict]];
        }
    }
    return lists;
    
}


//从获取的json字符串中获取单个实体对象 TImgInfo
-(TClaimReportInfo *)getTClaimReportInfo:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    //1.定义返回的实体对象
    TClaimReportInfo *model=[[TClaimReportInfo alloc] init];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if ([[resultDict allKeys] containsObject:jsonKey]) {
        
        NSDictionary *dict=[resultDict valueForKey:jsonKey];
        model =[self getTClaimReportInfoModel:dict];
    }
    return model;
}


//从字典中获取对象 TImgInfo json->model
-(TClaimReportInfo *) getTClaimReportInfoModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    TClaimReportInfo *model =[[TClaimReportInfo alloc] init];
    if([[dict allKeys] containsObject:@"KY"])
        model.KY=[dict objectForKey:@"KY"];
    else
        model.KY=@"";
    if([[dict allKeys] containsObject:@"PLPL_ID"])
        model.PLPL_ID=[dict objectForKey:@"PLPL_ID"];
    else
        model.PLPL_ID=@"";
    if([[dict allKeys] containsObject:@"CREATE_DT"])
        model.CREATE_DT=[dict objectForKey:@"CREATE_DT"];
    else
        model.CREATE_DT=@"";
    if([[dict allKeys] containsObject:@"FILE_PATH"])
        model.FILE_PATH=[dict objectForKey:@"FILE_PATH"];
    else
        model.FILE_PATH=@"";
    if([[dict allKeys] containsObject:@"FILE_SEZE"])
        model.FILE_SEZE=[dict objectForKey:@"FILE_SEZE"];
    else
        model.FILE_SEZE=@"";
    
    if([[dict allKeys] containsObject:@"MEME_KY"])
        model.MEME_KY=[dict objectForKey:@"MEME_KY"];
    else
        model.MEME_KY=@"";
			 
    return model;
}

-(NSMutableArray*) getFieldConfigList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:50];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getFieldConfigModel:dict]];
        }
    }
    return lists;
    
}

-(FieldConfig *) getFieldConfigModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    FieldConfig *model =[[FieldConfig alloc] init];
    if([[dict allKeys] containsObject:@"FUNC_NAME"])
        model.FUNC_NAME=[dict objectForKey:@"FUNC_NAME"];
    else
        model.FUNC_NAME=@"";
    if([[dict allKeys] containsObject:@"COMP_NAME"])
        model.COMP_NAME1=[dict objectForKey:@"COMP_NAME"];
    else
        model.COMP_NAME1=@"";
    if([[dict allKeys] containsObject:@"IS_REQUIRED"])
        model.IS_REQUIRED=[dict objectForKey:@"IS_REQUIRED"];
    else
        model.IS_REQUIRED=@"";
    if([[dict allKeys] containsObject:@"FIELD_KY"])
        model.FIELD_KY=[dict objectForKey:@"FIELD_KY"];
    else
        model.FIELD_KY=@"";
    if([[dict allKeys] containsObject:@"FIELD_DESC"])
        model.FIELD_DESC=[dict objectForKey:@"FIELD_DESC"];
    else
        model.FIELD_DESC=@"";
    
    if([[dict allKeys] containsObject:@"FIELD_NAME"])
        model.FIELD_NAME=[dict objectForKey:@"FIELD_NAME"];
    else
        model.FIELD_NAME=@"";
			 
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID1=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID1=@"";
    if([[dict allKeys] containsObject:@"IS_SHOW"])
        model.IS_SHOW=[dict objectForKey:@"IS_SHOW"];
    else
        model.IS_SHOW=@"";
    if([[dict allKeys] containsObject:@"SEQ"])
        model.SEQ=[dict objectForKey:@"SEQ"];
    else
        model.SEQ=@"";
    if([[dict allKeys] containsObject:@"FIELD_DISP_NAME"])
        model.FIELD_DISP_NAME=[dict objectForKey:@"FIELD_DISP_NAME"];
    else
        model.FIELD_DISP_NAME=@"";
    return model;
}
-(NSMutableArray*) getBannerList:(NSString *) requestString  withKey:(NSString *)jsonKey
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:50];
    //2.把NSString转换为NSData
    NSData * jsonData=[requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.把jsonData转换为NSDictionary
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //4.判断是否存在此节点，存在就返回对象
    if([[resultDict allKeys] containsObject:jsonKey])
    {
        NSDictionary *dicts=[resultDict valueForKey:jsonKey];
        for(NSDictionary * dict in dicts){
            [lists addObject: [self getBannerModel:dict]];
        }
    }
    return lists;
}

-(Banner *) getBannerModel:(NSDictionary * ) dict
{
    //1.定义返回的实体对象
    Banner *model =[[Banner alloc] init];
    if([[dict allKeys] containsObject:@"KY"])
        model.KY=[dict objectForKey:@"KY"];
    else
        model.KY=@"";
    if([[dict allKeys] containsObject:@"COMP_NAME"])
        model.COMP_NAME=[dict objectForKey:@"COMP_NAME"];
    else
        model.COMP_NAME=@"";
    if([[dict allKeys] containsObject:@"COMP_ID"])
        model.COMP_ID=[dict objectForKey:@"COMP_ID"];
    else
        model.COMP_ID=@"";
    
    if([[dict allKeys] containsObject:@"IMG_PATH"])
        model.IMG_PATH=[dict objectForKey:@"IMG_PATH"];
    else
        model.IMG_PATH=@"";
    if([[dict allKeys] containsObject:@"IMG_NAME"])
        model.IMG_NAME=[dict objectForKey:@"IMG_NAME"];
    else
        model.IMG_NAME=@"";
    if([[dict allKeys] containsObject:@"TYPE"])
        model.TYPE=[dict objectForKey:@"TYPE"];
    else
        model.TYPE=@"";
    
    if([[dict allKeys] containsObject:@"ANDROID_CLASS"])
        model.ANDROID_CLASS=[dict objectForKey:@"ANDROID_CLASS"];
    else
        model.ANDROID_CLASS=@"";
    if([[dict allKeys] containsObject:@"IOS_CLASS"])
        model.IOS_CLASS=[dict objectForKey:@"IOS_CLASS"];
    else
        model.IOS_CLASS=@"";
    if([[dict allKeys] containsObject:@"URL"])
        model.URL=[dict objectForKey:@"URL"];
    else
        model.URL=@"";
    if([[dict allKeys] containsObject:@"UPLOAD_USER"])
        model.UPLOAD_USER=[dict objectForKey:@"UPLOAD_USER"];
    else
        model.UPLOAD_USER=@"";
    
    if([[dict allKeys] containsObject:@"UPLOAD_TIME"])
        model.UPLOAD_TIME=[dict objectForKey:@"UPLOAD_TIME"];
    else
        model.UPLOAD_TIME=@"";
    return model;
}
@end
