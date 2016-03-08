//
//  NSMutableArray+FieldConfig.h
//  EHealth2
//
//  Created by 刘祯 on 15/10/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldConfig.h"
@interface NSMutableArray(FieldConfig)
-(FieldConfig*)getConfigByName:(NSString*)fieldName;
@end
