//
//  PicAddViewController.h
//  EhealthClient
//
//  Created by jiaojunkang on 14-4-26.
//  Copyright (c) 2014年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PicAddViewController : UIViewController<UIImagePickerControllerDelegate>
{
	BOOL isCamera;
	NSURL *targetURL;
}


@end
