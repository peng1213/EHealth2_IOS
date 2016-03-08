//
//  LaunchViewController.h
//  EHealth2
//
//  Created by 刘祯 on 15/8/26.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface LaunchViewController : UIViewController
{
    
        NSString* compID;
        NSString* appName;
    NSString*appID;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end
