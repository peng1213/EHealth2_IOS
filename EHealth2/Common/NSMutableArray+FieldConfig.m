//
//  NSMutableArray+FieldConfig.m
//  EHealth2
//
//  Created by 刘祯 on 15/10/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "NSMutableArray+FieldConfig.h"

@implementation NSMutableArray(FieldConfig)
-(FieldConfig*)getConfigByName:(NSString*)fieldName
{
    for (FieldConfig *config in self) {
        if([config.FIELD_NAME isEqualToString:fieldName])
            return config;
    }
    return nil;
}
@end
