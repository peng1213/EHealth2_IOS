//
//  UploadTableViewCell.h
//  EHealth2
//
//  Created by 刘祯 on 15/12/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptImgInfo.h"

@interface UploadTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView* imageIcon;
@property (nonatomic, retain) UILabel* imageName;
@property (nonatomic, retain) UILabel* title;
@property (nonatomic, retain) UILabel* subTitle;
@property (nonatomic, retain) UILabel* maskView;
@property TReptImgInfo* imageInfo;
@end
