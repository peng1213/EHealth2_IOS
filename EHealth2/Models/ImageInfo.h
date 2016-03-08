//
//  ImageInfo.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/1.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultInfo.h"

@interface ImageInfo : NSObject

@property (nonatomic, strong) ResultInfo *resultInfo;
@property (nonatomic, strong) NSString *reportKey;//报案ky
@property (nonatomic, strong) NSString *imageTypeDesc;//影像类型描述
@property (nonatomic, strong) NSString *imageTypeCode;//影像类型代码
@property (nonatomic, strong) NSString *imageSize;//影像大小
@property (nonatomic, strong) NSString *uploadName;//上传影像名
@property (nonatomic, strong) NSString *uploadUser;//上传人
@property (nonatomic, strong) NSData *inputdata;//影像流文件

@end
