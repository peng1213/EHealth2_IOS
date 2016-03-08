//
//  BaseViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/4.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "BaseViewController.h"
#import "CommonUtil.h"

@interface BaseViewController ()
@end

@implementation BaseViewController
@synthesize navigaterView;
@synthesize contentView;
@synthesize nodataView;
@synthesize errorView;
@synthesize title;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[CommonUtil getColor:@"F0F0F0" withAlpha:1.0];
    navigaterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigaterView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigaterView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigaterView addSubview:backButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:title];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigaterView addSubview:titleLable];
    if(contentView==nil)
        contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    if(nodataView==nil)
        nodataView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    if(errorView==nil)
        errorView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:contentView];
    [self.view addSubview:nodataView];
    [self.view addSubview:errorView];
}

-(void)clearAllView
{
    NSArray *views = self.contentView.subviews;
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    NSArray *views2 = self.nodataView.subviews;
    for(UIView* view in views2)
    {
        [view removeFromSuperview];
    }
    
    NSArray *views3 = self.errorView.subviews;
    for(UIView* view in views3)
    {
        [view removeFromSuperview];
    }
}

-(void)loadContentViewk
{
    [self clearAllView];
}

-(void)loadNodataView
{
    [self clearAllView];
    
    UIImageView *notice=[[UIImageView alloc]initWithFrame:CGRectMake(nodataView.frame.size.width/2-32, nodataView.frame.size.height/2-50, 64, 64)];
    [notice setImage:[UIImage imageNamed:@"icon_info.png"]];
    [notice setContentMode:UIViewContentModeScaleAspectFit];
    [nodataView addSubview:notice];
    
    UILabel *message=[[UILabel alloc]initWithFrame:CGRectMake(0, notice.frame.origin.y+notice.frame.size.height+10, nodataView.frame.size.width, 30)];
    message.textAlignment=UITextAlignmentCenter;
    message.font=[UIFont systemFontOfSize:12];
    message.text=@"暂无数据";
    [nodataView addSubview:message];
}

-(void)loadErrorView:(NSString*)errorMsg
{
    [self clearAllView];
    
    UIImageView *notice=[[UIImageView alloc]initWithFrame:CGRectMake(errorView.frame.size.width/2-32, errorView.frame.size.height/2-100, 64, 64)];
    [notice setImage:[UIImage imageNamed:@"icon_error.png"]];
    [notice setContentMode:UIViewContentModeScaleAspectFit];
    [errorView addSubview:notice];
    
    UILabel *message=[[UILabel alloc]initWithFrame:CGRectMake(0, notice.frame.origin.y+notice.frame.size.height+10, errorView.frame.size.width, 30)];
    message.textAlignment=UITextAlignmentCenter;
    message.text=errorMsg;
    message.font=[UIFont systemFontOfSize:12];
    [errorView addSubview:message];
    
    UIButton *reloadButton=[[UIButton alloc]initWithFrame:CGRectMake(errorView.frame.size.width/2-80, message.frame.origin.y+message.frame.size.height+10, 160 , 40)];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadButton setContentMode:UIViewContentModeScaleAspectFit];
    [reloadButton setBackgroundImage:[UIImage imageNamed:@"claims_button_bg.png"] forState:UIControlStateNormal];
    [reloadButton addTarget:self
                   action:@selector(loadContentView)
         forControlEvents:UIControlEventTouchUpInside];
    [errorView addSubview:reloadButton];
    
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
