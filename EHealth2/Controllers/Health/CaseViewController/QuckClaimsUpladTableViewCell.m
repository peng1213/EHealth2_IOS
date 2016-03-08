//
//  QuckClaimsUpladTableViewCell.m
//  citic
//
//  Created by echoliu on 15-4-15.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QuckClaimsUpladTableViewCell.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "CommonUtil.h"
#import "UIImageView+WebCache.h"
#import "ImageShowViewController.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "Pub.h"
#import "ToastView.h"
#import "SVProgressHUD.h"
#import "ImageAddViewController.h"
#import "QBImagePickerController.h"

@implementation QuckClaimsUpladTableViewCell
@synthesize imagesView;
@synthesize title;
@synthesize comment;
@synthesize addBtn;
@synthesize editBtn;
@synthesize nodata;
@synthesize images;
@synthesize type;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *titleBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 60.0)];
        [titleBg setImage:[UIImage imageNamed:@"mycase_topview_bg"]];
        [titleBg setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:titleBg];
        
        title=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
        [titleBg addSubview:title];
        comment=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 20)];
        comment.font=[UIFont systemFontOfSize:12];
        comment.textColor=[UIColor lightGrayColor];
        [titleBg addSubview:comment];
        
        addBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-70, 15, 60, 30)];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"common_blue_bg"] forState:UIControlStateNormal];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [addBtn addTarget:self action:@selector(addImg:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
        
        editBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-140, 15, 60, 30)];
        [editBtn setBackgroundImage:[UIImage imageNamed:@"common_exit_bg"] forState:UIControlStateNormal];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [editBtn addTarget:self action:@selector(editImg:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:editBtn];
        
        nodata=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 60, self.frame.size.width, 100)];
        nodata.textAlignment=NSTextAlignmentCenter;
        nodata.font=[UIFont systemFontOfSize:12];
        nodata.textColor=[UIColor lightGrayColor];
        nodata.text=@"未上传该影像";
        [self.contentView addSubview:nodata];
        
        imagesView = [[GMGridView alloc] initWithFrame:CGRectMake(0.0, 60, self.frame.size.width, 100)];
        imagesView.style = GMGridViewStyleSwap;
        imagesView.backgroundColor=[UIColor clearColor];
        imagesView.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
        NSInteger spacing = 15;
        imagesView.itemSpacing = spacing;
        imagesView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
        imagesView.actionDelegate = self;
        imagesView.transformDelegate = self;
        imagesView.dataSource = self;
        imagesView.centerGrid=NO;
        imagesView.scrollEnabled=NO;
        [self.contentView addSubview:imagesView];
        [self.contentView setUserInteractionEnabled:YES];
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"添加方式"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"拍照", @"从相册选择", nil];
        uploadList=[[NSMutableArray alloc]init];
    }
    return self;
}


-(void)setCellValue:(NSMutableArray*) model type:(TImgtypeConInfo*)typeInfo viewController:(QuckClaimsUploadViewController*)vc;
{
    images=model;
    type=typeInfo;
    viewController=vc;
    [title setText:typeInfo.IMAGE_TYPE_DESC];
    if(images.count==0)
        [nodata setHidden:NO];
    else
        [nodata setHidden:YES];
    CGFloat height=100;
    if(images.count==0)
    {
        height=100;
    }
    else if(images.count%4==0)
    {
        height= 20+80*(images.count/4);
    }
    else
    {
        height= 20+80*(images.count/4+1);
    }
    CGRect frame= imagesView.frame;
    frame.size.height=height;
    imagesView.frame=frame;
    
    [imagesView reloadData];
    
    if([type.REQUIRED_COUNT isEqualToString:@"1"])
        comment.text=@"只能上传一张";
    else if([type.REQUIRED_COUNT isEqualToString:@"*"])
        comment.text=@"可上传任意张";
    else if([type.REQUIRED_COUNT isEqualToString:@">=1"])
        comment.text=@"至少上传一张";
    
    if([viewController.operType isEqualToString:@"read"])
    {
        [addBtn setHidden:YES];
        [editBtn setHidden:YES];
        [nodata setText:@"未上传该影像"];
    }
    else
    {
        [addBtn setHidden:NO];
        [editBtn setHidden:NO];
        [nodata setText:@"请点击添加上传影像"];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button %d", buttonIndex);
    if(buttonIndex==0)
    {
        //拍照
        [self startCamera];
    }
    else if(buttonIndex==1)
    {
        //从相册选择
        [self selectFile];
    }
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
    
    
    [viewController presentModalViewController:camera animated:YES];
    
}


-(void)selectFile
{
    //    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
    //    picker.allowsEditing = YES;
    //
    //    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    //    {
    //        //混合类型 photo + movie
    //        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //    }
    //    [viewController presentModalViewController:picker animated:YES];
    
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.mediaType=QBImagePickerMediaTypeImage;
    imagePickerController.assetCollectionSubtypes = @[
                                                      @(PHAssetCollectionSubtypeSmartAlbumUserLibrary), // Camera Roll
                                                      @(PHAssetCollectionSubtypeAlbumMyPhotoStream), // My Photo Stream
                                                      @(PHAssetCollectionSubtypeSmartAlbumPanoramas), // Panoramas
                                                      ];
    
    [viewController presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for (PHAsset *asset in assets) {
        PHContentEditingInputRequestOptions *editOptions = [[PHContentEditingInputRequestOptions alloc]init];
        editOptions.networkAccessAllowed = YES;
        [asset requestContentEditingInputWithOptions:editOptions completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
            TReptImgInfo *img=[[TReptImgInfo alloc]init];
            NSData *imageData=  [NSData dataWithContentsOfURL:contentEditingInput.fullSizeImageURL];
            UIImage *image = [UIImage imageWithData: imageData];
            img.IMAGE=image;
            img.isUploading=NO;
            [images addObject:img];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"RegisterUploadNotification"
             object:nil];
        }];
    }
    [SVProgressHUD showWithStatus:@"上传中"];
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
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
    
    TReptImgInfo *img=[[TReptImgInfo alloc]init];
    img.IMAGE=image;
    img.isUploading=NO;
    [images addObject:img];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterUploadNotification"
     object:nil];
    //[self reload];
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



