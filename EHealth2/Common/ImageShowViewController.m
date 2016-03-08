//
//  ImageShowViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/9/21.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "ImageShowViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"

@interface ImageShowViewController ()
{
    UIScrollView *scrollView;
    UIImageView *imageView;
}
@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    scrollView.maximumZoomScale=2.0;//图片的放大倍数
    scrollView.minimumZoomScale=1.0;//图片的最小倍率
    scrollView.contentSize=scrollView.bounds.size;
    scrollView.delegate=self;
    
    scrollView.showsVerticalScrollIndicator=false;
    scrollView.showsHorizontalScrollIndicator=false;
    imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.contentMode= UIViewContentModeScaleAspectFit;
    if(self.imageURL!=nil)
        [imageView setImageWithURL:self.imageURL placeholderImage:[UIImage imageNamed:@"image_place"]];
    else if(self.image!=nil)
        [imageView setImage:self.image];
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    imageView.userInteractionEnabled=YES;//注意:imageView默认是不可以交互,在这里设置为可以交互
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    tap.numberOfTapsRequired=1;//单击
    tap.numberOfTouchesRequired=1;//单点触碰
    [imageView addGestureRecognizer:tap];
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired=2;//避免单击与双击冲突
    [tap requireGestureRecognizerToFail:doubleTap];
    [imageView addGestureRecognizer:doubleTap];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 27.0, 60.0, 30.0)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(saveImage)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:saveButton];
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"图像查看"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];

    
    
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveImage
{
    if(imageView.image!=nil)
        [self saveImageToPhotos:imageView.image];
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView  //委托方法,必须设置  delegate
{
    return imageView;//要放大的视图
}

-(void)doubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    if(scrollView.zoomScale == 1){
        float newScale = [scrollView zoomScale] *2;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [scrollView zoomToRect:zoomRect animated:YES];
    }else{
        float newScale = [scrollView zoomScale]/2;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [scrollView zoomToRect:zoomRect animated:YES];
    }

}

-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [scrollView frame].size.height/scale;
    zoomRect.size.width = [scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}




- (IBAction)tapImage:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];//单击图像,关闭图片详情(当前图片页面)
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
