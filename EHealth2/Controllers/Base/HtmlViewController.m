//
//  HtmlViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/10/23.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "HtmlViewController.h"
#import "SVProgressHUD.h"
@interface HtmlViewController ()
{
    UIWebView *webView;
    UILabel *titleLable;
    UIToolbar *toolbar;
    UIBarButtonItem * back;
    UIBarButtonItem * forward;
}
@end

@implementation HtmlViewController
@synthesize URL;
@synthesize TITLE;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,10.0f,self.view.frame.size.width-80,64.0f)];
    [titleLable setText:TITLE==nil?@"":TITLE];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    toolbar.barStyle=UIBarStyleDefault;
    back=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"goBack.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    back.width=50;
    forward=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"goForward.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(forawrd)];
    forward.width=50;
      UIBarButtonItem * reload=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"reload.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(refresh)];
    reload.width=50;
    [toolbar setItems:[NSArray arrayWithObjects:back,forward,reload, nil]];
    [self.view addSubview:toolbar];
    
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    webView.scalesPageToFit =YES;
    webView.delegate=self;
    
    [self.view addSubview:webView];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:URL]];
    [webView loadRequest:request];
}

-(void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([webView canGoBack])
    {
        back.enabled=YES;
    }
    else
    {
        back.enabled=NO;
    }
    
    if([webView canGoForward])
    {
        forward.enabled=YES;
    }
    else
    {
        forward.enabled=NO;
    }

    if(TITLE==nil)
        titleLable.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)forawrd {
    if([webView canGoBack])
    {
        back.enabled=YES;
    }
    else
    {
        back.enabled=NO;
    }
    
    if([webView canGoForward])
    {
        forward.enabled=YES;
    }
    else
    {
        forward.enabled=NO;
    }
    [webView goForward];
}

- (void)back {
    if([webView canGoBack])
    {
        back.enabled=YES;
    }
    else
    {
        back.enabled=NO;
    }
    
    if([webView canGoForward])
    {
        forward.enabled=YES;
    }
    else
    {
        forward.enabled=NO;
    }
    [webView goBack];
}

-(void)refresh
{
    [webView reload];
}

-(void)stop
{
    [webView stopLoading];
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
