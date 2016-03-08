//
//  ImageAddViewController.m
//  citic
//
//  Created by echoliu on 15-4-15.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ImageAddViewController.h"
#import "CommonUtil.h"
#import "UIWindow+YzdHUD.h"
#import "ZTAlertView.h"
#import "Pub.h"


@interface ImageAddViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectedIndexPath;
    NSMutableArray *images;
    UIActionSheet *sheet;
}
- (void)backToPreViewController;
-(NSString *)getFileName:(NSString *)fileName;
-(NSString *)timeStampAsString;
-(void)uploadImage;
@end

@implementation ImageAddViewController
@synthesize REPT_KY;
@synthesize typeInfo;



- (void)viewDidLoad
{
    [super viewDidLoad];
    targetURL = [[NSURL alloc] init];
    isCamera = FALSE;
    
    // 设置滚动自适应
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"影像上传"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    UIButton *responsibilityButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 64.0f, self.view.frame.size.width/2.0, 49)];
    [responsibilityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [responsibilityButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [responsibilityButton setTitle:@"拍照" forState:UIControlStateNormal];
    [responsibilityButton addTarget:self
                             action:@selector(startCamera)
                   forControlEvents:UIControlEventTouchUpInside];
    [responsibilityButton setBackgroundImage:[UIImage imageNamed:@"camera_select.png"] forState:UIControlStateNormal];
    [self.view addSubview:responsibilityButton];
    
    
    UIButton *xiangceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0, 64.0f, self.view.frame.size.width/2.0, 49)];
    [xiangceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangceButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [xiangceButton setTitle:@"从相册中选择" forState:UIControlStateNormal];
    [xiangceButton addTarget:self
                      action:@selector(selectFile)
            forControlEvents:UIControlEventTouchUpInside];
    [xiangceButton setBackgroundImage:[UIImage imageNamed:@"photo_select.png"] forState:UIControlStateNormal];
    [self.view addSubview:xiangceButton];
    
    images=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 113, self.view.frame.size.width, self.view.frame.size.height-113-50)];
    _tableView.separatorStyle = NO;
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
    
    
    
    //初始化底部的按钮
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height - 50),self.view.frame.size.width,50)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [self.view addSubview:bottomView];
    
    UIButton *quckClaimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2.0, 7.5, 140, 35)];
    [quckClaimsButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [quckClaimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quckClaimsButton setTitle:@"确认上传" forState:UIControlStateNormal];
    [quckClaimsButton addTarget:self
                         action:@selector(btnUploadOnclick)
               forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:quckClaimsButton];
}


//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源方法
#pragma mark 返回分组数


#pragma mark 返回每组行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return images.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImageView *image= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0, tableView.frame.size.width, 50)];
    [image setImage:[UIImage imageNamed:@"item_title_bg"]];
    [image setContentMode:UIViewContentModeScaleToFill];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.text=[NSString stringWithFormat:@"请上传%@",typeInfo.IMAGE_TYPE_DESC];
    
   UIButton* addBtn=[[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width-70, 10, 60, 30)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"common_blue_bg"] forState:UIControlStateNormal];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [addBtn addTarget:self action:@selector(addImg) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:addBtn];
    
    UIButton* editBtn=[[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width-140, 10, 60, 30)];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"common_exit_bg"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [editBtn addTarget:self action:@selector(editImg:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:editBtn];

    //headerLabel.text = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    
    [image addSubview:headerLabel];
    
    return image;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个对象，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.imageView.image=(UIImage*)images[indexPath.row];
    return cell;
}


#pragma mark - 代理方法
#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndexPath=indexPath;
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fileName = [[NSString alloc] init];
    
    if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
        fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
        //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
        fileName = [self getFileName:fileName];
    }
    else
    {
        fileName = [self timeStampAsString];
    }
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    
    [myDefault setValue:fileName forKey:@"fileName"];
    if (isCamera) //判定，避免重复保存
    {
        //保存到相册
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:nil];
        
    }
    
    [self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
    
}


-(void)saveImg:(UIImage *) image
{
    NSLog(@"Review Image");
    [images addObject:image];
    [_tableView reloadData];
}


-(NSString *)timeStampAsString
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE-MMM-d"];
    NSString *locationString = [df stringFromDate:nowDate];
    return [locationString stringByAppendingFormat:@".png"];
}

