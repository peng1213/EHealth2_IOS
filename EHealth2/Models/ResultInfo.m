//
//  ResultInfo.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/30.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "ResultInfo.h"

@implementation ResultInfo

@synthesize resultCode;
@synthesize resultDesc;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resultCode = @"";
        self.resultDesc = @"";
    }
    return self;
}

- (void)dealloc
{
    self.resultCode = nil;
    self.resultDesc = nil;
}

@end
