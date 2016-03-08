//
//  ImageAddViewController.h
//  citic
//
//  Created by echoliu on 15-4-15.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TReptCaseInfo.h"
#import "TImgtypeConInfo.h"


@interface ImageAddViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate>
{
    BOOL isCamera;
    NSURL *targetURL;
    NSString *IMAGE_TYPE_DESC;
    NSString *IMAGE_TYPE_CODE;
}
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,retain) NSString *REPT_KY;
@property (nonatomic, strong) TImgtypeConInfo *typeInfo;


@end
