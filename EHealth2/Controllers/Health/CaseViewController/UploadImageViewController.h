//
//  UploadImageViewController.h
//  EHealth2
//
//  Created by 刘祯 on 15/10/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptCaseInfo.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface UploadImageViewController : UIViewController
@property NSString *operType;
@property BOOL *editing;
@property (nonatomic, strong) TReptCaseInfo *currentCaseInfo;
@property (nonatomic, strong) NSMutableArray * imageDics;
@end
