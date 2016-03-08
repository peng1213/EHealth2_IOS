//
//  ImageViewController.m
//  EhealthClient
//
//  Created by 刘祯 on 15/5/28.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ImageViewController.h"
#import "UIWindow+YzdHUD.h"

@interface ImageViewController ()
@end

@implementation ImageViewController
@synthesize IMAGE_PATH;
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
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightOnclick:)];//为导航栏添加右侧按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftOnclick:)];//为导航栏左侧添加系统自定义按钮
    
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
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
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
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:IMAGE_PATH]];
    [self.view addSubview: webView];
    [webView setScalesPageToFit:YES];
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
    [self DownImageAndShow];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(64, 0, self.view.frame.size.width, self.view.frame.size.height)];
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


/* 下载图片*/
-(void)DownImageAndShow
{
    if(IMAGE_PATH!=nil)
    {
        NSURL *url=[NSURL URLWithString:IMAGE_PATH];
        //实例化ASIHTTPRequest
        httpRequest_=[ASIHTTPRequest requestWithURL:url];
        [httpRequest_ setDelegate:self];
        //开始异步下载
        [httpRequest_ startAsynchronous];
        //开始活动指示器动画
        [activityIndicator startAnimating];
        [self.view.window showHUDWithText:@"下载中" Type:ShowLoading Enabled:NO];
        
    }
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    if (IMAGE_PATH!=nil) {
        UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self.view.window showHUDWithText:msg Type:ShowPhotoYes Enabled:YES];
}

#pragma mark ---异步下载完成

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.view.window showHUDWithText:@"请求失败" Type:ShowPhotoNo Enabled:YES];

}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSError *error=[request error];
    if (error) {
        
        [self.view.window showHUDWithText:@"下载失败，图片不存在" Type:ShowPhotoNo Enabled:YES];
    }
    else
    {
        image=[UIImage imageWithData:[request responseData]];
        [self saveImageToPhotos:image];
    }
    
    [activityIndicator stopAnimating];
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
