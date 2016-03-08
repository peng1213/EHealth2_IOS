//
//  ImageViewController.h
//  EhealthClient
//
//  Created by 刘祯 on 15/5/28.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ImageViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    ASIHTTPRequest *httpRequest_;
    UIActivityIndicatorView *activityIndicator;
    UIImage* image;
}

@property (nonatomic,retain) NSString * IMAGE_PATH;
@property (nonatomic,retain) UIDocumentInteractionController * docInteractionController;
@end