-(void)addImg:(UIButton *)sender
{
    int index = sender.tag - 100;
    NSLog(@"Button %d", index);
    [sheet showInView:self.contentView];
    //    ImageAddViewController *picView=[[ImageAddViewController alloc]init];
    //    [picView setREPT_KY:[NSString stringWithFormat:@"%d", viewController.currentCaseInfo.REPT_KY]];
    //    [picView setTypeInfo:type];
    //    [viewController.navigationController pushViewController:picView animated:YES];
}

-(void)editImg:(UIButton*)sender
{
    int index = sender.tag;
    NSLog(@"Button %d", index);
    if (!imagesView.editing) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [imagesView setEditing:!imagesView.editing animated:NO];
    [imagesView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
}
//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [images count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(60, 60);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"del.png"];
        cell.deleteButtonOffset = CGPointMake(-10, -10);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TReptImgInfo * img= (TReptImgInfo *)[images objectAtIndex:index];
    
    CGRect imageFrame=CGRectMake(0, 0, size.width, size.height);
    UIImageView *image=[[UIImageView alloc]initWithFrame:imageFrame];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    image.clipsToBounds = YES;
    
    image.tag=1;
    UILabel* uploadProgress=[[UILabel alloc]initWithFrame:imageFrame];
    uploadProgress.backgroundColor=[CommonUtil getColor:@"767676" withAlpha:0.5f];
    uploadProgress.textAlignment=NSTextAlignmentCenter;
    uploadProgress.text=@"上传中";
    uploadProgress.textColor=[UIColor whiteColor];
    uploadProgress.font=[UIFont systemFontOfSize:12];
    uploadProgress.tag=2;
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:uploadProgress];
    if(img.IMG_KY==nil&&!img.isUploading)
    {
        [img setIsUploading:YES];
        image.image=img.IMAGE;
        [uploadProgress setHidden:NO];
        [self uploadImage:img index:index];
    }
    else
    {
        [img setIsUploading:NO];
        if(img.IMAGE_URL_SYNC!=nil&&![img.IMAGE_URL_SYNC isEqualToString:@""])
            [image sd_setImageWithURL:[NSURL URLWithString:img.IMAGE_URL_SYNC] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        else if(img.IMAGE_PATH!=nil&&![img.IMAGE_PATH isEqualToString:@""])
            [image sd_setImageWithURL:[NSURL URLWithString:img.IMAGE_PATH] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        [uploadProgress setHidden:YES];
    }
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    TReptImgInfo * model=model=(TReptImgInfo*)images[position];
    ImageShowViewController *cellView=[[ImageShowViewController alloc]init];
    if(model.IMAGE_URL_SYNC!=nil&&![model.IMAGE_URL_SYNC isEqualToString:@""])
        cellView.imageURL=[[NSURL alloc]initWithString:model.IMAGE_URL_SYNC];
    else
        cellView.imageURL=[[NSURL alloc]initWithString:model.IMAGE_PATH];
    [viewController.navigationController pushViewController:cellView animated:YES];
    NSLog(@"Did tap at index %d", position);
}
- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    if([[images objectAtIndex:index] IMG_KY] !=nil)
    {
        NSURL *url=[[NSURL alloc] initWithString:api_case_image_delete];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[(TReptImgInfo*)images[index] IMG_KY] forKey:@"IMG_KY"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"delete"] forKey:@"type"]];
        [request setDelegate:self];
        [request setTimeOutSeconds:60];
        //设定同步还是异步方式
        deleteIndex=index;
        [request startAsynchronous];
        [SVProgressHUD show];
    }
    else
    {
        if([(TReptImgInfo*)images[index] IMG_KY]==nil)
        {
            [viewController.toastView toastTipsWithTips:@"图像正在上传，无法删除！"];
        }
    }
    
}
//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [toastView toastTipsWithTips:@"请检查网络是否正确！"];
    [self removeUploadList:request.tag];
    if(uploadList.count==0)
        [SVProgressHUD dismiss];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    
    TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    
    if(result.ResultCode==0)
    {
        NSString *type=(NSString*) (request.userInfo[@"type"]);
        if([type isEqualToString:@"upload"])
        {
            [self removeUploadList:request.tag];
            TReptImgInfo* img=[[JsonTool defaultTool]getTReptImgInfo:request.responseString withKey:@"model"];
            [images replaceObjectAtIndex:request.tag withObject:img];
            [self reload];
            if(uploadList.count==0)
                [SVProgressHUD dismiss];
        }
        else if([type isEqualToString:@"delete"])
        {
            [images removeObjectAtIndex:deleteIndex];
            [self reload];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"RegisterUploadNotification"
             object:nil];
            [SVProgressHUD dismiss];
        }
        
    }
    
}

