//
//  PDFViewController.m
//  EhealthClient
//
//  Created by Mac on 15/5/18.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "PDFViewController.h"
#import <UIKit/UIKit.h>
#import "UIWindow+YzdHUD.h"

@interface PDFViewController ()

@end

@implementation PDFViewController
@synthesize PDF_PATH;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*01 屏蔽导航栏的遮挡效果 only for ios 7 and up*/
#ifdef IOS7_SDK_AVAILABLE
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
#endif
    
    /*04 增加保存图片按钮*/
    /*导航按钮的处理*/
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(leftOnclick:)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 27.0, 40.0, 30.0)];
    [rightButton setTitle:@"打开" forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(rightOnclick:)
          forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:rightButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"查看"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:PDF_PATH]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}


//没有完成想后退吗？
-(void)leftOnclick:(id)paramSender
{
    [webView stopLoading];
    [self.navigationController popViewControllerAnimated:NO];
}

//保存PDF
-(void)rightOnclick:(id)paramSender
{
    
    NSError *err;
    //定义url
    NSString *fileName=[PDF_PATH lastPathComponent];
    //构建NSURL
    NSURL *fileUrl=[NSURL URLWithString:PDF_PATH];
    
    
    
    
    //构建nsurlrequest
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:fileUrl];
    //建立连接
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    if (data.length>0) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        //当数据写入的时候
        if ([data writeToFile:writableDBPath atomically:YES]) {
            [ self setupDocumentControllerWithURL :[NSURL fileURLWithPath:writableDBPath]];
            
            CGRect rect = CGRectMake ( 0 , 0 , 400 , 100 );
            
            // [self.docInteractionController presentOptionsMenuFromRect:rect inView:self.view  animated:YES];//包含快速预览菜单
            
            [ self . docInteractionController presentOpenInMenuFromRect :rect inView : self . view animated : YES ]; //不包含包含快速预览菜单
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        }
    }
}

// 创建

- ( void )setupDocumentControllerWithURL:( NSURL *)url
{
    if ( self.docInteractionController == nil ){
        
        self.docInteractionController = [ UIDocumentInteractionController interactionControllerWithURL :url];
        self . docInteractionController.delegate = self ;
        
    }
    
    else {
        
        self . docInteractionController . URL = url;
        
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

- ( UIViewController *)documentInteractionControllerViewControllerForPreview:( UIDocumentInteractionController *)interactionController{
    
    return self ;
    
}

// 不显示 copy print

- ( BOOL )documentInteractionController:( UIDocumentInteractionController *)controller canPerformAction:( SEL )action{
    
    return NO ;
    
}

- ( BOOL )documentInteractionController:( UIDocumentInteractionController *)controller performAction:( SEL )action{
    
    return NO ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
