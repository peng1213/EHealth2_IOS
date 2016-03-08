//
//  TClaimReportInfo.h
//  EhealthClient
//
//  Created by jiaojunkang on 15-4-28.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "result": {
 "ResultCode": 0,
 "ResultDesc": "成功"
 },
 "model": {
 "KY": "71",
 "MEME_KY": "32321",
 "PLPL_ID": "110001166752088",
 "FILE_TYPE": "PDF",
 "FILE_PATH": "/TempFiles/20150428/110001166752088-32321-1.pdf",
 "FILE_SEZE": "194600",
 "CREATE_DT": "2015-4-28 13:45:17"
 }
 }
 */
@interface TClaimReportInfo : NSObject

@property (strong,nonatomic) NSString * KY ;
@property (strong,nonatomic) NSString * MEME_KY ;
@property (strong,nonatomic) NSString * PLPL_ID;
@property (strong,nonatomic) NSString * FILE_PATH ;
@property (strong,nonatomic) NSString * CREATE_DT ;
@property (strong,nonatomic) NSString * FILE_SEZE;
@end
