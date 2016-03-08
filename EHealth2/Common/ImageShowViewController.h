//
//  ImageShowViewController.h
//  EHealth2
//
//  Created by 刘祯 on 15/9/21.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageShowViewController : UIViewController<UIScrollViewDelegate>
@property(strong,nonatomic)NSURL *imageURL;
@property(strong,nonatomic)UIImage *image;
@end
