//
//  ImageListTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TImgInfo.h"
@interface ImageListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *IMG_NAME;//赔案号
@property (nonatomic, strong) UILabel *IMG_TYPE_DESC;//状态


-(void) setCellValue:(TImgInfo* ) model;

@end
