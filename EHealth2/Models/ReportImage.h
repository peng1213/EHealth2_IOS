//
//  ReportImage.h
//  EHealth2
//
//  Created by 刘祯 on 15/9/11.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TImgtypeConInfo.h"

@interface ReportImage : NSObject
@property (nonatomic, strong) TImgtypeConInfo *typeInfo;
@property (nonatomic, strong) NSMutableArray *images;
@property BOOL editing;
@end
