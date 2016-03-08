//
//  ImageInfo.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/1.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ImageInfo.h"

@implementation ImageInfo
@synthesize resultInfo;
@synthesize reportKey;
@synthesize imageTypeDesc;
@synthesize imageTypeCode;
@synthesize imageSize;
@synthesize uploadName;
@synthesize uploadUser;
@synthesize inputdata;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reportKey = @"";
        self.imageTypeDesc = @"";
        self.imageTypeCode = @"";
        self.imageSize = @"";
        self.uploadName = @"";
        self.uploadUser = @"";
        
    }
    return self;
}

- (void)dealloc
{
    self.reportKey = nil;
    self.imageTypeDesc = nil;
    self.imageTypeCode = nil;
    self.imageSize = nil;
    self.uploadName = nil;
    self.uploadUser = nil;
    self.inputdata = nil;
}

@end
