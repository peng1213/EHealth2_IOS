//
//  RegisterInfo.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/27.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "RegisterInfo.h"

@implementation RegisterInfo
@synthesize resultInfo;
@synthesize registerID;
@synthesize registerName;
@synthesize userName;
@synthesize userPwd;
@synthesize contactNum;
@synthesize email;
@synthesize address;
@synthesize code;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.registerID = @"";
        self.registerName = @"";
        self.userName = @"";
        self.userPwd = @"";
        self.contactNum = @"";
        self.email = @"";
        self.address = @"";
        self.code = @"";
        
    }
    return self;
}

- (void)dealloc
{
    self.registerID = nil;
    self.registerName = nil;
    self.userName = nil;
    self.userPwd = nil;
    self.contactNum = nil;
    self.email = nil;
    self.address = nil;
    self.code = nil;
    
}

@end
