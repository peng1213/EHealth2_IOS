//
//  UploadImageTableViewCell.h
//  EHealth2
//
//  Created by 刘祯 on 15/10/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptImgInfo.h"
#import "UploadImageViewController.h"
@interface UploadImageTableViewCell : UITableViewCell
@property (nonatomic, retain) UploadImageViewController* viewController;
@property (nonatomic, retain) NSIndexPath *indexPath;
-(void)setCellValue:(TReptImgInfo*) image;
@end