-(void)addUploadList:(NSInteger)index
{
    NSNumber *num = [NSNumber numberWithInt:index];
    [uploadList addObject:num];
}

-(void)removeUploadList:(NSInteger)index
{
    for (int i=0; i<uploadList.count; i++) {
        NSNumber *num=uploadList[i];
        if(num.integerValue==index)
            [uploadList removeObject:num];
    }
}

-(BOOL)containsUploadList:(NSInteger)index
{
    for (int i=0; i<uploadList.count; i++) {
        NSNumber *num=uploadList[i];
        if(num.integerValue==index)
            return YES;
    }
    return NO;
}

-(void)uploadImage:(TReptImgInfo*)imageInfo index:(int)index
{
    if(![self containsUploadList:index])
    {
        [self addUploadList:index];
        UIImage *i=imageInfo.IMAGE;
        NSData *image = UIImageJPEGRepresentation(imageInfo.IMAGE, 0.5);//(self.IMG_SHOW.image,);按照0.5比例压缩影像 并上传
        int len=[image length];
        if (len>100) {
            NSURL *url =[ NSURL URLWithString : api_image_add];
            ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
            NSString * filename=[myDefault objectForKey:@"fileName"];
            [request setPostValue: @"IOS" forKey: @"PLATFORM"];
            [request setPostValue: [NSString stringWithFormat:@"%d",len] forKey: @"IMAGE_SIZE"];
            [request setPostValue:type.IMAGE_TYPE_DESC forKey: @"IMAGE_TYPE_DESC"];
            [request setPostValue: [NSString stringWithFormat:@"%d",viewController.currentCaseInfo.REPT_KY]  forKey: @"REPT_KY"];
            [request setPostValue:type.IMAGE_TYPE_CODE forKey: @"IMAGE_TYPE_CODE"];
            [request setPostValue: filename forKey: @"UPLOAD_NAME"];
            [request setData:image withFileName:filename andContentType:@"image/jpg" forKey: @"PHOTO" ];
            NSString *ususname=[[ConfigTool Instance] getUserName];
            [request setPostValue: ususname forKey: @"UPLOAD_USER"];
            AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
            [request setPostValue: appDelegate.token forKey: @"token"];
            [request setRequestMethod:@"POST"];
            request.tag=index;
            [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"upload"] forKey:@"type"]];
            [request buildPostBody];
            request.delegate=self;
            request.showAccurateProgress=YES;
            [request startAsynchronous];
        }
    }
}

-(void)reload
{
    [imagesView reloadData];
    if(images.count==0)
        [nodata setHidden:NO];
    else
        [nodata setHidden:YES];
}

- (void)dealloc
{
    
}

@end
