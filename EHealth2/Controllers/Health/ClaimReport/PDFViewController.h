//
//  PDFViewController.h
//  EhealthClient
//
//  Created by Mac on 15/5/18.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController<UIWebViewDelegate,UIDocumentInteractionControllerDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic,retain) NSString * PDF_PATH;
@property (nonatomic,retain) UIDocumentInteractionController * docInteractionController;
@end
