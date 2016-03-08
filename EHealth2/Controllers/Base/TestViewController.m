//
//  TestViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/10/10.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController


-(void)loadView
{
    [super loadView];
    self.title=@"test";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadContentView];
}

-(void)loadContentView
{
    [super loadContentView];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    image.image=[UIImage imageNamed:@"login_background.png"];
    image.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:image];
    [self performSelector:@selector(loadErrorView:) withObject:@"网络错误网络错误网络错误网络错误网络错误！" afterDelay:2.0f];
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
