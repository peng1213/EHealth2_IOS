//
//  Setting.h
//  EHealth2
//
//  Created by 刘祯 on 15/5/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSettingType) {
    Redirect,
    Switch
};

@interface Setting : NSObject
@property NSString *title;
@property NSString *subTitle;
@property NSString *image;
@property PHSettingType type;
@property NSString *name;
@property NSString *controller;

- (id)initWithParameters:(NSString*)nTitle
             andSubTitle:(NSString*)nSubTitle
                andImage:(NSString*)nImage
                 andType:(PHSettingType)nType
                 andName:(NSString*)nName
           andController:(NSString*)nController;

@end