-(NSString *)getFileName:(NSString *)fileName
{
    NSArray *temp = [fileName componentsSeparatedByString:@"&ext="];
    NSString *suffix = [temp lastObject];
    
    temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
    
    NSString *name = [temp lastObject];
    
    name = [name stringByAppendingFormat:@".%@",suffix];
    return name;
}



-(void)startCamera
{
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
    camera.delegate = self;
    camera.allowsEditing = YES;
    isCamera = TRUE;
    
    //检查摄像头是否支持摄像机模式
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        NSLog(@"Camera not exist");
        return;
    }
    
    
    [self presentModalViewController:camera animated:YES];
    
}



-(void)selectFile
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //混合类型 photo + movie
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentModalViewController:picker animated:YES];
    
}

-(void)uploadImage
{
    
    
//    NSData *image = UIImagePNGRepresentation(self.IMG_SHOW.image);
//    
//    NSData *image = UIImageJPEGRepresentation(self.IMG_SHOW.image, 0.5);//(self.IMG_SHOW.image,);按照0.5比例压缩影像 并上传
//    int len=[image length];
//    if (len>100) {
//        [self.view.window showHUDWithText:@"上传中..." Type:ShowLoading Enabled:NO];
//        //上传
//        
//        NSURL *url =[ NSURL URLWithString : api_image_add];
//        
//        
//        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
//        NSString * filename=[myDefault objectForKey:@"fileName"];
//        [request setPostValue: @"IOS" forKey: @"PLATFORM"];
//        [request setPostValue: [NSString stringWithFormat:@"%d",len] forKey: @"IMAGE_SIZE"];
//        [request setPostValue:IMAGE_TYPE_DESC forKey: @"IMAGE_TYPE_DESC"];
//        [request setPostValue: self.REPT_KY forKey: @"REPT_KY"];
//        [request setPostValue:IMAGE_TYPE_CODE forKey: @"IMAGE_TYPE_CODE"];
//        [request setPostValue: filename forKey: @"UPLOAD_NAME"];
//        [request setData:image withFileName:filename andContentType:@"image/jpg" forKey: @"PHOTO" ];
//        NSString *ususname=[[ConfigTool Instance] getUserName];
//        [request setPostValue: ususname forKey: @"UPLOAD_USER"];
//        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
//        [request setPostValue: appDelegate.token forKey: @"token"];
//        [request setRequestMethod:@"POST"];
//        [request buildPostBody];
//        [request setDelegate:self];
//        [request startAsynchronous];
//        
//    }
//    else
//    {
//        [self.view.window showHUDWithText:@"请先选择照片或拍照！" Type:ShowPhotoNo Enabled:YES];
//    }
}


-(void)btnUploadOnclick
{
    
    IMAGE_TYPE_CODE = typeInfo.IMAGE_TYPE_CODE;
    IMAGE_TYPE_DESC=   typeInfo.IMAGE_TYPE_DESC;
    [self uploadImage];
    
}


//实现协议
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.view.window showHUDWithText:@"请求失败服务器忙！" Type:ShowPhotoNo Enabled:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"返回结果啦 %@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if (model.ResultCode==0) {
        
        [self.view.window showHUDWithText:@"上传成功！" Type:ShowPhotoYes Enabled:YES];
        
        
        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"上传成功，是否继续上传" delegate:self cancelButtonTitle:@"继续上传" destructiveButtonTitle:@"返回列表" otherButtonTitles: nil];
        [sheet showInView:self.view];
    }
    else
    {
        [self.view.window showHUDWithText:model.ResultDesc Type:ShowPhotoNo Enabled:YES];    }
    
}


-(void)saveImageToPhotos:(UIImage*)savedImage
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
        //        ClaimReportVisitListViewController  *loginView = [[ClaimReportVisitListViewController alloc]initWithNibName:@"ClaimReportVisitListViewController" bundle:nil];
        //
        //        loginView.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:loginView animated:NO];
        
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
    //                                                    message:msg
    //                                                   delegate:self
    //                                          cancelButtonTitle:@"确定"
    //                                          otherButtonTitles:nil];
    //    [alert show];
}



-(void)btnPopImageType
{
    //    PopImageTypeViewController  *popView = [[PopImageTypeViewController alloc]initWithNibName:@"PopImageTypeViewController" bundle:nil];
    //    //infoUserView.hidesBottomBarWhenPushed = YES;
    //    popView.title=@"影像类型";
    //    [self.navigationController pushViewController:popView animated:NO];
    
}


@end
