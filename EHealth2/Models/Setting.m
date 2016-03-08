//
//  Setting.m
//  EHealth2
//
//  Created by 刘祯 on 15/5/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "Setting.h"

@implementation Setting
@synthesize title;
@synthesize subTitle;
@synthesize image;
@synthesize type;
@synthesize controller;
@synthesize name;

- (id)initWithParameters:(NSString*)nTitle
             andSubTitle:(NSString*)nSubTitle
                andImage:(NSString*)nImage
                 andType:(PHSettingType)nType
                 andName:(NSString *)nName
           andController:(NSString *)nController

{
    Setting *setting=[[Setting alloc]init];
    setting.title=nTitle;
    setting.subTitle=nSubTitle;
    setting.image=nImage;
    setting.type=nType;
    setting.name=nName;
    setting.controller=nController;
    return setting;
}
@end
