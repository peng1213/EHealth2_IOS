//
//  CommonUtil.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "FieldConfig.h"
#import "UIView+Toast.h"
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

    //#F0F0F0  默认灰色
    //＃519CEA 默认蓝色
    //＃27AE60 默认绿色
@interface CommonUtil : NSObject

/**
 *  16进制色值转化
 *
 *  @param hexColor 16进制颜色
 *  @param alpha
 *
 *  @return UIColor
 */
+ (id)getColor:(NSString *)hexColor withAlpha:(float)alpha;

/**
 *  (1)获取当前时间
 *  (2)获取系统时间
 *  (3)获取Date
 *  (4)格式化Date
 *  (5)获取格式化时间
 *  @return
 */
+(NSString *)getCurrentTime;
+(NSString *)getSysTime;
+(NSDate *)getDateTime:(NSString *)time;
+(NSDate *)getDateFormatterTime:(NSString *)time;
+(NSString *)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date;
+ (NSString*) stringWithUUID;
    //计算动态文本的Size
+ (CGSize)caluteSize:(NSString *)content font:(UIFont *)textFont sizewidth:(float)width;

//base64
+ (NSData *)base64Decode:(NSString *)string;
+ (NSString *)base64Encode:(NSData *)data;

+ (NSString *)encodeBase64:(NSString * )string;//编码
+ (NSString *)decodeBase64:(NSString * )string;//解码

    //MD5
+ (NSString *)MD5:(NSString *)string;

    //SHA1
+ (NSString *)SHA1:(NSString *)string;

    //AES
- (NSData *)AES256EncryptWithKey:(NSString *)key palantStr:(NSData *)contentData;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key palantStr:(NSData *)contentData;   //解密
- (BOOL)isValidateWithRegex:(NSString *)regex textContent:(NSString *)content;
    //验证通讯号码
+ (BOOL)validateMobile:(NSString *)mobileNum;

    //联通手机号码验证
+ (NSString *)validateCUMobile:(NSString *)mobileNum;

    //计算秒数
+ (int)caculateTime:(NSString *)date;

+ (NSString *)createUUID;

    //处理％特殊字符
+ (NSString *)contentChangedPersentWith:(NSString *)contentText;

    //计算星期几
+ (NSString*)getWeek:(NSString*)date;

+ (BOOL)isMobile:(NSString *)mobileNum;

    //验证邮箱
- (BOOL)isValidEmail:(NSString *)textContent;

    //验证车牌号
- (BOOL)isValidCarNumber:(NSString *)textContent;

    //验证网址
- (BOOL)isValidUrl:(NSString *)textContent;

    //验证是否符合IP
- (BOOL)isValidIP:(NSString *)textContent;

    //验证身份证
- (BOOL)isValidIdCardNum:(NSString *)textContent;

    //工商税号
- (BOOL)isValidTaxNumber:(NSString *)textContent;

- (BOOL)isValidNumber:(NSString *)textContent;
- (BOOL)isValidZipCode:(NSString *)textContent;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithText:(NSString *)textContent
               minLenth:(NSInteger)minLenth
               maxLenth:(NSInteger)maxLenth
         containChinese:(BOOL)containChinese
    firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithText:(NSString *)textContent
               MinLenth:(NSInteger)minLenth
               maxLenth:(NSInteger)maxLenth
         containChinese:(BOOL)containChinese
          containDigtal:(BOOL)containDigtal
          containLetter:(BOOL)containLetter
  containOtherCharacter:(NSString *)containOtherCharacter
    firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
+(BOOL)contains:(NSString *)str conStr:(NSString*)str2;
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+(UIImage *) imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
@end
