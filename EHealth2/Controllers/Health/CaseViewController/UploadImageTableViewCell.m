//
//  UploadImageTableViewCell.m
//  EHealth2
//
//  Created by 刘祯 on 15/10/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import "UploadImageTableViewCell.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "CommonUtil.h"
#import "UIImageView+WebCache.h"
#import "ImageShowViewController.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "Pub.h"
#import "SVProgressHUD.h"
#import "ImageAddViewController.h"
#import "QBImagePickerController.h"
#import "ProgressView.h"


@interface UploadImageTableViewCell ()
@property (nonatomic, retain) UIImageView* imageIcon;
@property (nonatomic, retain) UILabel* imageName;
@property (nonatomic, retain) UILabel* title;
@property (nonatomic, retain) UILabel* subTitle;
@property (nonatomic, retain) UILabel* maskView;
@end

@implementation UploadImageTableViewCell
@synthesize imageIcon;
@synthesize imageName;
@synthesize title;
@synthesize subTitle;
@synthesize viewController;
@synthesize indexPath;
@synthesize maskView;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageIcon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        imageIcon.contentMode=UIViewContentModeScaleAspectFill;
        imageIcon.clipsToBounds = YES;
        [self.contentView addSubview:imageIcon];
        
        imageName=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 200, 20)];
        imageName.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:imageName];
        
        title=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 40, 20)];
        [self.contentView addSubview:title];
        
        subTitle=[[UILabel alloc]initWithFrame:CGRectMake(320-60, 20, 50, 20)];
        subTitle.font=[UIFont systemFontOfSize:10];
        subTitle.textColor=[UIColor grayColor];
        subTitle.textAlignment=UITextAlignmentCenter;
        [self.contentView addSubview:subTitle];
        
        maskView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        maskView.backgroundColor=[CommonUtil getColor:@"686a69" withAlpha:0.7];
        maskView.textAlignment=UITextAlignmentCenter;
        maskView.font=[UIFont systemFontOfSize:12];
        maskView.textColor=[UIColor whiteColor];
        [self.contentView addSubview:maskView];
        
    }
    return self;
}

-(void)setCellValue:(TReptImgInfo*) image
{
    maskView.hidden=YES;
    if(image.IMAGE==nil)
    {
        if(image.IMAGE_URL_SYNC ==nil||[image.IMAGE_URL_SYNC isEqualToString:@""])
        {
            [imageIcon sd_setImageWithURL:[NSURL URLWithString:image.IMAGE_PATH]];
        }
        else
        {
            [imageIcon sd_setImageWithURL:[NSURL URLWithString:image.IMAGE_URL_SYNC]];
        }
    }
    else
        imageIcon.image=[UIImage imageWithData:image.IMAGE];
    imageName.text=image.UPLOAD_NAME;
    if(image.request!=nil&&!image.request.complete)
    {
        subTitle.hidden=NO;
    }
    else
    {
        subTitle.hidden=YES;
    }
    
    if(image.isUploading)
    {
        maskView.hidden=NO;
        maskView.text=@"上传中";
    }
    if(image.failed)
    {
        maskView.hidden=NO;
        maskView.text=@"上传失败";
    }
}

- (void)dealloc
{
    
}

@end
